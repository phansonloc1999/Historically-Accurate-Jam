local HeroSelection = Class('HeroSelection')

function HeroSelection:initialize()
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
	
	
		love.graphics.setColor(1, 1, 1)
		if hero.sprite ~= nil then
			love.graphics.draw(hero.sprite, 230, 384, 0, 3, 3, hero.sprite:getWidth()/2)
		end
	
		--love.graphics.setFont(Fonts.main.heroSelectionBig)
		love.graphics.printf(hero.name, 170, 360, 120, 'center')
		love.graphics.print('strength: '..tostring(hero.stats.str), 380, 340)
		love.graphics.print('durability: '..tostring(hero.stats.dur), 380, 360)
		love.graphics.print('intelligence: '..tostring(hero.stats.int), 380, 380)
		love.graphics.print('agility: '..tostring(hero.stats.agi), 380, 400)
	end
end

return HeroSelection
