local Menu = {}

function Menu:enter()
	self.suit = Suit.new()
end

function Menu:update(dt)
	if self.suit:Button('PLAY', 290, 250, 220, 90).hit then
		GS.switch(Main)
	end
	if self.suit:Button('QUIT', 320, 370, 160, 90).hit then
		love.event.quit()
	end
end

function Menu:draw()
	self.suit:draw()
end

return Menu
