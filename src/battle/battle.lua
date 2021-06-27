local Result = require 'src.result.result'

local BattleHero = require 'src.battle.battleHeroes.battleHero'
local EffectManager = require 'src.battle.effectManager'
local TeamHealthBar = require 'src.battle.teamHealthBar'

local Battle = {}

function Battle:enter(from, allies, enemies, isReplay, oldReward, levelIndex)
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
	
	self.battleData = {allies = allies, enemies = enemies, level = levelIndex}
	self.isReplay = isReplay or false
	self.oldReward = oldReward
	
	self.teamHealthBar = TeamHealthBar(self.allies, self.enemies)
	self.effectManager = EffectManager()

	self.timer = Timer.new()

	Audio.musics.battle:play()
end

function Battle:update(dt)
	self.timer:update(dt)

	if (#self.enemies <= 0) then
		self.timer:after(1, function() GS.switch(Result, "allies", self.battleData, self.isReplay, self.oldReward) end)
		
	elseif (#self.allies <= 0) then
		self.timer:after(1, function() GS.switch(Result, "enemies", self.battleData, self.isReplay, self.oldReward) end)
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
	love.graphics.setColor(0.8, 0.8, 0.8)
	love.graphics.draw(Sprites.backgrounds[1], 0, 0, 0, 2, 2)

	for i, ally in ipairs(self.allies) do
		local x, y = self:getWorldPosFromGridIndex('allies', ally.gridIndex)
		ally:draw(x, y)
	end
	for i, enemy in ipairs(self.enemies) do
		local x, y = self:getWorldPosFromGridIndex('enemies', enemy.gridIndex)
		enemy:draw(x, y)
	end

	love.graphics.setColor(0.92, 0.92, 0.92)
	love.graphics.setFont(Fonts.main.heroSelectionSmall)
	love.graphics.print("Press escape to exit", 4, 522)
	
	self.effectManager:draw()
	
	self.teamHealthBar:draw()
end


function Battle:getWorldPosFromGridIndex(side, gridIndex)
	local mul, ox
	if side == 'allies' then
		mul, ox = 1, 72
	elseif side == 'enemies' then
		mul, ox = -1, 680
	end
	
	local gx = (gridIndex - 1) % 3
	local gy = (gridIndex - gx) / 3 - 1
	
	return ox + gx * 96 * mul, 236 + gy * 96
end

function Battle:leave()
	Audio.musics.battle:stop()
end

return Battle
