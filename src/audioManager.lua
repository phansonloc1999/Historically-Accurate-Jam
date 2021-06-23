AudioManager = Class('AudioManager')

function AudioManager:init()
	self.currentSong = nil
end

function AudioManager:playSound(sound_)
	local sound = Audio.sounds[sound_]
	if sound ~= nil then
		love.audio.stop(sound)
		love.audio.play(sound)
	end
end

function AudioManager:playSong(song_)
	local song = Audio.songs[song_]

	if song ~= nil then
		if self.currentSong ~= nil then
			love.audio.stop(self.currentSong)
		end
		self.currentSong = song
		
		love.audio.play(self.currentSong)
		self.currentSong:setLooping(true)
	end
end

function AudioManager:stopSong(waitUntilEnd)
	if not waitUntilEnd then
		love.audio.stop(self.currentSong)
		
	elseif waitUntilEnd then
		self.currentSong:setLooping(false)
	end
end
