local HeroList = require "src.main.armyTab.heroList"
local ArmyGrid = require "src.main.armyTab.armyGrid"
local HeroSelection = require "src.main.armyTab.heroSelection"
local UpgradeSystem = require "src.main.armyTab.upgradeSystem"
local HoveredInfo = require "src.main.armyTab.hoveredInfo"

local Main = {}

local LEVEL_BUTTON_WIDTH = 80
local LEVEL_BUTTON_HEIGHT = 80
local LEVEL_BUTTON_SPACING_X = 10

function Main:enter(from)
    self.currentTab = "map"

    -- Map tab

    -- Army tab
    self.selection = nil
    self.heroList = HeroList(gameData.heroList)
    self.armyGrid = ArmyGrid(gameData.formation)
    self.heroSelection = HeroSelection()
    self.upgradeSystem = UpgradeSystem()
    self.hoveredInfo = HoveredInfo()

    self.suit = Suit.new()
end

function Main:update(dt)
    -- Tabs buttons
    love.graphics.setColor(1, 1, 1)
    if
        self.suit:ImageButton(
            Sprites.gui.main.map_normal,
            {hovered = Sprites.gui.main.map_hovered, active = Sprites.gui.main.map_active},
            0,
            6
        ).hit
     then
        self.currentTab = "map"

        AudioManager:playSound("gui1")
    end

    if
        self.suit:ImageButton(
            Sprites.gui.main.army_normal,
            {hovered = Sprites.gui.main.army_hovered, active = Sprites.gui.main.army_active},
            0,
            236
        ).hit
     then
        self.currentTab = "army"

        AudioManager:playSound("gui1")
    end

    if
        self.suit:ImageButton(
            Sprites.gui.main.menu_normal,
            {hovered = Sprites.gui.main.menu_hovered, active = Sprites.gui.main.menu_active},
            0,
            466
        ).hit
     then
        gameData.formation = self.armyGrid.heroIndexes
        GS.switch(Menu)

        AudioManager:playSound("gui1")
    end

    -- Main buttons
    if self.currentTab == "map" then
        for i = 1, #gameData.levels do
            local buttonText = tostring(i)
            if (levels[i].indexOfUnlockedHero) then
                buttonText = buttonText .. "\n\nWin to unlock " .. gameData.heroList[levels[i].indexOfUnlockedHero].name
            end

            local button =
                self.suit:Button(
                buttonText,
                {font = Fonts.main.level, valign = "top"},
                160 + (LEVEL_BUTTON_SPACING_X + LEVEL_BUTTON_WIDTH) * (i - 1),
                180,
                LEVEL_BUTTON_WIDTH,
                LEVEL_BUTTON_HEIGHT
            )

            if button.hit then
                gameData.formation = self.armyGrid.heroIndexes

                GS.switch(Battle, self.armyGrid:getAllies(), gameData.levels[i].enemies, false, i)
            end
        end
    elseif self.currentTab == "army" then
        self.heroList:update(dt)
        self.armyGrid:update(dt)
        self.heroSelection:update(dt)
        self.upgradeSystem:update(dt)
    end
end

function Main:draw()
    if self.currentTab == "map" then
    elseif self.currentTab == "army" then
        self.heroList:draw()
        self.armyGrid:draw()
        self.heroSelection:draw()
        self.upgradeSystem:draw()
        self.hoveredInfo:draw()
    end

    love.graphics.setColor(1, 1, 1)
    self.suit:draw()
end

function Main:mousepressed(x, y, button)
    if self.currentTab == "map" then
    elseif self.currentTab == "army" then
        self.armyGrid:mousepressed(x, y, button)
    end
end

function Main:wheelmoved(x, y)
    if self.currentTab == "map" then
    elseif self.currentTab == "army" then
        self.heroList:wheelmoved(x, y)
    end
end

function Main:setSelection(from, index)
    AudioManager:playSound("gui2")

    if from == nil then
        self.selection = from
    else
        self.selection = {from = from, index = index}
    end
end

return Main
