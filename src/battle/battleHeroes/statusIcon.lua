local StatusIcon = Class('StatusIcon')

local whiteShader = love.graphics.newShader [[
extern float WhiteFactor;

vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
{
    vec4 outputcolor = Texel(tex, texcoord) * vcolor;
    outputcolor.rgb += vec3(WhiteFactor);
    return outputcolor;
}
]]

function StatusIcon:initialize(hero)
	self.hero = hero
end

function StatusIcon:draw(x, y)
	local ox, oy = x + 32, y

	love.graphics.setColor(1, 1, 1)
	if self.hero.secondsToEndShield > 0 then
		--love.graphics.setShader(whiteShader)
		--whiteShader:send("WhiteFactor", 0.5)
		--love.graphics.draw(Sprites.statuses.shield, ox, oy, 0, 2.4, 2.4,
				--Sprites.statuses.shield:getWidth()/2, Sprites.statuses.shield:getHeight()/2)
		--love.graphics.setShader()
		
		love.graphics.draw(Sprites.statuses.shield, ox, oy, 0, 2, 2,
				Sprites.statuses.shield:getWidth()/2, Sprites.statuses.shield:getHeight()/2)
	end
	
	if self.hero.secondsToEndInvulnerability > 0 then
		--love.graphics.setShader(whiteShader)
		--whiteShader:send("WhiteFactor", 0.5)
		--love.graphics.draw(Sprites.statuses.invulnerable, ox, oy, 0, 2.4, 2.4,
				--Sprites.statuses.shield:getWidth()/2, Sprites.statuses.shield:getHeight()/2)
		--love.graphics.setShader()
		
		love.graphics.draw(Sprites.statuses.invulnerable, ox, oy, 0, 2, 2,
				Sprites.statuses.shield:getWidth()/2, Sprites.statuses.shield:getHeight()/2)
	end
	
	if self.hero.secondsToEndStun > 0 then
		--love.graphics.setShader(whiteShader)
		--whiteShader:send("WhiteFactor", 0.5)
		--love.graphics.draw(Sprites.statuses.stun, ox, oy, 0, 2.4, 2.4,
				--Sprites.statuses.shield:getWidth()/2, Sprites.statuses.shield:getHeight()/2)
		--love.graphics.setShader()
		
		love.graphics.draw(Sprites.statuses.stun, ox, oy, 0, 2, 2,
				Sprites.statuses.shield:getWidth()/2, Sprites.statuses.shield:getHeight()/2)
	end
end

return StatusIcon
