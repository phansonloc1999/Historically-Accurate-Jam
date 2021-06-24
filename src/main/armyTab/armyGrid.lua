local ArmyGrid = Class('ArmyGrid')

local MAX_ARMY_SIZE = 5

function ArmyGrid:initialize(heroIndexes)
	self.heroIndexes = heroIndexes
	self.currentArmySize = self:_getArmySize()
end

function ArmyGrid:update(dt)
	
end

function ArmyGrid:draw()
	love.graphics.setColor(0.92, 0.92, 0.92)
	love.graphics.setFont(Fonts.main.title)
	love.graphics.print('FORMATION: '..self.currentArmySize.."/"..MAX_ARMY_SIZE, 226, 285, -math.pi/2)

	for i = 1, 9 do
		local x, y = self:_getPosFromGridIndex(i)
	
		-- Actual icon
		love.graphics.setColor(1, 1, 1)
		if self.heroIndexes[i] ~= nil then
			local hero = self:getHeroFromHeroIndex(self.heroIndexes[i])
		
			love.graphics.draw(Sprites.gui.main.occupiedSlot, x, y, 0, 2, 2)
			if hero.icon ~= nil then
				love.graphics.draw(hero.icon, x, y, 0, 4, 4)
			else
				love.graphics.print(self.heroIndexes[i], x, y)
			end
			love.graphics.draw(Sprites.gui.main.occupiedSlotFrame, x, y, 0, 2, 2)
			
		else
			love.graphics.draw(Sprites.gui.main.emptySlot, x, y, 0, 2, 2)
		end
		
		
		-- Mouse hover and down effect
		local mx, my = love.mouse.getPosition()
		
		if x < mx and mx < x + 80 and y < my and my < y + 80 then
			if love.mouse.isDown(1) then
				love.graphics.setColor(0, 0, 0, 0.11)
			else
				love.graphics.setColor(1, 1, 1, 0.075)
			end
		else
			love.graphics.setColor(0, 0, 0, 0)
		end
		love.graphics.rectangle('fill', x, y, 80, 80)
	end
end

function ArmyGrid:mousepressed(mx, my, button)
	for i = 1, 9 do
		local x, y = self:_getPosFromGridIndex(i)
		local mx, my = love.mouse.getPosition()
		
		if x < mx and mx < x + 80 and y < my and my < y + 80 then
		
			if button == 1 then
				local selection = GS.current().selection
		
				local heroIndex = self.heroIndexes[i]
				if heroIndex == nil then
					if selection == nil then
						-- meh
						
					elseif selection ~= nil then
						if selection.from == 'army grid' then
							if selection.index == i then
								GS.current():setSelection(nil)
								
							elseif selection.index ~= i then
								local heroIndex = self.heroIndexes[selection.index]
							
								self:removeHeroIndexFromGrid(selection.index)
								self:addHeroIndexToGrid(heroIndex, i)
								
								GS.current():setSelection(nil)

								self.currentArmySize = self:_getArmySize()
							end
						
						elseif selection.from == 'hero list' then
							if self:_getArmySize() <= 4 then
								self:addHeroIndexToGrid(selection.index, i)
								
								GS.current():setSelection(nil)
								
								self.currentArmySize = self:_getArmySize()
							else
							
								GS.current():setSelection(nil)
							end
						
						end
						
					end
					
				elseif heroIndex ~= nil then
					if selection == nil then
						GS.current():setSelection('army grid', i)
						
					elseif selection ~= nil then
						if selection.from == 'army grid' then
							self:switchHeroIndexPos(i, selection.index)
							
							self.currentArmySize = self:_getArmySize()
						elseif selection.from == 'hero list' then
							self:addHeroIndexToGrid(selection.index, i)
							
							self.currentArmySize = self:_getArmySize()
						end
						GS.current():setSelection(nil)
						
					end
				
				end
				
			elseif button == 2 then
				self.heroIndexes[i] = nil
				GS.current():setSelection(nil)

				self.currentArmySize = self:_getArmySize()
			end
		end
	end
end


function ArmyGrid:addHeroIndexToGrid(heroIndex, gridIndex)
	for i = 1, 9 do
		if self.heroIndexes[i] == heroIndex then
			return false
		end
	end
	
	self.heroIndexes[gridIndex] = heroIndex
end

function ArmyGrid:removeHeroIndexFromGrid(gridIndex)
	for i = 1, 9 do
		if i == gridIndex then
			self.heroIndexes[i] = nil
		end
	end

	self.currentArmySize = self:_getArmySize()
end

function ArmyGrid:switchHeroIndexPos(gridIndex1, gridIndex2)
	self.heroIndexes[gridIndex1], self.heroIndexes[gridIndex2] = self.heroIndexes[gridIndex2], self.heroIndexes[gridIndex1]
end


function ArmyGrid:getAllies()
	local allies = {}
	
	for i = 1, 9 do
		if self.heroIndexes[i] ~= nil then
			table.insert(allies, {
				hero = gameData.heroList[self.heroIndexes[i]],
				gridIndex = i
			})
		end
	end
	
	return allies
end

function ArmyGrid:getHeroFromHeroIndex(heroIndex)
	return gameData.heroList[heroIndex]
end

function ArmyGrid:_getPosFromGridIndex(i)
	local gx = (i - 1) % 3
	local gy = (i - gx - 1) / 3
	
	return 264 + gx * 104, 14 + gy * 96
end

function ArmyGrid:_getArmySize()
	local size = 0

	for i = 1, 9 do
		if self.heroIndexes[i] ~= nil then
			size = size + 1
		end
	end
	
	return size
end

return ArmyGrid
