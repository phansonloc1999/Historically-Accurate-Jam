local HeroList = require 'src.main.armyTab.heroList'
local ArmyGrid = require 'src.main.armyTab.armyGrid'
local HeroSelection = require 'src.main.armyTab.heroSelection'

local Main = {}

function Main:enter(from)
	self.currentTab = 'map'
	
	-- Map tab
	
	-- Army tab
	self.selection = nil
	self.heroList = HeroList(gameData.heroList)
	self.armyGrid = ArmyGrid()
	self.heroSelection = HeroSelection()
	
	self.suit = Suit.new()
end

function Main:update(dt)
	-- Tabs buttons
	love.graphics.setColor(1, 1, 1)
	if self.suit:ImageButton(Sprites.gui.main.map_normal,
			{hovered = Sprites.gui.main.map_hovered, active = Sprites.gui.main.map_active},
			0, 6).hit then
		self.currentTab = 'map'
	end
	
	if self.suit:ImageButton(Sprites.gui.main.army_normal,
			{hovered = Sprites.gui.main.army_hovered, active = Sprites.gui.main.army_active},
			0, 236).hit then
		self.currentTab = 'army'
	end
	
	if self.suit:ImageButton(Sprites.gui.main.menu_normal,
			{hovered = Sprites.gui.main.menu_hovered, active = Sprites.gui.main.menu_active},
			0, 466).hit then
	
	end
	

	-- Main buttons
	if self.currentTab == 'map' then
		if self.suit:Button('level 1', 160, 180, 60, 60).hit then
			local enemies = {
				{
					hero = {
						stats = {str = 5, dur = 5, int = 4, agi = 4},
						skill = 'strike'
					},
					gridIndex = 5
				}
			}
		
			GS.switch(Battle, self.armyGrid:getAllies(), enemies)
		end
		
	elseif self.currentTab == 'army' then
		self.heroList:update(dt)
		self.armyGrid:update(dt)
		
	end
end

function Main:draw()
	love.graphics.setBackgroundColor(41/255, 37/255, 57/255)

	love.graphics.setColor(1, 1, 1)
	self.suit:draw()
	
	if self.currentTab == 'map' then
		
	elseif self.currentTab == 'army' then
		self.heroList:draw()
		self.armyGrid:draw()
		self.heroSelection:draw()
		
	end
end

function Main:mousepressed(x, y, button)
	if self.currentTab == 'map' then
		
	elseif self.currentTab == 'army' then
		self.armyGrid:mousepressed(x, y, button)
		
	end
end

function Main:wheelmoved(x, y)
	if self.currentTab == 'map' then
		
	elseif self.currentTab == 'army' then
		self.heroList:wheelmoved(x, y)
		
	end
end


function Main:setSelection(from, index)
	if from == nil then
		self.selection = from
	else
		self.selection = {from = from, index = index}
	end
end

return Main
