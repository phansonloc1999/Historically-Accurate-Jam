local HeroList = Class('HeroList')

function HeroList:initialize(heroDatas)
	self.heroDatas = heroDatas
	self.suit = Suit.new()
	self.suit_ = Suit.new()
	
	self.y = 40
	self.scrollSpeed = 60

	self.suit.theme = setmetatable({}, {__index = Suit.theme})
	
	self.suit.theme.Button = function(icon, opt, x, y, w, h)
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(Sprites.gui.main.occupiedSlot, x, y, 0, 2, 2)
		love.graphics.draw(icon, x, y, 0, 4, 4)
		love.graphics.draw(Sprites.gui.main.occupiedSlotFrame, x, y, 0, 2, 2)
	
		if opt.state == 'normal' then
			love.graphics.setColor(1,1,1,0)
		elseif opt.state == 'hovered' then
			love.graphics.setColor(1,1,1,0.075)
		elseif opt.state == 'active' then
			love.graphics.setColor(0,0,0,0.11)
		end
		love.graphics.rectangle('fill', x, y, 80, 80)
	end
end

function HeroList:update(dt)
	for i, heroData in ipairs(self.heroDatas) do
		local x, y = self:_getPosFromDataIndex(i)

		if heroData.icon ~= nil then
			if self.suit:Button(heroData.icon, x, y, 80, 80).hit then
				GS.current():setSelection('hero list', i)
			end
		else
			if self.suit_:Button(heroData.name, x, y, 80, 80).hit then
				GS.current():setSelection('hero list', i)
			end
		end
	end
end

function HeroList:draw()
	--love.graphics.setColor(51/255, 45/255, 88/255)
	--love.graphics.rectangle('fill', 584, 0, 216, 540)
	
	--self.suit:draw()
	--self.suit_:draw()
	
	--love.graphics.setColor(51/255, 45/255, 88/255)
	--love.graphics.rectangle('fill', 584, 0, 216, 40)
	
	--love.graphics.setColor(0.93, 0.93, 0.93)
	--love.graphics.setFont(Fonts.main.title)
	--love.graphics.print('HEROES', 644, 16)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.main.heroListBackground, 580, 0, 0, 2, 2)
	
	self.suit:draw()
	self.suit_:draw()
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.main.heroListBuffer, 580, 0, 0, 2, 2)
	
	love.graphics.setColor(0.93, 0.93, 0.93)
	love.graphics.setFont(Fonts.main.title)
	love.graphics.print('HEROES', 644, 16)
end

function HeroList:wheelmoved(x, y)
	local mx, my = love.mouse.getPosition()
	
	if mx > 580 then
		if y > 0 and self.y < 40 then
			self.y = self.y + self.scrollSpeed
		elseif y < 0 and self.y > - self.scrollSpeed * 6 then
			self.y = self.y - self.scrollSpeed
		end
	end
end


function HeroList:_getPosFromDataIndex(i)
	local gx = (i - 1) % 2
	local gy = (i - gx - 1) / 2 
	
	return 603 + gx * 100, self.y + 16 + gy * 96
end

return HeroList
