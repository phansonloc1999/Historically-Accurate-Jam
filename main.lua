require 'globals'

Battle = require 'src.battle.battle'

function love.load()
	GS.registerEvents()
	
	local allies = {
	
	}
	local enemies = {
	
	}
	
	GS.switch(Battle, {}, {})
end

function love.update(dt)

end

function love.draw()

end
