local EffectManager = Class('EffectManager')

local maxRange = 50
local maxRandomRange = 30

function EffectManager:initialize()
	self.effects = {}
	self.timer = Timer.new()
end

function EffectManager:update(dt)
	self.timer:update(dt)

	for i, effect in ipairs(self.effects) do
		effect:update(dt)
	end
end

function EffectManager:draw()
	for i, effect in ipairs(self.effects) do
		effect:draw()
	end
end

function EffectManager:addEffect(effect)
	table.insert(self.effects, effect)
end

function EffectManager:removeEffect(effect)
	for i, effect_ in ipairs(self.effects) do
		if effect == effect_ then
			table.remove(self.effects, i)
		end
	end
end

function EffectManager:onSkillCasted(skill, side, casterGridIndex, targetGridIndex)
	local cx, cy = self:getWorldPosFromGridIndex(side, casterGridIndex)
	local oppositeSide
	if side == 'allies' then oppositeSide = 'enemies'
	else oppositeSide = 'allies'
	end
	local tx, ty = self:getWorldPosFromGridIndex(oppositeSide, targetGridIndex)
	local mul
	if side == 'allies' then mul = 1
	else mul = -1
	end

	if skill == 'strike' then
		local effect = {
			x = cx + 32 * mul,
			y = cy + 32,
			
			update = function(self_, dt)
			
			end,
			
			draw = function(self_)
				love.graphics.setColor(1, 1, 1)
				love.graphics.draw(Sprites.effects.striker, self_.x, self_.y, 0, 2 * mul, 2,
						Sprites.effects.striker:getWidth()/2, Sprites.effects.striker:getHeight()/2)
			end
		}
		
		self.timer:after(0.09, function()
			self.timer:tween(0.16, effect, {x = tx + 32, y = ty + 32}, 'linear', function()
				self.timer:after(0.04, function()
					self:removeEffect(effect)
					
					for i = 1, 8 do
						local effect = {
							x = tx + 32 + mul * 14,
							y = ty + 33 - mul * 6,
							opacity = 0.6,
							size = 1.6,
							
							update = function()
							end,
							
							draw = function(self_)							
								love.graphics.setColor(210/255, 210/255, 186/255, self_.opacity)
								love.graphics.rectangle('fill', self_.x, self_.y, 4 * self_.size, 4 * self_.size)
							end
							
						}

						self.timer:tween(0.4, effect, {opacity = 0.15}, 'linear')
						self.timer:tween(0.36, effect, {size = 0.6}, 'in-cubic')

						local vec = Vector(1, 0)
						local randomVar = math.random(0, 50)
						local randomDir = math.random(0, 1)
						if randomDir == 1 then vec = vec:rotated(math.rad( math.random(-randomVar, 0) )) 
						elseif randomDir == 0 then vec = vec:rotated(math.rad( math.random(0, randomVar) ))
						end
						local normalizedRatio = (maxRange + math.random(-maxRandomRange, maxRandomRange))
						self.timer:tween(0.33, effect, 
								{x = effect.x + vec.x * normalizedRatio * mul, y = effect.y + vec.y * normalizedRatio}, 'out-quad')

						self.timer:after(0.4, function() self:removeEffect(effect) end)
						
						self:addEffect(effect)
						
					end
				end)
			end)
		end)
		
		self:addEffect(effect)
		
	
	elseif skill == 'mandate' then
		local teamates = GS.current()[side]
		
		for i = 1, #teamates do
			local x, y = self:getWorldPosFromGridIndex(side, teamates[i].gridIndex) 
		
			self.timer:every(0.06, function()
				local effect = {
					x = x + 28 + math.random(0, 10),
					y = y + 64,
					opacity = 0.8,
					size = 1.6,
					
					update = function()
					end,
					
					draw = function(self_)							
						love.graphics.setColor(192/255, 237/255, 239/255, self_.opacity)
						love.graphics.rectangle('fill', self_.x, self_.y, 4 * self_.size, 4 * self_.size)
					end
					
				}

				self.timer:tween(0.5, effect, {opacity = 0.4}, 'linear')
				self.timer:tween(0.47, effect, {size = 0.6}, 'in-cubic')

				local vec = Vector(0, -1)
				local randomVar = math.random(0, 50)
				local randomDir = math.random(0, 1)
				if randomDir == 1 then vec = vec:rotated(math.rad( math.random(-randomVar, 0) )) 
				elseif randomDir == 0 then vec = vec:rotated(math.rad( math.random(0, randomVar) ))
				end
				local normalizedRatio = (67 + math.random(-maxRandomRange, maxRandomRange))
				self.timer:tween(0.41, effect, 
						{x = effect.x + vec.x * normalizedRatio, y = effect.y + vec.y * normalizedRatio}, 'out-quad')

				self.timer:after(0.5, function() self:removeEffect(effect) end)
				
				self:addEffect(effect)
			end, 9)
		end
	
	end
end


function EffectManager:getWorldPosFromGridIndex(side, gridIndex)
	local x, y = GS.current():getWorldPosFromGridIndex(side, gridIndex)
	return x, y
end

return EffectManager
