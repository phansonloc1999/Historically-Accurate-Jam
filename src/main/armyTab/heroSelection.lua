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
		love.graphics.print(hero.name, 180, 320)
		love.graphics.print('strength: '..tostring(hero.stats.str), 180, 340)
		love.graphics.print('durability: '..tostring(hero.stats.dur), 180, 360)
		love.graphics.print('intelligence: '..tostring(hero.stats.int), 180, 380)
		love.graphics.print('agility: '..tostring(hero.stats.agi), 180, 400)
	end
end

return HeroSelection
