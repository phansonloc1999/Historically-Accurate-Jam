local HeroList = Class('HeroList')

function HeroList:initialize(heroDatas)
	self.heroDatas = heroDatas
	self.suit = Suit.new()
end

function HeroList:update(dt)
	for i, heroData in ipairs(self.heroDatas) do
		local x, y = self:_getPosFromDataIndex(i)
		
		if self.suit:Button(heroData.name, x, y, 60, 60).hit then
			GS.current():setSelection('hero list', i)
		end
	end
end

function HeroList:draw()
	love.graphics.setColor(0.2, 0.2, 0.16)
	love.graphics.rectangle('fill', 635, 0, 165, 540)
	
	self.suit:draw()
end

function HeroList:_getPosFromDataIndex(i)
	local gx = (i - 1) % 2
	local gy = (i - gx) / 2 - 1
	
	return 650 + gx * 80, 100 + gy * 80
end

return HeroList
