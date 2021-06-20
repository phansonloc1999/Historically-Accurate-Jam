local BattleHero = Class('BattleHero')

function BattleHero:initialize(side, gridIndex, info, sprite)
	self.side = side
	self.gridIndex = gridIndex

	self.info = info
	self.info.healthBar = HealthBar(self.info.hp or 100, 50, 9)
	
	self.isDead = false

	self.sprite = sprite
	
	self.secondsToAttack = 0
	self.secondsPerAttack = 1
	
	self.mana = 0
end

function BattleHero:update(dt)
	self.secondsToAttack = self.secondsToAttack - dt

	if self.secondsToAttack <= 0 then
		self:attack()
		
		self.secondsToAttack = self.secondsPerAttack
	end
end

function BattleHero:draw(x, y)
	love.graphics.setColor(self.sprite)
	love.graphics.rectangle('fill', x, y, 60, 60)

	--- TODO: replace 30 with the width of self.sprite when it's added
	self.info.healthBar:draw(x + 30 - self.info.healthBar.width / 2, y - 20)
end

function BattleHero:attack()
	local target = self:getTarget()
	target:takeDamage('physical', 10)
end

function BattleHero:castSkill()
	
end


function BattleHero:getTarget()
	local gx = (self.gridIndex - 1) % 3
	local gy = (self.gridIndex - gx) / 3
	
	local targetSide
	if self.side == 'allies' then targetSide = 'enemies'
	elseif self.side == 'enemies' then targetSide = 'allies'
	end
	
	if self.gridIndex <= 3 then
		if self:_getHeroFromGridIndex(targetSide, 3) then
			return self:_getHeroFromGridIndex(targetSide, 3)
		elseif self:_getHeroFromGridIndex(targetSide, 2) then
			return self:_getHeroFromGridIndex(targetSide, 2)
		elseif self:_getHeroFromGridIndex(targetSide, 1) then
			return self:_getHeroFromGridIndex(targetSide, 1)
		elseif self:_getHeroFromGridIndex(targetSide, 6) then
			return self:_getHeroFromGridIndex(targetSide, 6)
		elseif self:_getHeroFromGridIndex(targetSide, 5) then
			return self:_getHeroFromGridIndex(targetSide, 5)
		elseif self:_getHeroFromGridIndex(targetSide, 4) then
			return self:_getHeroFromGridIndex(targetSide, 4)
		elseif self:_getHeroFromGridIndex(targetSide, 9) then
			return self:_getHeroFromGridIndex(targetSide, 9)
		elseif self:_getHeroFromGridIndex(targetSide, 8) then
			return self:_getHeroFromGridIndex(targetSide, 8)
		elseif self:_getHeroFromGridIndex(targetSide, 7) then
			return self:_getHeroFromGridIndex(targetSide, 7)
		end
		
	elseif 4 <= self.gridIndex and self.gridIndex <= 6 then
		if self:_getHeroFromGridIndex(targetSide, 6) then
			return self:_getHeroFromGridIndex(targetSide, 6)
		elseif self:_getHeroFromGridIndex(targetSide, 5) then
			return self:_getHeroFromGridIndex(targetSide, 5)
		elseif self:_getHeroFromGridIndex(targetSide, 4) then
			return self:_getHeroFromGridIndex(targetSide, 4)
		elseif self:_getHeroFromGridIndex(targetSide, 3) then
			return self:_getHeroFromGridIndex(targetSide, 3)
		elseif self:_getHeroFromGridIndex(targetSide, 2) then
			return self:_getHeroFromGridIndex(targetSide, 2)
		elseif self:_getHeroFromGridIndex(targetSide, 1) then
			return self:_getHeroFromGridIndex(targetSide, 1)
		elseif self:_getHeroFromGridIndex(targetSide, 9) then
			return self:_getHeroFromGridIndex(targetSide, 9)
		elseif self:_getHeroFromGridIndex(targetSide, 8) then
			return self:_getHeroFromGridIndex(targetSide, 8)
		elseif self:_getHeroFromGridIndex(targetSide, 7) then
			return self:_getHeroFromGridIndex(targetSide, 7)
		end
		
	elseif 7 <= self.gridIndex then
		if self:_getHeroFromGridIndex(targetSide, 9) then
			return self:_getHeroFromGridIndex(targetSide, 9)
		elseif self:_getHeroFromGridIndex(targetSide, 8) then
			return self:_getHeroFromGridIndex(targetSide, 8)
		elseif self:_getHeroFromGridIndex(targetSide, 7) then
			return self:_getHeroFromGridIndex(targetSide, 7)
		elseif self:_getHeroFromGridIndex(targetSide, 6) then
			return self:_getHeroFromGridIndex(targetSide, 6)
		elseif self:_getHeroFromGridIndex(targetSide, 5) then
			return self:_getHeroFromGridIndex(targetSide, 5)
		elseif self:_getHeroFromGridIndex(targetSide, 4) then
			return self:_getHeroFromGridIndex(targetSide, 4)
		elseif self:_getHeroFromGridIndex(targetSide, 3) then
			return self:_getHeroFromGridIndex(targetSide, 3)
		elseif self:_getHeroFromGridIndex(targetSide, 2) then
			return self:_getHeroFromGridIndex(targetSide, 2)
		elseif self:_getHeroFromGridIndex(targetSide, 1) then
			return self:_getHeroFromGridIndex(targetSide, 1)
		end
		
	end
end

function BattleHero:takeDamage(damageType, damage)
	self.info.healthBar.value = self.info.healthBar.value - damage
	print(self.side, self.gridIndex, 'remaining hp', self.info.healthBar.value)

	if (self.info.healthBar.value <= 0) then
		self.isDead = true
	end
end


function BattleHero:_getHeroFromGridIndex(side, gridIndex)
	local heroes = GS.current()[side]
	
	for i, hero in ipairs(heroes) do
		if hero.gridIndex == gridIndex then
			return hero
		end
	end
end

return BattleHero
