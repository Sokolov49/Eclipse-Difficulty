-- Fix flash grenade timer
Hooks:PreHook(QuickFlashGrenade, "init", "eclipse_init", function()
	QuickFlashGrenade.States[3][2] = QuickFlashGrenade.States[3][2] or tweak_data.group_ai.flash_grenade.timer
end)

--get rid of the beepbeep
function QuickFlashGrenade:_beep()
	self._beep_t = self:_get_next_beep_time()
	self._light_multiplier = 0
end

--get rid of the screen shake
function QuickFlashGrenade:make_flash(detonate_pos, range, ignore_units)
	local range = range or 1000
	local effect_params = {
		sound_event = "flashbang_explosion",
		effect = "effects/particles/explosions/explosion_flash_grenade",
		camera_shake_max_mul = 0,
		feedback_range = range * 2
	}

	managers.explosion:play_sound_and_effects(detonate_pos, math.UP, range, effect_params)

	ignore_units = ignore_units or {}

	table.insert(ignore_units, self._unit)

	local affected, line_of_sight, travel_dis, linear_dis = self:_chk_dazzle_local_player(detonate_pos, range, ignore_units)

	if affected then
		managers.environment_controller:set_flashbang(detonate_pos, line_of_sight, travel_dis, linear_dis, tweak_data.character.flashbang_multiplier, nil, true)

		local sound_eff_mul = math.clamp(1 - (travel_dis or linear_dis) / range, 0.3, 1)

		managers.player:player_unit():character_damage():on_flashbanged(sound_eff_mul)
	end
end