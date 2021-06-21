local HeroList = Class('HeroList')

function HeroList:initialize(heroDatas)
	self.heroDatas = heroDatas
	self.suit = Suit.new()
	
	self.y = 0
	self.scrollSpeed = 60
end

function HeroList:update(dt)
	for i, heroData in ipairs(self.heroDatas) do
		local x, y = self:_getPosFromDataIndex(i)
		
		if self.suit:Button(heroData.name, x, y, 80, 80).hit then
			GS.current():setSelection('hero list', i)
		end
	end
end

function HeroList:draw()
	love.graphics.setColor(51/255, 45/255, 88/255)
	love.graphics.rectangle('fill', 584, 0, 216, 540)
	
	self.suit:draw()
end

function HeroList:wheelmoved(x, y)
	local mx, my = love.mouse.getPosition()
	
	if mx > 580 then
		if y > 0 and self.y < 0 then
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
