love.graphics.setDefaultFilter("nearest", "nearest")

Sprites = {
	gui = {
		crysta = love.graphics.newImage("assets/gui/main/crysta.png"),
		main = {
			map_normal = love.graphics.newImage("assets/gui/main/map_normal.png"),
			map_hovered = love.graphics.newImage("assets/gui/main/map_hovered.png"),
			map_active = love.graphics.newImage("assets/gui/main/map_active.png"),
			
			army_normal = love.graphics.newImage("assets/gui/main/army_normal.png"),
			army_hovered = love.graphics.newImage("assets/gui/main/army_hovered.png"),
			army_active = love.graphics.newImage("assets/gui/main/army_active.png"),
			
			menu_normal = love.graphics.newImage("assets/gui/main/menu_normal.png"),
			menu_hovered = love.graphics.newImage("assets/gui/main/menu_hovered.png"),
			menu_active = love.graphics.newImage("assets/gui/main/menu_active.png"),
			
			emptySlot = love.graphics.newImage("assets/gui/main/emptySlot.png"),
			occupiedSlot = love.graphics.newImage("assets/gui/main/occupiedSlot.png"),
			occupiedSlotFrame = love.graphics.newImage("assets/gui/main/occupiedSlotFrame.png"),
			
			heroListBackground = love.graphics.newImage("assets/gui/main/heroListBackground.png"),
			heroListBuffer = love.graphics.newImage("assets/gui/main/heroListBuffer.png"),
			
			strength = love.graphics.newImage("assets/gui/main/strength.png"),
			durability = love.graphics.newImage("assets/gui/main/durability.png"),
			intelligence = love.graphics.newImage("assets/gui/main/intelligence.png"),
			agility = love.graphics.newImage("assets/gui/main/agility.png"),
			
			selectionBackground = love.graphics.newImage("assets/gui/main/selectionBackground.png"),
			
			upgradeButton_normal = love.graphics.newImage("assets/gui/main/upgradeButton_normal.png"),
			upgradeButton_hovered = love.graphics.newImage("assets/gui/main/upgradeButton_hovered.png"),
			upgradeButton_active = love.graphics.newImage("assets/gui/main/upgradeButton_active.png"),
			
			level_normal = love.graphics.newImage('assets/gui/main/level_normal.png'),
			level_hovered = love.graphics.newImage('assets/gui/main/level_hovered.png'),
			level_active = love.graphics.newImage('assets/gui/main/level_active.png'),
		},
		result = {
			background = love.graphics.newImage("assets/gui/result/background.png"),
			replay_normal = love.graphics.newImage("assets/gui/result/replay_normal.png"),
			replay_hovered = love.graphics.newImage("assets/gui/result/replay_hovered.png"),
			replay_active = love.graphics.newImage("assets/gui/result/replay_active.png"),
			exit_normal = love.graphics.newImage("assets/gui/result/exit_normal.png"),
			exit_hovered = love.graphics.newImage("assets/gui/result/exit_hovered.png"),
			exit_active = love.graphics.newImage("assets/gui/result/exit_active.png")
		},
		battle = {
			healthBar = love.graphics.newImage('assets/gui/battle/healthbar.png'),
			teamHealthBar = love.graphics.newImage('assets/gui/battle/teamHealthbar.png')
		}
	},
    
	heroes = {
		auCo = {
			full = love.graphics.newImage("assets/heroes/Au Co.png"),
			icon = love.graphics.newImage("assets/heroes/Au Co_icon.png")
		},
		sonTinh = {
			full = love.graphics.newImage("assets/heroes/Son Tinh.png"),
			icon = love.graphics.newImage("assets/heroes/Son Tinh_icon.png")
		},
		thuyTinh = {
			full = love.graphics.newImage("assets/heroes/Thuy Tinh.png"),
			icon = love.graphics.newImage("assets/heroes/Thuy Tinh_icon.png")
		},
		hungVuong = {
			full = love.graphics.newImage("assets/heroes/Hung Vuong.png"),
			icon = love.graphics.newImage("assets/heroes/Hung Vuong_icon.png")
		},
		thachSanh = {
			full = love.graphics.newImage("assets/heroes/Thach Sanh.png"),
			icon = love.graphics.newImage("assets/heroes/Thach Sanh_icon.png")
		},
		lacLongQuan = {
			full = love.graphics.newImage("assets/heroes/Lac Long Quan.png"),
			icon = love.graphics.newImage("assets/heroes/Lac Long Quan_icon.png")
		},
		chuDongTu = {
			full = love.graphics.newImage("assets/heroes/Chu Dong Tu.png"),
			icon = love.graphics.newImage("assets/heroes/Chu Dong Tu_icon.png")
		},
		thanhGiong = {
			full = love.graphics.newImage('assets/heroes/Thanh Giong.png'),
			icon = love.graphics.newImage('assets/heroes/Thanh Giong_icon.png'),
		}
	},

	enemies = {
		cung = love.graphics.newImage("assets/enemies/cung.png"),
		khien = love.graphics.newImage("assets/enemies/khien.png"),
		kiem = love.graphics.newImage("assets/enemies/kiem.png")
	},
	
	effects = {
		striker = love.graphics.newImage('assets/effects/striker.png'),
	},
	
	statuses = {
		invulnerable = love.graphics.newImage('assets/statuses/invulnerable.png'),
		shield = love.graphics.newImage('assets/statuses/shield.png'),
		stun = love.graphics.newImage('assets/statuses/stun.png'),
	},
	
	backgrounds = {
		[1] = love.graphics.newImage('assets/backgrounds/map 1-10.png')
	}
}

Fonts = {
		menu = {
				bigTitle = love.graphics.newFont("assets/fonts/04B_03B_.TTF", 32)
		},
    main = {
        heroSelectionBig = love.graphics.newFont("assets/fonts/04B_08__.TTF", 32),
        heroSelectionMedium = love.graphics.newFont("assets/fonts/04B_03B_.TTF", 24),
        heroSelectionSmall = love.graphics.newFont("assets/fonts/04B_03B_.TTF", 16),
        title = love.graphics.newFont("assets/fonts/04B_08__.TTF", 24),
        level = love.graphics.newFont("assets/fonts/04B_08__.TTF", 16)
    },
    battle = {
        damagePopUp = love.graphics.newFont("assets/fonts/04B_03B_.TTF", 24),
        damagePopUpBig = love.graphics.newFont("assets/fonts/04B_03B_.TTF", 32)
    },
    result = {
        title = love.graphics.newFont("assets/fonts/04B_03B_.TTF", 24)
    }
}

Audio = {
    sounds = {
        gui1 = love.audio.newSource("assets/sounds/gui1.wav", "static"),
        gui2 = love.audio.newSource("assets/sounds/gui2.wav", "static"),
        
        hit1 = love.audio.newSource('assets/sounds/hit1.wav', 'static'),
        heal = love.audio.newSource('assets/sounds/heal.wav', 'static'),
        buff = love.audio.newSource('assets/sounds/buff.wav', 'static')
    },
    musics = {
			battle = love.audio.newSource("assets/musics/battle.mp3", "stream")
	}
}

Audio.sounds.gui2:setPitch(0.83)
Audio.musics.battle:setVolume(0.64)
Audio.musics.battle:setPitch(0.812)
