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
	
	
	-------------------------------
	
	
	self.isEnded = false
	self.isDelayEnded = falses
	self.suit = Suit.new()
	
	self.winner = nil
	self.resultScreen = {}
	
	self.isReplay = isReplay
end

function Battle:update(dt)
	if not self.isEnded then
		if (#self.enemies <= 0) then
			self.isEnded = true
			
			self.timer:after(1, function()
				self.isDelayEnded = true
			
				self.resultScreen.message = 'VICTORY'
				self.resultScreen.color = {252/255, 196/255, 141/255}
				
				if levels[self.battleData.level].indexOfUnlockedHero then
					gameData.heroList[levels[self.battleData.level].indexOfUnlockedHero].unlocked = true 
				end
				
				if self.isReplay then self.reward = oldReward
				else
					self.reward = math.ceil(self.battleData.level / 2) * 20
					gameData.crystals = gameData.crystals + self.reward
				end
				
			end)
			
		elseif (#self.allies <= 0) then
			self.isEnded = true
		
			self.timer:after(1, function()
				self.isDelayEnded = true
			
				self.resultScreen.message = 'DEFEATED'
				self.resultScreen.color = {97/255, 156/255, 195/255}
				
				if self.isReplay then self.reward = oldReward
				else
					self.reward = 0
					--self.reward = 4 + self.battleData.level * 4 + math.random(0, self.battleData.level)
					gameData.crystals = gameData.crystals + self.reward
				end
				
				--GS.switch(Result, "enemies", self.battleData, self.isReplay, self.oldReward)
				end)
		end
	end

	self.timer:update(dt)

	if not self.isDelayEnded then
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
	end

	if (love.keyboard.isDown("escape")) then
		GS.switch(Main)
	end
	
	self.effectManager:update(dt)
	
	if self.isDelayEnded then
		if self.suit:ImageButton(Sprites.gui.result.replay_normal,
				{hovered = Sprites.gui.result.replay_hovered, active = Sprites.gui.result.replay_active},
				312, 286).hit then
			GS.switch(Battle, self.battleData.allies, self.battleData.enemies, true, self.reward, self.battleData.level)
		end
		if self.suit:ImageButton(Sprites.gui.result.exit_normal,
				{hovered = Sprites.gui.result.exit_hovered, active = Sprites.gui.result.exit_active},
				398, 286).hit then
			GS.switch(Main)
		end
	end
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
	
	
	if self.isDelayEnded then
		love.graphics.setColor(0, 0, 0, 0.234)
		love.graphics.rectangle('fill', 0, 0, 800, 540)
		
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(Sprites.gui.result.background, 300, 150, 0, 2, 2)
		
		love.graphics.setColor(self.resultScreen.color)
		love.graphics.setFont(Fonts.result.title)
		love.graphics.print(self.resultScreen.message, 400, 168, 0, 1, 1,
				Fonts.result.title:getWidth(self.resultScreen.message)/2)

		love.graphics.setColor(0.92, 0.92, 0.92)
		love.graphics.setFont(Fonts.main.heroSelectionSmall)
		love.graphics.print('REWARD', 368, 204, 0, 1, 1)

		love.graphics.setFont(Fonts.main.heroSelectionMedium)
		love.graphics.print(tostring(self.reward or 0), 386, 234, 0, 1, 1,
				Fonts.main.heroSelectionMedium:getWidth(tostring(self.reward))/2)
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(Sprites.gui.crysta, 404, 234, 0, 2, 2)

		love.graphics.setColor(1, 1, 1)
		self.suit:draw()
	end
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
