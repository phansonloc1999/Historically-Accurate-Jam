local DamagePopUp = require 'src.battle.battleHeroes.damagePopUp'

local BattleHero = Class('BattleHero')

function BattleHero:initialize(side, gridIndex, stats, upgrades, skill, sprite)
	self.side = side
	self.gridIndex = gridIndex

	local upgrades = upgrades or {str = 0, dur = 0, int = 0, agi = 0}
	self.primaryStats = {
		str = stats.str + upgrades.str,
		dur = stats.dur + upgrades.dur,
		int = stats.int + upgrades.int,
		agi = stats.agi + upgrades.agi,
	}
	self.secondaryStats = {
		attackDamage = 10 + self.primaryStats.str * 2,
		secondsPerAttack = 15 / (10 + self.primaryStats.agi),
		
		magicPower = 15 + self.primaryStats.int * 2,
		
		hp = 46 + self.primaryStats.dur * 18,
		armor = 0 + self.primaryStats.agi * 1,
		magicResist = 0 + self.primaryStats.int * 1.5
	}
	self.skill = skill
	
	self.healthBar = HealthBar(self, self.secondaryStats.hp or 100, 50, 9)
	
	local x, y = GS.current():getWorldPosFromGridIndex(self.side, self.gridIndex)
	self.damagePopUp = DamagePopUp(x, y)
	
	self.isDead = false
	
	self.secondsToAttack = 0
	
	self.mana = 0
	
	self.secondsToEndInvulnerability = 0
	self.secondsToEndStun = 0
	self.secondsToEndShield = 0
	
	self.sprite = sprite
end

function BattleHero:update(dt)
	self.secondsToEndStun = self.secondsToEndStun - dt

	if self.secondsToEndStun <= 0 then
		self.secondsToAttack = self.secondsToAttack - dt
		if self.secondsToAttack <= 0 then
			self:attack()
			self.secondsToAttack = self.secondaryStats.secondsPerAttack
		end
		
		self.secondsToEndInvulnerability = self.secondsToEndInvulnerability - dt
		self.secondsToEndShield = self.secondsToEndShield - dt
	end
	
	self.damagePopUp:update(dt)
end

function BattleHero:draw(x, y)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, x, y, 0, 2)
	
	self.healthBar:draw(x + self.sprite:getWidth() - self.healthBar.width / 2, y - 22)
	
	self.damagePopUp:draw()
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

	if skill == 'strike' then --------------------------
		local target = self:getTarget()
		target:takeDamage('magical', self.secondaryStats.magicPower * 2.5, true)
		
		
	elseif skill == 'regenerate' then ------------------
		local teamates = self:getAllTeamates()
		for i = 1, #teamates do
			teamates[i]:heal(self.secondaryStats.magicPower * 0.7)
		end
		
		
	elseif skill == 'smash' then -----------------------
		local mainTargetY = math.floor((self:getTarget().gridIndex-1) / 3)
		 
		local targets = self:getAllTargets()
		for i = 1, #targets do
			local targetY = math.floor((targets[i].gridIndex-1) / 3)
			
			if targetY == mainTargetY then
				targets[i]:takeDamage('magical', self.secondaryStats.magicPower * 1.9)
			end
		end
	
	
	elseif skill == 'rend' then ------------------------
		local target = self:getTarget()
		target:takeDamage('physical', self.secondaryStats.attackDamage * 2.5)
		
	
	elseif skill == 'mandate' then ---------------------
		local teamates = self:getAllTeamates()
		for i = 1, #teamates do
			if teamates[i] ~= self then
				teamates[i]:addMana(3)
			end
		end
		
		
	elseif skill == 'divine' then ----------------------
		self.secondsToEndInvulnerability = 2
		
		local target = self:getTarget()
		target:takeDamage('magical', self.secondaryStats.magicPower * 1.0)
		
		
	elseif skill == 'disrupt' then ---------------------
		local target = self:getTarget()
		target:takeDamage('magical', self.secondaryStats.magicPower * 0.75)
		target:stun(1)
		
	
	elseif skill == 'bastion'	then ---------------------
		local teamates = self:getAllTeamates()
		for i = 1, #teamates do
			teamates[i].secondsToEndArmored = 2
		end
		
		local target = self:getTarget()
		target:takeDamage('magical', self.secondaryStats.magicPower * 1.0)
	
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

function BattleHero:takeDamage(damageType, damage, isTrueDamage)
	local totalDamage
	if self.secondsToEndInvulnerability > 0 then
		totalDamage = 1
	else
		if isTrueDamage then
			totalDamage = damage
		elseif damageType == 'physical' then
			totalDamage = damage - self.secondaryStats.armor
		elseif damageType == 'magical' then
			totalDamage = damage - self.secondaryStats.magicResist
		end
		
		if self.secondsToEndShield then
			totalDamage = totalDamage / 2
		end
	end
	totalDamage = math.floor(totalDamage + 0.5)
	if totalDamage < 1 then totalDamage = 1 end
	
	self.healthBar.value = self.healthBar.value - totalDamage
	
	self.damagePopUp:onDamageTaken(totalDamage)
	

	if (self.healthBar.value <= 0) then
		self.isDead = true
	end
	
	self:addMana(1)
end

function BattleHero:heal(healAmmount)
	local healAmmount = math.floor(healAmmount + 0.5)

	self.healthBar.value = self.healthBar.value + healAmmount
	
	if self.healthBar.value > self.secondaryStats.hp then
		self.damagePopUp:onHealthHeal(healAmmount - (self.healthBar.value - self.secondaryStats.hp))
	
		self.healthBar.value = self.secondaryStats.hp
	else
		self.damagePopUp:onHealthHeal(healAmmount)
	end
end

function BattleHero:stun(duration)
	if self.secondsToEndStun < duration then
		self.secondsToEndStun = duration
	end
end

function BattleHero:shield(duration)
	if self.secondsToEndShield < duration then
		self.secondsToEndShield = duration
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
