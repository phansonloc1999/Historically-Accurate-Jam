-- package.cpath = package.cpath .. ";/home/sonloc/.vscode/extensions/tangzx.emmylua-0.3.49/debugger/emmy/linux/emmy_core.so"
-- local dbg = require("emmy_core")
-- dbg.tcpListen("localhost", 9966)

require "globals"
require "assets"

require "src.audioManager"

Main = require "src.main.main"
Battle = require "src.battle.battle"
Menu = require "src.menu.menu"

local MainHero = require "src.main.mainHero"
gameData = nil
levels = require "src.levels"

function love.load()
	math.randomseed(os.time())

    gameData = {
        crystals = 0,
        heroList = {
						{
                unlocked = true,
                name = "Thach Sanh",
                sprite = Sprites.heroes.thachSanh.full,
                icon = Sprites.heroes.thachSanh.icon,
                stats = {str = 10, dur = 6, int = 3, agi = 9},
                skill = "strike",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Lac Long Quan",
                sprite = Sprites.heroes.lacLongQuan.full,
                icon = Sprites.heroes.lacLongQuan.icon,
                stats = {str = 5, dur = 10, int = 10, agi = 5},
                skill = "divine",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Au Co",
                sprite = Sprites.heroes.auCo.full,
                icon = Sprites.heroes.auCo.icon,
                stats = {str = 3, dur = 5, int = 16, agi = 7},
                skill = "regenerate",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Son Tinh",
                sprite = Sprites.heroes.sonTinh.full,
                icon = Sprites.heroes.sonTinh.icon,
                stats = {str = 13, dur = 10, int = 5, agi = 4},
                skill = "smash",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Thuy Tinh",
                sprite = Sprites.heroes.thuyTinh.full,
                icon = Sprites.heroes.thuyTinh.icon,
                stats = {str = 8, dur = 2, int = 7, agi = 12},
                skill = "rend",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Hung Vuong",
                sprite = Sprites.heroes.hungVuong.full,
                icon = Sprites.heroes.hungVuong.icon,
                stats = {str = 5, dur = 8, int = 13, agi = 4},
                skill = "mandate",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Chu Dong Tu", -- Can use magic according to myth => high int and agi, low str dur
                sprite = Sprites.heroes.chuDongTu.full,
                icon = Sprites.heroes.chuDongTu.icon,
                stats = {str = 8, dur = 8, int = 8, agi = 8},
                skill = "bastion", -- increase durabity
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            },
            {
                unlocked = false,
                name = "Thanh Giong",
                sprite = Sprites.heroes.thanhGiong.full,
                icon = Sprites.heroes.thanhGiong.icon,
                stats = {str = 8, dur = 15, int = 2, agi = 5},
                skill = "disrupt",
                upgrades = {str = 0, dur = 0, int = 0, agi = 0}
            }
        },
        formation = {
            [5] = 1
        },
        levels = levels
    }

    love.graphics.setBackgroundColor(41 / 255, 37 / 255, 57 / 255)
    love.graphics.setFont(Fonts.result.title)

    GS.registerEvents()
    GS.switch(Menu)
end

function love.update(dt)
end

function love.draw()
end
