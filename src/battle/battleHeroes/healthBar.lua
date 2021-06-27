HealthBar = Class("HealthBar")

function HealthBar:initialize(hero, max, width, height)
	self.hero = hero

	self.value = max
	self.max = max
	self.width, self.height = width, height
end

function HealthBar:draw(x, y)
	--love.graphics.setColor(255, 255, 255)
	--love.graphics.rectangle("line", x, y, self.width, self.height)
	--love.graphics.setColor(0, 255, 0)
	--love.graphics.rectangle("fill", x, y, self.width * (self.value / self.max) - 1, self.height - 1)
	
	self:drawManaPolygon(x, y)
	
	self:drawHealth(x, y)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.battle.healthBar, x, y, 0, 2, 2)
end

function HealthBar:update(dt)
    -- body
end

function HealthBar:drawManaPolygon(x, y)
	local manaRatio = self.hero.mana / 8
	if manaRatio < 1 then
		love.graphics.setColor(154/255, 145/255, 213/255)
	elseif manaRatio >= 1 then
		manaRatio = 1
		love.graphics.setColor(95/255, 160/255, 203/255)
	end
	
	
	local d = {
		Vector(x + 8, y + 16),
		Vector(x, y + 8),
		Vector(x + 16, y + 8),
		Vector(x + 8, y),
	}
	local p = {}
	
	if manaRatio <= 0.5 then
		p[1] = d[1]
		p[2] = d[1] + (d[2] - d[1]) * (manaRatio / 0.5)
		p[3] = d[1] + (d[3] - d[1]) * (manaRatio / 0.5)
		
	elseif 0.5 < manaRatio and manaRatio < 1 then
		p[1] = d[1]
		p[2] = d[2]
		p[3] = d[2] + (d[4] - d[2]) * ((manaRatio - 0.5) / 0.5)
		p[4] = d[3] + (d[4] - d[3]) * ((manaRatio - 0.5) / 0.5)
		p[5] = d[3]
		
	elseif manaRatio == 1 then
		p[1] = d[1]
		p[2] = d[2]
		p[3] = d[4]
		p[4] = d[3]
		
	end
	
	local vertices = {}
	for i = 1, #p do
		table.insert(vertices, p[i].x)
		table.insert(vertices, p[i].y)
	end
	
	love.graphics.polygon('fill', vertices)
end

function HealthBar:drawHealth(x, y)
	local healthRatio = self.value / self.max
	
	if healthRatio > 0.75 then
		love.graphics.setColor(88/255, 48/255, 123/255)
	elseif healthRatio > 0.5 then
		love.graphics.setColor(73/255, 47/255, 117/255)
	elseif healthRatio > 0.25 then
		love.graphics.setColor(59/255, 51/255, 122/255)
	else
		love.graphics.setColor(45/255, 60/255, 113/255)
	end
	love.graphics.rectangle('fill', x + 14, y + 4, 34 * healthRatio, 8)
	
	love.graphics.setColor(0.92, 0.92, 0.92, 0.09)
	love.graphics.rectangle('fill', x + 14, y + 4, 34 * healthRatio, 3)
end
