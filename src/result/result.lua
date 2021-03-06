local Result = {}

function Result:enter(from, winner, battleData, isReplay, oldReward)
	self.from = from
	
	if winner == 'allies' then
		self.message = 'VICTORY'
		self.color = {252/255, 196/255, 141/255}

		-- Unlock a hero after winning that level (if any)
		if levels[battleData.level].indexOfUnlockedHero then
			gameData.heroList[levels[battleData.level].indexOfUnlockedHero].unlocked = true 
		end
	elseif winner == 'enemies' then
		self.message = 'DEFEATED'
		self.color = {97/255, 156/255, 195/255}
	end
	
	self.battleData = battleData
	self.isReplay = isReplay
	if self.isReplay then self.reward = oldReward
	else 
		if winner == 'allies' then
			self.reward = 25 + battleData.level * 40 + math.random(0, battleData.level * 5)
		elseif winner == 'enemies' then
			self.reward = 4 + battleData.level * 4 + math.random(0, battleData.level)
		end
	end
	
	self.suit = Suit.new()
end

function Result:update(dt)	
	if self.suit:ImageButton(Sprites.gui.result.replay_normal,
			{hovered = Sprites.gui.result.replay_hovered, active = Sprites.gui.result.replay_active},
			312, 286).hit then
		GS.switch(Battle, self.battleData.allies, self.battleData.enemies, true, self.reward, self.battleData.level)
	end
	if self.suit:ImageButton(Sprites.gui.result.exit_normal,
			{hovered = Sprites.gui.result.exit_hovered, active = Sprites.gui.result.exit_active},
			398, 286).hit then
		GS.switch(Main)
		gameData.crystals = gameData.crystals + self.reward
	end
end

function Result:draw()
	self.from:draw()
	love.graphics.setColor(0, 0, 0, 0.234)
	love.graphics.rectangle('fill', 0, 0, 800, 540)
	
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.result.background, 300, 150, 0, 2, 2)
	
	love.graphics.setColor(self.color)
	love.graphics.setFont(Fonts.result.title)
	love.graphics.print(self.message, 400, 168, 0, 1, 1, Fonts.result.title:getWidth(self.message)/2)

	love.graphics.setColor(0.92, 0.92, 0.92)
	love.graphics.setFont(Fonts.main.heroSelectionSmall)
	love.graphics.print('REWARD', 368, 204, 0, 1, 1)

	love.graphics.setFont(Fonts.main.heroSelectionMedium)
	love.graphics.print(tostring(self.reward), 386, 234, 0, 1, 1,
			Fonts.main.heroSelectionMedium:getWidth(tostring(self.reward))/2)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.crysta, 404, 234, 0, 2, 2)

	love.graphics.setColor(1, 1, 1)
	self.suit:draw()
end

return Result
