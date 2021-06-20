require 'globals'

Main = require 'src.main.main'
Battle = require 'src.battle.battle'

local MainHero = require 'src.main.mainHero'
gameData = nil

function love.load()
	gameData = {
		heroList = {
			{
				unlocked = true,
				name = 'Lac Long Quan',
				stats = {str = 5, dur = 12, int = 8, agi = 3},
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				name = 'Au Co',
				stats = {str = 5, dur = 4, int = 14, agi = 4},
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
		},
		
		levels = {
			{
				passed = false,
				enemies = {
					{
						stats = {str = 5, dur = 6, int = 6, agi = 3}
					}
				}
			},
			{
				passed = false,
				enemies = {
					
				}
			},
		}
	}

	GS.registerEvents()
	
	--local allies = {
	
	--}
	--local enemies = {
	
	--}
	
	--GS.switch(Battle, {}, {})
	
	GS.switch(Main)
end

function love.update(dt)

end

function love.draw()

end
