-- package.cpath = package.cpath .. ";/home/sonloc/.vscode/extensions/tangzx.emmylua-0.3.49/debugger/emmy/linux/emmy_core.so"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require 'globals'
require 'assets'

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
				skill = 'strike',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				name = 'Au Co',
				stats = {str = 5, dur = 4, int = 14, agi = 4},
				skill = 'regenerate',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				name = 'Son Tinh',
				stats = {str = 9, dur = 9, int = 4, agi = 6},
				skill = 'smash',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				name = 'Thuy Tinh',
				stats = {str = 12, dur = 4, int = 2, agi = 10},
				skill = 'rend',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				name = 'Hung Vuong',
				stats = {str = 6, dur = 13, int = 6, agi = 3},
				skill = 'mandate',
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
