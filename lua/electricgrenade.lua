function ElectricGrenade:_setup_from_tweak_data()
	local grenade_entry = self._tweak_projectile_entry or "wpn_gre_electric"
	local tweak_entry = tweak_data.projectiles[grenade_entry]
	self._init_timer = tweak_entry.init_timer or 2.5
	self._mass_look_up_modifier = tweak_entry.mass_look_up_modifier
	self._range = tweak_entry.range
	self._effect_name = tweak_entry.effect_name or "effects/particles/explosions/electric_grenade"
	self._curve_pow = tweak_entry.curve_pow or 3
	self._damage = tweak_entry.damage
	self._player_damage = tweak_entry.player_damage
	self._alert_radius = tweak_entry.alert_radius
	local sound_event = tweak_entry.sound_event or "grenade_explode"
	self._custom_params = {
		camera_shake_max_mul = 0,
		effect = self._effect_name,
		sound_event = sound_event,
		feedback_range = self._range * 2
	}
end

function ElectricGrenade:_tase_player()
	local player = managers.player:player_unit()

	if alive(player) and player == self:thrower_unit() and player:character_damage().on_self_tased then
		local detonate_pos = self._unit:position() + math.UP * 100
		local range = 650
		local affected, line_of_sight, travel_dis, linear_dis = QuickFlashGrenade._chk_dazzle_local_player(self, detonate_pos, range)

		if affected then
			player:character_damage():on_self_tased(0.45)
		end
	end
end