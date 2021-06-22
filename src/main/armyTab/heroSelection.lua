local HeroSelection = Class('HeroSelection')

function HeroSelection:initialize()
	self.suit = Suit.new()
	
	self.skillBackgroundQuad = love.graphics.newQuad(0, 0, 126, 18,
			Sprites.gui.main.selectionBackground:getDimensions())
end

function HeroSelection:update(dt)
	
end

function HeroSelection:draw()
	local selection = GS.current().selection
	
	if selection ~= nil then
		local hero
		if selection.from == 'hero list' then
			hero = gameData.heroList[selection.index]
		elseif selection.from == 'army grid' then
			hero = gameData.heroList[GS.current().armyGrid.heroIndexes[selection.index]]
		end
	
		-- Draw background
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(Sprites.gui.main.selectionBackground, 126, 302, 0, 2, 2)
	
	
		-- Draw hero and hero info
		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(Fonts.main.heroSelectionBig)
		
		love.graphics.print(hero.name, 140, 312)
		
		if hero.icon ~= nil then
			love.graphics.setColor(1, 1, 1)
			love.graphics.draw(Sprites.gui.main.occupiedSlot, 154, 362, 0, 3, 3)
			love.graphics.draw(hero.icon, 154, 362, 0, 6, 6)
			love.graphics.draw(Sprites.gui.main.occupiedSlotFrame, 154, 362, 0, 3, 3)
		end
		
		--love.graphics.setColor(47/255, 63/255, 96/255)
		--love.graphics.rectangle('fill', 130, 478, 170, 36)
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(Sprites.gui.main.selectionBackground, self.skillBackgroundQuad,
				126, 498, 0, 2, 2)
		love.graphics.setColor(0.92, 0.92, 0.92)
		love.graphics.setFont(Fonts.main.heroSelectionSmall)
		love.graphics.print('SKILL :', 134, 510)
		love.graphics.setFont(Fonts.main.heroSelectionMedium)
		love.graphics.print(string.upper(hero.skill), 200, 506)
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(Fonts.main.heroSelectionMedium)
		love.graphics.draw(Sprites.gui.main.strength, 300, 352, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.str + hero.upgrades.str), 340, 358)
		
		love.graphics.draw(Sprites.gui.main.intelligence, 300, 388, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.int + hero.upgrades.int), 340, 394)
		
		love.graphics.draw(Sprites.gui.main.agility, 300, 424, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.agi + hero.upgrades.agi), 340, 430)
		
		love.graphics.draw(Sprites.gui.main.durability, 300, 460, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.dur + hero.upgrades.dur), 340, 466)
	end
	
	self.suit:draw()
end



return HeroSelection
