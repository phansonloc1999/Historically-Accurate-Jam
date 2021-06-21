local Result = {}

function Result:enter(from, message)
    self.message = message
end

function Result:draw()
    love.graphics.setNewFont(30)
    love.graphics.print(self.message)
end

function Result:update(dt)
    -- body
end

return Result