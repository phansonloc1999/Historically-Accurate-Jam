require 'globals'

Main = require 'src.main.main'
Battle = require 'src.battle.battle'

function love.load()
	GS.registerEvents()
	
	--local allies = {
	
	--}
	--local enemies = {
	
	--}
	
	GS.switch(Battle, {}, {})
	
	-- GS.switch(Main)
end

function love.update(dt)

end

function love.draw()

end
