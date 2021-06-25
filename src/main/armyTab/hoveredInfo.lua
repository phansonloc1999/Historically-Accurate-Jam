local HoveredInfo = Class('HoveredInfo')

function HoveredInfo:initialize()

end

function HoveredInfo:draw()
	local selection = GS.current().selection
	if selection == nil then
		return
	end

	local hero
	if selection.from == 'hero list' then
		hero = gameData.heroList[selection.index]
	elseif selection.from == 'army grid' then
		hero = gameData.heroList[GS.current().armyGrid.heroIndexes[selection.index]]
	end


	local text, textType, color
	local x, y
	
	local mx, my = love.mouse.getPosition()
	if 300 <= mx and mx <= 330 then
		if 352 <= my and my <= 382 then
			text = {
				'STRENGTH',
				'INCREASE PHYSICAL DAMAGE'
			}
			textType = 'stat'
			color = {247/255, 71/255, 74/255}
			x, y = 300, 314
			
		elseif 388 <= my and my <= 418 then
			text = {
				'SORCERY',
				'INCREASE MAGIC DAMAGE AND MAGIC DEFENSE'
			}
			textType = 'stat'
			color = {57/255, 124/255, 190/255}
			x, y = 300, 342
			
		elseif 424 <= my and my <= 454 then
			text = {
				'AGILITY',
				'INCREASE ATTACK SPEED AND PHYSICAL DEFENSE'
			} 
			textType = 'stat'
			color = {227/255, 211/255, 61/255}
			x, y = 300, 378
			
		elseif 460 <= my and my <= 490 then
			text = {
				'DURABILITY',
				'INCREASE HIT POINTS'
			}
			textType = 'stat'
			color = {65/255, 138/255, 97/255}
			x, y = 300, 414
			
		end
		
	elseif 132 <= mx and
			mx <= 152 + Fonts.main.heroSelectionSmall:getWidth('SKILL : ') + Fonts.main.heroSelectionMedium:getWidth(hero.skill) and
			510 <= my and my <= 542 then
		textType = 'skill'
		text = hero.skill
		x, y = 132, 480
	
	end
	
	if text ~= nil then
		if textType == 'stat' then	
			love.graphics.setColor(201/255, 199/255, 236/255, 0.7)
			love.graphics.rectangle('fill', x - 6, y,
					Fonts.main.heroSelectionSmall:getWidth(text[2]) + 12, 38, 4, 4)
			
			love.graphics.setFont(Fonts.main.heroSelectionSmall)
			love.graphics.setColor(color)
			love.graphics.print(text[1], x , y + 4)
			love.graphics.setColor(26/255, 31/255, 34/255)
			love.graphics.print(text[2], x , y + 20)
			
			
		elseif textType == 'skill' then
			text_ = self:getSkillInfo(text) or string.upper(text)
		
			love.graphics.setColor(201/255, 199/255, 236/255, 0.7)
			love.graphics.rectangle('fill', x - 6, y,
					Fonts.main.heroSelectionSmall:getWidth(text_) + 12, 22, 4, 4)
			
			love.graphics.setFont(Fonts.main.heroSelectionSmall)
			love.graphics.setColor(26/255, 31/255, 34/255)
			love.graphics.print(text_, x , y + 4)
			
		end
	end
end

function HoveredInfo:getSkillInfo(skill)
	if skill == 'rend' then
		return 'DEAL 250% PHYSICAL DAMAGE TO A SINGLE TARGET'
		
	elseif skill == 'divine' then
		return 'DEAL 80% MAGICAL DAMAGE AND BECOME INVULNERABLE FOR 1.25 SECONDS'
	
	elseif skill == 'regenerate' then
		return 'HEAL ALL TEAMATES EQUAL TO 60% MAGIC DAMAGE'
	
	elseif skill == 'smash' then
		return 'DEAL 240% MAGICAL DAMAGE HORIZONTALLY'
	
	elseif skill == 'mandate' then
		return 'INCREASE ALL TEAMATES MANA BY 33%'
	
	elseif skill == 'bastion' then
		return 'REDUCE DAMAGE TAKEN FOR ALL TEAMATES BY 50% FOR 1.5 SECONDS'
	
	elseif skill == 'strike' then
		return 'DEAL 325% MAGICAL DAMAGE TO A SINGLE TARGET AND IGNORE THEIR DEFENSE'
	
	elseif skill == 'disrupt' then
		return 'DEAL 150% MAGICAL DAMAGE AND STUN A SINGLE TARGET FOR 1 SECOND'
	
	end
end

return HoveredInfo
