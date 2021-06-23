-- package.cpath = package.cpath .. ";/home/sonloc/.vscode/extensions/tangzx.emmylua-0.3.49/debugger/emmy/linux/emmy_core.so"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require 'globals'
require 'assets'

Main = require 'src.main.main'
Battle = require 'src.battle.battle'
Menu = require 'src.menu.menu'

local MainHero = require 'src.main.mainHero'
gameData = nil

function love.load()
	gameData = {
		crystals = 50,
		
		heroList = {
			{
				unlocked = true,
				
				name = 'Lac Long Quan',
				sprite = Sprites.heroes.lacLongQuan.full,
				icon = Sprites.heroes.lacLongQuan.icon,
				
				stats = {str = 5, dur = 12, int = 8, agi = 3},
				skill = 'strike',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				
				name = 'Au Co',
				sprite = Sprites.heroes.auCo.full,
				icon = Sprites.heroes.auCo.icon,
				
				stats = {str = 5, dur = 4, int = 14, agi = 4},
				skill = 'regenerate',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				
				name = 'Son Tinh',
				sprite = Sprites.heroes.sonTinh.full,
				icon = Sprites.heroes.sonTinh.icon,
				
				stats = {str = 9, dur = 9, int = 4, agi = 60}, -- orginally 6
				skill = 'smash',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				
				name = 'Thuy Tinh',
				sprite = Sprites.heroes.thuyTinh.full,
				icon = Sprites.heroes.thuyTinh.icon,
				
				stats = {str = 12, dur = 4, int = 2, agi = 10},
				skill = 'rend',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,
				
				name = 'Hung Vuong',
				sprite = Sprites.heroes.hungVuong.full,
				icon = Sprites.heroes.hungVuong.icon,
				
				stats = {str = 6, dur = 13, int = 6, agi = 3},
				skill = 'mandate',
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,

				name = 'Chu Dong Tu', -- Can use magic according to myth => high int and agi, low str dur 
				sprite = Sprites.heroes.chuDongTu.full,
				icon = Sprites.heroes.chuDongTu.icon,

				stats = {str = 3, dur = 6, int = 15, agi = 10},
				skill = 'armored', -- increase durabity 
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			},
			{
				unlocked = true,

				name = 'Thach Sanh', -- High str + dur, low int, avg agi
				sprite = Sprites.heroes.thachSanh.full,
				icon = Sprites.heroes.thachSanh.icon,

				stats = {str = 12, dur = 8, int = 2, agi = 8},
				skill = 'axe', -- Deal physical damage, ignore armor/durabity
				upgrades = {str = 0, dur = 0, int = 0, agi = 0},
			}
		},
		
		formation = {
			[5] = 1
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

	
	love.graphics.setBackgroundColor(41/255, 37/255, 57/255)
	
	GS.registerEvents()
	GS.switch(Menu)
end

function love.update(dt)

end

function love.draw()

end
