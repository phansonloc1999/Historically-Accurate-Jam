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
	if self.suit:Button('MAP', 0, 0, 130, 230).hit then
		self.currentTab = 'map'
	end
	if self.suit:Button('ARMY', 0, 230, 130, 230).hit then
		self.currentTab = 'army'
	end
	if self.suit:Button('MENU', 0, 460, 130, 80).hit then
	
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


function Main:setSelection(from, index)
	if from == nil then
		self.selection = from
	else
		self.selection = {from = from, index = index}
	end
end

return Main
