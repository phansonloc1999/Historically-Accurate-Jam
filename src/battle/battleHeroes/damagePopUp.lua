local DamagePopUp = Class('DamagePopUp')

function DamagePopUp:initialize(x, y)
	self.x, self.y = x, y
	self.popups = {}
	
	self.timer = Timer.new()
end

function DamagePopUp:update(dt)
	self.timer:update(dt)

	for i, popup in ipairs(self.popups) do
		popup:update(dt)
	end
end

function DamagePopUp:draw()
	local skills = {}

	for i, popup in ipairs(self.popups) do
		if popup.isSkill then
			table.insert(skills, popup)
		else
			popup:draw()
		end
	end
	
	for i, popup in ipairs(skills) do
		popup:draw()
	end
end

function DamagePopUp:onDamageTaken(damageTaken, color)
	local popup = {
		y = self.y + 28,
		text = tostring(damageTaken),
		scale = 0.74,
		opacity = 1,
		
		update = function(self, dt)
			self.y = self.y - 142 * dt
		end,
		
		draw = function(self_)
			love.graphics.setColor(color or {170/255, 38/255, 35/255}, self_.opacity)
			love.graphics.setFont(Fonts.battle.damagePopUp)
			local text = '-'..self_.text
			love.graphics.print(text, self.x + 32, self_.y, 0, self_.scale, self_.scale,
					Fonts.battle.damagePopUp:getWidth(text)/2,
					Fonts.battle.damagePopUp:getHeight()/2)
		end,
	}
	
	self.timer:tween(0.42, popup, {scale = 1}, 'out-back', nil, 22)
	self.timer:after(0.2, function()
		self.timer:tween(0.6, popup, {opacity = 0}, 'linear')
	end)
	self.timer:after(0.6, function()
		self:removePopup(popup)
	end)
	
	table.insert(self.popups, popup)
end

function DamagePopUp:onHealthHeal(healthHeal)
	local popup = {
		y = self.y + 34,
		text = tostring(healthHeal),
		scale = 0.74,
		opacity = 1,
		
		update = function(self, dt)
			self.y = self.y - 142 * dt
		end,
		
		draw = function(self_)
			love.graphics.setColor(0, 255, 0, self_.opacity)
			love.graphics.setFont(Fonts.battle.damagePopUp)
			local text = '+'..self_.text
			love.graphics.print(text, self.x + 32, self_.y, 0, self_.scale, self_.scale,
					Fonts.battle.damagePopUp:getWidth(text)/2,
					Fonts.battle.damagePopUp:getHeight()/2)
		end,
	}
	
	self.timer:tween(0.42, popup, {scale = 1}, 'out-back', nil, 22)
	self.timer:after(0.2, function()
		self.timer:tween(0.6, popup, {opacity = 0}, 'linear')
	end)
	self.timer:after(0.6, function()
		self:removePopup(popup)
	end)
	
	table.insert(self.popups, popup)
end

function DamagePopUp:onSkillCasted(skill)
	local popup = {
		y = self.y + 28,
		text = string.upper(skill),
		scale = 0.74,
		opacity = 1,
		
		isSkill = true,
		
		update = function(self, dt)
			self.y = self.y - 30 * dt
		end,
		
		draw = function(self_)
			love.graphics.setColor(236/255, 190/255, 161/255)
			love.graphics.setFont(Fonts.battle.damagePopUp)
			love.graphics.print(self_.text, self.x + 32, self_.y, 0, self_.scale, self_.scale,
					Fonts.battle.damagePopUp:getWidth(self_.text)/2,
					Fonts.battle.damagePopUp:getHeight()/2)
		end,
	}
	
	self.timer:after(0.38, function()
		self:removePopup(popup)
	end)
	
	table.insert(self.popups, popup)
end


function DamagePopUp:removePopup(popup)
	for i, popup_ in ipairs(self.popups) do
		if popup_ == popup then
			table.remove(self.popups, i)
		end     
	end
end

return DamagePopUp
