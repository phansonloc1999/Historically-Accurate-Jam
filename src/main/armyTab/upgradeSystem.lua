local UpgradeSystem = Class('UpgradeSystem')

function UpgradeSystem:initialize()
	self.suit = Suit.new()
	
	self.suit.theme = setmetatable({}, {__index = Suit.theme})
	
	self.suit.theme.Button = function(text, opt, x, y, w, h)
		love.graphics.setColor(1, 1, 1)
		if opt.state == 'normal' then
			love.graphics.draw(Sprites.gui.main.upgradeButton_normal, x, y, 0, 2, 2)
			love.graphics.setColor(0.92, 0.92, 0.92)
		elseif opt.state == 'hovered' then
			love.graphics.draw(Sprites.gui.main.upgradeButton_hovered, x, y, 0, 2, 2)
			love.graphics.setColor(0.96, 0.96, 0.96)
		elseif opt.state == 'active' then
			love.graphics.draw(Sprites.gui.main.upgradeButton_active, x, y, 0, 2, 2)
			love.graphics.setColor(0.87, 0.87, 0.87)
		end
		love.graphics.setFont(Fonts.main.heroSelectionMedium)
		love.graphics.printf(text, x, y + 6, 80, 'center')
		
	end
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
				{id = 1}, 454, 356, 76, 28).hit then
			self:upgrade(hero, 'str')
		end
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.int)),
				{id = 2}, 454, 392, 76, 28).hit then
			self:upgrade(hero, 'int')
		end
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.agi)),
				{id = 3}, 454, 428, 76, 28).hit then
			self:upgrade(hero, 'agi')
		end
		if self.suit:Button(tostring(self:getCrystalsFromStatLevel(hero.upgrades.dur)),
				{id = 4}, 454, 466, 76, 28).hit then
			self:upgrade(hero, 'dur')
		end
	end
end

function UpgradeSystem:draw()
	love.graphics.setColor(64/255, 43/255, 85/255)
	love.graphics.rectangle('fill', 126, 14, 106, 32)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.crysta, 128, 18, 0, 2, 2)
	love.graphics.setFont(Fonts.main.heroSelectionMedium)
	love.graphics.print(tostring(gameData.crystals), 156, 20)
	
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
