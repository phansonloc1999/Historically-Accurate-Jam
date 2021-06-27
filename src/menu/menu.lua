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
	love.graphics.setColor(0.92, 0.92, 0.92)
	love.graphics.setFont(Fonts.menu.bigTitle)
	love.graphics.print('DRIVE OUT THE AGGRESSORS', 400, 120, 0, 1, 1,
			Fonts.menu.bigTitle:getWidth('DRIVE OUT THE AGGRESSORS')/2)

	self.suit:draw()
end

return Menu
