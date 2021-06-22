local HeroSelection = Class('HeroSelection')

function HeroSelection:initialize()
	self.suit = Suit.new()
end

function HeroSelection:update(dt)
	
end

function HeroSelection:draw()
	-- Draw background
	--love.graphics.setColor(46/255, 59/255, 84/255)
	--love.graphics.rectangle('fill', 126, 320, 448, 44)
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.main.selectionBackground, 126, 320, 0, 2, 2)
	
	
	-- Draw hero and hero info
	local selection = GS.current().selection
	
	if selection ~= nil then
		local hero
		if selection.from == 'hero list' then
			hero = gameData.heroList[selection.index]
		elseif selection.from == 'army grid' then
			hero = gameData.heroList[GS.current().armyGrid.heroIndexes[selection.index]]
		end
	
	
		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(Fonts.main.heroSelectionBig)
		
		love.graphics.print(hero.name, 140, 330)
		
		if hero.icon ~= nil then
			love.graphics.setColor(1, 1, 1)
			love.graphics.draw(Sprites.gui.main.occupiedSlot, 148, 392, 0, 3, 3)
			love.graphics.draw(hero.icon, 148, 392, 0, 6, 6)
			love.graphics.draw(Sprites.gui.main.occupiedSlotFrame, 148, 392, 0, 3, 3)
		
			--love.graphics.draw(hero.icon, 200, 396, 0, 3, 3, hero.sprite:getWidth()/2)
		end
		
		love.graphics.setFont(Fonts.main.heroSelectionMedium)
		love.graphics.draw(Sprites.gui.main.strength, 300, 378, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.str + hero.upgrades.str), 340, 384)
		
		love.graphics.draw(Sprites.gui.main.intelligence, 300, 414, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.int + hero.upgrades.int), 340, 420)
		
		love.graphics.draw(Sprites.gui.main.agility, 300, 450, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.agi + hero.upgrades.agi), 340, 456)
		
		love.graphics.draw(Sprites.gui.main.durability, 300, 486, 0, 2, 2)
		love.graphics.print(tostring(hero.stats.dur + hero.upgrades.dur), 340, 492)
	end
	
	self.suit:draw()
end



return HeroSelection
