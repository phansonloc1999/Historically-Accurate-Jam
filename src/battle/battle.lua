local BattleHero = require 'src.battle.battleHeroes.battleHero'

local Battle = {}

function Battle:enter(from, allies, enemies)
	self.allies = {
		--BattleHero('allies', 1, {}, {1, 1, 0}),
		--BattleHero('allies', 3, {}, {1, 1, 0}),
		--BattleHero('allies', 5, {}, {1, 1, 0}),
		BattleHero('allies', 7, {}, {1, 1, 0}),
		--BattleHero('allies', 9, {}, {1, 1, 0}),
	}
	self.enemies = {
		--BattleHero('enemies', 3, {}, {0, 1, 1}),
		BattleHero('enemies', 4, {}, {0, 1, 1}),
		BattleHero('enemies', 5, {}, {0, 1, 1}),
		BattleHero('enemies', 6, {}, {0, 1, 1}),
		BattleHero('enemies', 9, {}, {0, 1, 1}),
	}
end

function Battle:update(dt)
	for i, ally in ipairs(self.allies) do
		ally:update(dt)
	end
	-- for i, enemy in ipairs(self.enemies) do
	-- 	enemy:update(dt)
	-- end

	for index, ally in ipairs(self.allies) do
		if (ally.isDead) then
			table.remove(self.allies, index)
		end
	end
	
	for index, enemy in ipairs(self.enemies) do
		if (enemy.isDead) then
			table.remove(self.enemies, index)
		end
	end
end

function Battle:draw()
	for i, ally in ipairs(self.allies) do
		local x, y = self:getWorldPosFromGridIndex('allies', ally.gridIndex)
		ally:draw(x, y)
	end
	for i, enemy in ipairs(self.enemies) do
		local x, y = self:getWorldPosFromGridIndex('enemies', enemy.gridIndex)
		enemy:draw(x, y)
	end
end

function Battle:getWorldPosFromGridIndex(side, gridIndex)
	local mul, ox
	if side == 'allies' then
		mul, ox = 1, 100
	elseif side == 'enemies' then
		mul, ox = -1, 640
	end
	
	local gx = (gridIndex - 1) % 3
	local gy = (gridIndex - gx) / 3 - 1
	
	return ox + gx * 80 * mul, 100 + gy * 80
end

return Battle
