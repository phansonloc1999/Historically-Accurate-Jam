local Result = require 'src.result.result'

local BattleHero = require 'src.battle.battleHeroes.battleHero'
local EffectManager = require 'src.battle.effectManager'

local Battle = {}

function Battle:enter(from, allies, enemies, isReplay)
	self.allies = {}
	for i = 1, #allies do
		local ally = allies[i]
		table.insert(self.allies,
				BattleHero('allies', ally.gridIndex, ally.hero.stats, ally.hero.upgrades, ally.hero.skill, ally.hero.sprite))
	end
	
	self.enemies = {}
	for i = 1, #enemies do
		local enemy = enemies[i]
		table.insert(self.enemies,
				BattleHero('enemies', enemy.gridIndex, enemy.hero.stats, enemy.hero.upgrades, enemy.hero.skill, enemy.hero.sprite))
	end
	
	self.battleData = {allies = allies, enemies = enemies}
	self.isReplay = isReplay or false
	
	self.effectManager = EffectManager()

	Audio.musics.battle:play()
end

function Battle:update(dt)
	if (#self.enemies <= 0) then
		GS.switch(Result, "allies", self.battleData, self.isReplay)
	elseif (#self.allies <= 0) then
		GS.switch(Result, "enemies", self.battleData, self.isReplay)
	end

	for i, ally in ipairs(self.allies) do
		ally:update(dt)
	end
	for i, enemy in ipairs(self.enemies) do
		enemy:update(dt)
	end

	for index, ally in ipairs(self.allies) do
		if (ally.isDead) then
			table.remove(self.allies, index)
		end
	end
	
	for index, enemy in ipairs(self.enemies) do
		if (enemy.isDead) then
			table.remove(self.enemies, index)
		end
	end

	if (love.keyboard.isDown("escape")) then
		GS.switch(Main)
	end
	
	self.effectManager:update(dt)
end

function Battle:draw()
	for i, ally in ipairs(self.allies) do
		local x, y = self:getWorldPosFromGridIndex('allies', ally.gridIndex)
		ally:draw(x, y)
	end
	for i, enemy in ipairs(self.enemies) do
		local x, y = self:getWorldPosFromGridIndex('enemies', enemy.gridIndex)
		enemy:draw(x, y)
	end

	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(Fonts.main.title)
	love.graphics.print("Press escape to back to Main")
	
	self.effectManager:draw()
end


function Battle:getWorldPosFromGridIndex(side, gridIndex)
	local mul, ox
	if side == 'allies' then
		mul, ox = 1, 100
	elseif side == 'enemies' then
		mul, ox = -1, 640
	end
	
	local gx = (gridIndex - 1) % 3
	local gy = (gridIndex - gx) / 3 - 1
	
	return ox + gx * 96 * mul, 180 + gy * 96
end

function Battle:exit()
	Audio.musics.battle:stop()
end

return Battle
