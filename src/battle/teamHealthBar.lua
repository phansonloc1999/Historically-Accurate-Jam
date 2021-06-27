local TeamHealthBar = Class('TeamHealthBar')

function TeamHealthBar:initialize(allies, enemies)
	self.allies = allies
	self.totalallies = #self.allies
	
	self.enemies = enemies
	self.totalenemies = #self.enemies
end

function TeamHealthBar:draw()
	local allyRatio = self:getHealthRatioFromTeam('allies')
	if allyRatio > 0.75 then
		love.graphics.setColor(88/255, 48/255, 123/255)
	elseif allyRatio > 0.5 then
		love.graphics.setColor(73/255, 47/255, 117/255)
	elseif allyRatio > 0.25 then
		love.graphics.setColor(59/255, 51/255, 122/255)
	else
		love.graphics.setColor(45/255, 60/255, 113/255)
	end
	love.graphics.rectangle('fill', 192 + 176 * (1 - allyRatio), 24, 176 - (172 * (1 - allyRatio)), 20)
	
	love.graphics.setColor(0.92, 0.92, 0.92, 0.09)
	love.graphics.rectangle('fill', 192 + 176 * (1 - allyRatio), 24, 176 - (172 * (1 - allyRatio)), 8)
	
	
	local enemyRatio = self:getHealthRatioFromTeam('enemies')
	if enemyRatio > 0.75 then
		love.graphics.setColor(88/255, 48/255, 123/255)
	elseif enemyRatio > 0.5 then
		love.graphics.setColor(73/255, 47/255, 117/255)
	elseif enemyRatio > 0.25 then
		love.graphics.setColor(59/255, 51/255, 122/255)
	else
		love.graphics.setColor(45/255, 60/255, 113/255)
	end
	love.graphics.rectangle('fill', 426, 24, 176 * enemyRatio + 2, 20)
	
	love.graphics.setColor(0.92, 0.92, 0.92, 0.09)
	love.graphics.rectangle('fill', 426, 24, 176 * enemyRatio + 2, 8)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.gui.battle.teamHealthBar, 188, 12, 0, 4, 4)
end

function TeamHealthBar:getHealthRatioFromTeam(team)
	local totalNum = self['total'..team]

	local team = self[team]
	local teamHealthRatio = 0
	
	for i = 1, #team do
		local healthRatio = team[i].healthBar.value / team[i].healthBar.max
		
		teamHealthRatio = teamHealthRatio + healthRatio
	end
	
	return teamHealthRatio / totalNum
end

return TeamHealthBar
