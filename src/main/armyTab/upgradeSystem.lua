local UpgradeSystem = Class('UpgradeSystem')

function UpgradeSystem:initialize()
	self.suit = Suit.new()
end

function UpgradeSystem:update(dt)
	local selection = GS.current().selection

	if selection ~= nil then
		local hero
		if selection.from == 'hero list' then
			hero = gameData.heroList[selection.index]
		elseif selection.from == 'army grid' then
			hero = gameData.heroList[GS.current().armyGrid.heroIndexes[selection.index]]
		end
	
	
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.str)),
				{id = 1}, 440, 378, 90, 28).hit then
			self:upgrade(hero, 'str')
		end
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.int)),
				{id = 2}, 440, 414, 90, 28).hit then
			self:upgrade(hero, 'int')
		end
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.agi)),
				{id = 3}, 440, 450, 90, 28).hit then
			self:upgrade(hero, 'agi')
		end
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.dur)),
				{id = 4}, 440, 486, 90, 28).hit then
			self:upgrade(hero, 'dur')
		end
	end
end

function UpgradeSystem:draw()
	love.graphics.print('crystals : '..tostring(gameData.crystals), 120, 14)
	
	self.suit:draw()
end

function UpgradeSystem:getCrystalsFromStatLevel(statLevel)
	return 10 + statLevel * 4
end

function UpgradeSystem:upgrade(hero, stat)
	local requiredCrystals = self:getCrystalsFromStatLevel(hero.upgrades[stat])

	if gameData.crystals >= requiredCrystals then
		gameData.crystals = gameData.crystals - requiredCrystals
		hero.upgrades[stat] = hero.upgrades[stat] + 1
	end
end

return UpgradeSystem
