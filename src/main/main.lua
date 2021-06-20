local Main = {}

function Main:enter(from)
	self.currentTab = 'map'
	
	self.suit = Suit.new()
end

function Main:update(dt)
	if self.suit:Button('MAP', 0, 0, 200, 230).hit then
		self.currentTab = 'map'
	end
	if self.suit:Button('ARMY', 0, 230, 200, 230).hit then
		self.currentTab = 'army'
	end
	if self.suit:Button('MENU', 0, 460, 200, 80).hit then
	
	end
	

	if self.currentTab == 'map' then
		
	elseif self.currentTab == 'army' then
	
	end
end

function Main:draw()
	self.suit:draw()
end

return Main
