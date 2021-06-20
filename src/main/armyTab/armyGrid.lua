local ArmyGrid = Class('ArmyGrid')

function ArmyGrid:initialize()
	self.heroIndexes = {}
end

function ArmyGrid:update(dt)
	
end

function ArmyGrid:draw()
	for i = 1, 9 do
		local x, y = self:_getPosFromGridIndex(i)
		local mx, my = love.mouse.getPosition()
		
		if x < mx and mx < x + 60 and y < my and my < y + 60 then
			if love.mouse.isDown(1) then
				love.graphics.setColor(0.74, 0.6, 0.3)
			else
				love.graphics.setColor(0.4, 0.53, 0.69)
			end
		else
			love.graphics.setColor(0.2, 0.2, 0.16)
		end
		
		love.graphics.rectangle('fill', x, y, 60, 60)
		
		if self.heroIndexes[i] ~= nil then
			love.graphics.setColor(1, 1, 1)
			love.graphics.print(self.heroIndexes[i], x, y)
		end
		
	end
end

function ArmyGrid:mousepressed(mx, my, button)
	for i = 1, 9 do
		local x, y = self:_getPosFromGridIndex(i)
		local mx, my = love.mouse.getPosition()
		
		if x < mx and mx < x + 60 and y < my and my < y + 60 then
		
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
								
							end
						
						elseif selection.from == 'hero list' then
							if self:_getArmySize() <= 5 then
								self:addHeroIndexToGrid(selection.index, i)
								
								GS.current():setSelection(nil)
								
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
							
						elseif selection.from == 'hero list' then
							self:addHeroIndexToGrid(selection.index, i)
							
						end
						GS.current():setSelection(nil)
						
					end
				
				end
				
			elseif button == 2 then
				self.heroIndexes[i] = nil
				GS.current():setSelection(nil)
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


function ArmyGrid:_getPosFromGridIndex(i)
	local gx = (i - 1) % 3
	local gy = (i - gx) / 3 - 1
	
	return 220 + gx * 80, 120 + gy * 80
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
