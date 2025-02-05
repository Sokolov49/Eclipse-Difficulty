-- aimpunch
local play_shaker_original = PlayerCamera.play_shaker
function PlayerCamera:play_shaker(effect, amplitude, ...)
	if effect == "player_bullet_damage" then
		effect = "player_bullet_damage_var" .. math.random(1, 4)
		amplitude = self._damage_bullet_shake_multiplier
	end
	return play_shaker_original(self, effect, amplitude, ...)
end