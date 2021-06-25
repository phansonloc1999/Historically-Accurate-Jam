Class = require 'libs.middleclass'
GS = require 'libs.gamestate'
Suit = require 'libs.suit'
Timer = require 'libs.timer'
Vector = require 'libs.brinevector'

require('src.battle.battleHeroes.healthBar')

local major, minor, revision, codename = love.getVersion()
local str = string.format("Version %d.%d.%d - %s", major, minor, revision, codename)
print(str)

COLORS = {}
if (minor <= 10) then
    COLORS = {
        WHITE = {255, 255, 255}
    }
else 
    COLORS = {
        WHITE = {1, 1, 1}
    }
end
