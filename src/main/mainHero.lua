local MainHero = Class('MainHero')

function MainHero:initialize(combatInfo, drawInfo)
	self.combatInfo = combatInfo
	
	self.drawInfo = drawInfo or {}
end

function MainHero:draw(x, y)
	if self.drawInfo.icon then
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(self.drawInfo.icon, x, y, 0, 2, 2)
	else
		love.graphics.setColor(1, 0.4, 0.4)
		love.graphics.circle('line', x + 16, y + 16, 7)
	end
end

return MainHero
