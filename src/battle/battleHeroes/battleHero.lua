local BattleHero = Class('BattleHero')

function BattleHero:initialize(side, gridIndex, primaryStats, skill, sprite)
	self.side = side
	self.gridIndex = gridIndex

	self.primaryStats = primaryStats
	self.secondaryStats = {
		attackDamage = 4 + primaryStats.str * 1,
		secondsPerAttack = 15 / (10 + primaryStats.agi),
		
		magicPower = 4 + primaryStats.int * 1,
		
		hp = 40 + primaryStats.dur * 12,
		armor = 0 + primaryStats.agi * 0.5,
		magicResist = 0 + primaryStats.int * 0.75
	}
	self.skill = skill
	
	self.healthBar = HealthBar(self.secondaryStats.hp or 100, 50, 9)
	
	self.isDead = false

	self.sprite = sprite
	
	self.secondsToAttack = 0
	
	self.mana = 0
end

function BattleHero:update(dt)
	self.secondsToAttack = self.secondsToAttack - dt

	if self.secondsToAttack <= 0 then
		self:attack()
		
		self.secondsToAttack = self.secondaryStats.secondsPerAttack
	end
end

function BattleHero:draw(x, y)
	love.graphics.setColor(self.sprite)
	love.graphics.rectangle('fill', x, y, 60, 60)

	--- TODO: replace 30 with the width of self.sprite when it's added
	self.healthBar:draw(x + 30 - self.healthBar.width / 2, y - 20)
end

function BattleHero:attack()
	if self.mana >= 8 and self.isDead == false then
		self.mana = 0
		self:castSkill(self.skill)
	
	else
		local target = self:getTarget()
		target:takeDamage('physical', self.secondaryStats.attackDamage)

		self:addMana(1)
	end
end

function BattleHero:castSkill(skill)
	print('use skill '..skill)

	if skill == 'strike' then -------------------
		local target = self:getTarget()
		target:takeDamage('magical', self.secondaryStats.magicPower * 2.25)
		
		
	elseif skill == 'regenerate' then -----------
		local teamates = self:getAllTeamates()
		for i = 1, #teamates do
			teamates[i]:heal(self.secondaryStats.magicPower * 0.6)
		end
		
		
	elseif skill == 'smash' then ----------------
		local mainTargetY = math.floor(self:getTarget().gridIndex / 3)
		 
		local targets = self:getAllTargets()
		for i = 1, #targets do
			local targetY = math.floor(targets[i].gridIndex / 3)
			
			if targetY == mainTargetY then
				targets[i]:takeDamage('magical', self.secondaryStats.magicPower * 1.4)
			end
		end
	
	
	elseif skill == 'rend' then -----------------
		local target = self:getTarget()
		target:takeDamage('physical', self.secondaryStats.attackDamage * 2.0)
		
	
	elseif skill == 'mandate' then --------------
		-- buff allies attack speed
		
	end
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

function BattleHero:getAllTargets()
	local targetSide
	if self.side == 'allies' then targetSide = 'enemies'
	elseif self.side == 'enemies' then targetSide = 'allies'
	end
	
	return GS.current()[targetSide]
end

function BattleHero:getAllTeamates()
	return GS.current()[self.side]
end

function BattleHero:takeDamage(damageType, damage)
	local totalDamage
	if damageType == 'physical' then
		totalDamage = damage - self.secondaryStats.armor
	elseif damageType == 'magical' then
		totalDamage = damage - self.secondaryStats.magicResist
	end
	if totalDamage < 1 then totalDamage = 1 end
	
	self.healthBar.value = self.healthBar.value - totalDamage
	--print(self.side, self.gridIndex, 'remaining hp', self.healthBar.value)

	if (self.healthBar.value <= 0) then
		self.isDead = true
	end
	
	self:addMana(1)
end

function BattleHero:heal(healAmmount)
	self.healthBar.value = self.healthBar.value + healAmmount
	
	if self.healthBar.value > self.secondaryStats.hp then
		self.healthBar.value = self.secondaryStats.hp
	end
end

function BattleHero:addMana(num)
	self.mana = self.mana + num
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
