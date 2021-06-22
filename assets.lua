love.graphics.setDefaultFilter('nearest', 'nearest')

Sprites = {
	gui = {
		crysta = love.graphics.newImage('assets/gui/main/crysta.png'),
		main = {
			map_normal = love.graphics.newImage('assets/gui/main/map_normal.png'),
			map_hovered = love.graphics.newImage('assets/gui/main/map_hovered.png'),
			map_active = love.graphics.newImage('assets/gui/main/map_active.png'),
		
			army_normal = love.graphics.newImage('assets/gui/main/army_normal.png'),
			army_hovered = love.graphics.newImage('assets/gui/main/army_hovered.png'),
			army_active = love.graphics.newImage('assets/gui/main/army_active.png'),
			
			menu_normal = love.graphics.newImage('assets/gui/main/menu_normal.png'),
			menu_hovered = love.graphics.newImage('assets/gui/main/menu_hovered.png'),
			menu_active = love.graphics.newImage('assets/gui/main/menu_active.png'),
			
			emptySlot = love.graphics.newImage('assets/gui/main/emptySlot.png'),
			occupiedSlot = love.graphics.newImage('assets/gui/main/occupiedSlot.png'),
			occupiedSlotFrame = love.graphics.newImage('assets/gui/main/occupiedSlotFrame.png'),
			
			heroListBackground = love.graphics.newImage('assets/gui/main/heroListBackground.png'),
			heroListBuffer = love.graphics.newImage('assets/gui/main/heroListBuffer.png'),
			
			strength = love.graphics.newImage('assets/gui/main/strength.png'),
			durability = love.graphics.newImage('assets/gui/main/durability.png'),
			intelligence = love.graphics.newImage('assets/gui/main/intelligence.png'),
			agility = love.graphics.newImage('assets/gui/main/agility.png'),
			
			selectionBackground = love.graphics.newImage('assets/gui/main/selectionBackground.png'),
			
			upgradeButton_normal = love.graphics.newImage('assets/gui/main/upgradeButton_normal.png'),
			upgradeButton_hovered = love.graphics.newImage('assets/gui/main/upgradeButton_hovered.png'),
			upgradeButton_active = love.graphics.newImage('assets/gui/main/upgradeButton_active.png'),
		}
	},
	
	heroes = {
		auCo = {
			full = love.graphics.newImage('assets/heroes/Au Co.png'),
			icon = love.graphics.newImage('assets/heroes/Au Co_icon.png')
		},
		sonTinh = {
			full = love.graphics.newImage('assets/heroes/Son Tinh.png'),
			icon = love.graphics.newImage('assets/heroes/Son Tinh_icon.png')
		},
		thuyTinh = {
			full = love.graphics.newImage('assets/heroes/Thuy Tinh.png'),
			icon = love.graphics.newImage('assets/heroes/Thuy Tinh_icon.png')
		},
		hungVuong = {
			full = love.graphics.newImage('assets/heroes/Hung Vuong.png'),
			icon = love.graphics.newImage('assets/heroes/Hung Vuong_icon.png')
		},
	}
}

Fonts = {
	main = {
		heroSelectionBig = love.graphics.newFont('assets/fonts/04B_08__.TTF', 32),
		heroSelectionMedium = love.graphics.newFont('assets/fonts/04B_03B_.TTF', 24),
		heroSelectionSmall = love.graphics.newFont('assets/fonts/04B_03B_.TTF', 16),
		title = love.graphics.newFont('assets/fonts/04B_08__.TTF', 24)
	}
}
