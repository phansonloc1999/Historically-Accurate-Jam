HealthBar = Class("HealthBar")

function HealthBar:initialize(max, width, height)
    self.value = max
    self.max = max
    self.width, self.height = width, height
end

function HealthBar:draw(x,y)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", x, y, self.width, self.height)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", x, y, self.width * (self.value / self.max) - 1, self.height - 1)
end

function HealthBar:update(dt)
    -- body
end