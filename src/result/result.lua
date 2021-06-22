local Result = {}

function Result:enter(from, message)
	self.from = from
    self.message = message
end

function Result:update(dt)
    -- body
end

function Result:draw()
		self.from:draw()
		
    love.graphics.setNewFont(30)
    love.graphics.print(self.message)
end

return Result
