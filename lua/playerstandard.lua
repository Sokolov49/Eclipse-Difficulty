-- Friendly Fire
local original_init = PlayerStandard.init
function PlayerStandard:init(unit)
	original_init(self, unit)

	if Global.game_settings and Global.game_settings.one_down then
		self._slotmask_bullet_impact_targets = self._slotmask_bullet_impact_targets + 3
	else
		self._slotmask_bullet_impact_targets = managers.mutators:modify_value("PlayerStandard:init:melee_slot_mask", self._slotmask_bullet_impact_targets)
	end
end

function PlayerStandard:_get_swap_speed_multiplier()
	local multiplier = 1

	local weap_base = self._equipped_unit:base()
	local weapon_tweak_data = weap_base.weapon_tweak_data and weap_base:weapon_tweak_data() or tweak_data.weapon[weap_base:get_name_id()]

	multiplier = multiplier * (weapon_tweak_data.swap_speed_multiplier or 1)

	multiplier = multiplier * managers.player:upgrade_value("weapon", "swap_speed_multiplier", 1)
	multiplier = multiplier * managers.player:upgrade_value("weapon", "passive_swap_speed_multiplier", 1)

	for _, category in ipairs(weapon_tweak_data.categories) do
		multiplier = multiplier * managers.player:upgrade_value(category, "swap_speed_multiplier", 1)
	end

	multiplier = multiplier * managers.player:upgrade_value("team", "crew_faster_swap", 1)

	if managers.player:has_activate_temporary_upgrade("temporary", "swap_weapon_faster") then
		multiplier = multiplier * managers.player:temporary_upgrade_value("temporary", "swap_weapon_faster", 1)
	end

	if managers.player:has_activate_temporary_upgrade("pistol", "empty_quickdraw") then
		multiplier = multiplier * managers.player:upgrade_value("pistol", "empty_quickdraw")[1]
	end

	multiplier = managers.modifiers:modify_value("PlayerStandard:GetSwapSpeedMultiplier", multiplier)
	multiplier = multiplier * managers.player:upgrade_value("weapon", "mrwi_swap_speed_multiplier", 1)

	return multiplier
end

function PlayerStandard:_end_action_running(t)
	if not self._end_running_expire_t then
		local weap_base = self._equipped_unit:base()

		local speed_multiplier = weap_base:exit_run_speed_multiplier() * (weap_base:concealment_to_sprint_exit_speed() or 1)

		self._end_running_expire_t = t + 0.4 / speed_multiplier

		local stop_running = not weap_base:run_and_shoot_allowed() and (not self.RUN_AND_RELOAD or not self:_is_reloading())

		if not self:_is_meleeing() and stop_running then
			self._ext_camera:play_redirect(self:get_animation("stop_running"), speed_multiplier)
		end
	end
end

Hooks:PostHook(PlayerStandard, "_get_max_walk_speed", "hits_get_max_walk_speed", function(self, t)
	local weap_base = self._equipped_unit:base()
	local weapon_tweak_data = weap_base.weapon_tweak_data and weap_base:weapon_tweak_data() or tweak_data.weapon[weap_base:get_name_id()]

	if self._state_data.in_steelsight and not managers.player:has_category_upgrade("player", "steelsight_normal_movement_speed") and not _G.IS_VR then
		self._tweak_data.movement.speed.STEELSIGHT_MAX = self._tweak_data.movement.speed.STANDARD_MAX * (weapon_tweak_data.steelsight_move_speed_mul or 1)
	end
end)

-- Spray pattern implementation
-- Oh man! This is just like Counter-Strike!
function PlayerStandard:_check_action_primary_attack(t, input, params)
	local new_action, action_wanted = nil
	action_wanted = (not params or params.action_wanted == nil or params.action_wanted)
		and (input.btn_primary_attack_state or input.btn_primary_attack_release or self:is_shooting_count() or self:_is_charging_weapon())

	if action_wanted then
		local action_forbidden = nil

		if params and params.action_forbidden ~= nil then
			action_forbidden = params.action_forbidden
		elseif
			self:_is_reloading()
			or self:_changing_weapon()
			or self:_is_meleeing()
			or self._use_item_expire_t
			or self:_interacting()
			or self:_is_throwing_projectile()
			or self:_is_deploying_bipod()
			or self._menu_closed_fire_cooldown > 0
			or self:is_switching_stances()
		then
			action_forbidden = true
		else
			action_forbidden = false
		end

		if not action_forbidden then
			self._queue_reload_interupt = nil
			local start_shooting = false

			self._ext_inventory:equip_selected_primary(false)

			local weap_unit = self._equipped_unit

			if weap_unit then
				local weap_base = weap_unit:base()
				local fire_mode = weap_base:fire_mode()
				local fire_on_release = weap_base:fire_on_release()

				if weap_base:out_of_ammo() then
					if input.btn_primary_attack_press then
						weap_base:dryfire()
					end
				elseif weap_base.clip_empty and weap_base:clip_empty() then
					if params and params.no_reload or self:_is_using_bipod() then
						if input.btn_primary_attack_press then
							weap_base:dryfire()
						end

						weap_base:tweak_data_anim_stop("fire")
					else
						local fire_mode_func = self._primary_action_funcs.clip_empty[fire_mode]

						if not fire_mode_func or not fire_mode_func(self, t, input, params, weap_unit, weap_base) then
							fire_mode_func = self._primary_action_funcs.clip_empty.default

							if fire_mode_func then
								fire_mode_func(self, t, input, params, weap_unit, weap_base)
							end
						end

						new_action = self:_is_reloading()
					end
				elseif params and params.block_fire then
					-- Nothing
				elseif self._running and (params and params.no_running or weap_base.run_and_shoot_allowed and not weap_base:run_and_shoot_allowed()) then
					self:_interupt_action_running(t)
				else
					if not self._shooting then
						if weap_base:start_shooting_allowed() then
							local start = nil
							local start_fire_func = self._primary_action_get_value.chk_start_fire[fire_mode]

							if start_fire_func then
								start = start_fire_func(self, t, input, params, weap_unit, weap_base)
							else
								start_fire_func = self._primary_action_get_value.chk_start_fire.default

								if start_fire_func then
									start = start_fire_func(self, t, input, params, weap_unit, weap_base)
								end
							end

							if not params or not params.no_start_fire_on_release then
								start = start and not fire_on_release
								start = start or fire_on_release and input.btn_primary_attack_release
							end

							if start then
								weap_base:start_shooting()
								self._camera_unit:base():start_shooting()

								self._shooting = true
								self._shooting_t = t
								start_shooting = true
								local fire_mode_func = self._primary_action_funcs.start_fire[fire_mode]

								if not fire_mode_func or not fire_mode_func(self, t, input, params, weap_unit, weap_base) then
									fire_mode_func = self._primary_action_funcs.start_fire.default

									if fire_mode_func then
										fire_mode_func(self, t, input, params, weap_unit, weap_base)
									end
								end
							end
						elseif not params or not params.no_check_stop_shooting_early then
							self:_check_stop_shooting()

							return false
						end
					end

					local suppression_ratio = self._unit:character_damage():effective_suppression_ratio()
					local spread_mul = math.lerp(1, tweak_data.player.suppression.spread_mul, suppression_ratio)
					local autohit_mul = math.lerp(1, tweak_data.player.suppression.autohit_chance_mul, suppression_ratio)
					local suppression_mul = managers.blackmarket:threat_multiplier()
					local dmg_mul = 1
					local weapon_tweak_data = weap_base:weapon_tweak_data()
					local primary_category = weapon_tweak_data.categories[1]

					if not weapon_tweak_data.ignore_damage_multipliers then
						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "dmg_multiplier_outnumbered", 1)

						if self._overkill_all_weapons or weap_base:is_category("shotgun", "saw") then
							dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "overkill_damage_multiplier", 1)
						end

						local health_ratio = self._ext_damage:health_ratio()
						local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, primary_category)

						if damage_health_ratio > 0 then
							local upgrade = weap_base:is_category("saw") and self._damage_health_ratio_mul_melee or self._damage_health_ratio_mul
							dmg_mul = dmg_mul * (1 + upgrade * damage_health_ratio)
						end

						dmg_mul = dmg_mul * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
						dmg_mul = dmg_mul * managers.player:get_property("trigger_happy", 1)
					end

					local fired = nil
					local fired_func = self._primary_action_get_value.fired[fire_mode]

					if fired_func then
						fired = fired_func(self, t, input, params, weap_unit, weap_base, start_shooting, fire_on_release, dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
					else
						fired_func = self._primary_action_get_value.fired.default

						if fired_func then
							fired = fired_func(self, t, input, params, weap_unit, weap_base, start_shooting, fire_on_release, dmg_mul, nil, spread_mul, autohit_mul, suppression_mul)
						end
					end

					if (not params or not params.no_steelsight) and weap_base.manages_steelsight and weap_base:manages_steelsight() then
						if weap_base:wants_steelsight() and not self._state_data.in_steelsight then
							self:_start_action_steelsight(t)
						elseif not weap_base:wants_steelsight() and self._state_data.in_steelsight then
							self:_end_action_steelsight(t)
						end
					end

					local charging_weapon = weap_base:charging()

					if not self._state_data.charging_weapon and charging_weapon then
						self:_start_action_charging_weapon(t)
					elseif self._state_data.charging_weapon and not charging_weapon then
						self:_end_action_charging_weapon(t)
					end

					new_action = true

					if fired then
						if not params or not params.no_rumble then
							managers.rumble:play("weapon_fire")
						end

						local weap_tweak_data = weap_base.weapon_tweak_data and weap_base:weapon_tweak_data() or tweak_data.weapon[weap_base:get_name_id()]

						if not params or not params.no_shake then
							local shake_tweak_data = weap_tweak_data.shake[fire_mode] or weap_tweak_data.shake
							local shake_multiplier = shake_tweak_data[self._state_data.in_steelsight and "fire_steelsight_multiplier" or "fire_multiplier"]

							self._ext_camera:play_shaker("fire_weapon_rot", 1 * shake_multiplier)
							self._ext_camera:play_shaker("fire_weapon_kick", 1 * shake_multiplier, 1, 0.15)
						end

						weap_base:tweak_data_anim_stop("unequip")
						weap_base:tweak_data_anim_stop("equip")

						if
							(not params or not params.no_steelsight)
							and (not self._state_data.in_steelsight or not weap_base:tweak_data_anim_play("fire_steelsight", weap_base:fire_rate_multiplier()))
						then
							weap_base:tweak_data_anim_play("fire", weap_base:fire_rate_multiplier())
						end

						if (not params or not params.no_recoil_anim_redirect) and not weap_tweak_data.no_recoil_anim_redirect then
							local fire_mode_func = self._primary_action_funcs.recoil_anim_redirect[fire_mode]

							if not fire_mode_func or not fire_mode_func(self, t, input, params, weap_unit, weap_base) then
								fire_mode_func = self._primary_action_funcs.recoil_anim_redirect.default

								if fire_mode_func then
									fire_mode_func(self, t, input, params, weap_unit, weap_base)
								end
							end
						end

						local recoil_multiplier = (weap_base:recoil() + weap_base:recoil_addend()) * weap_base:recoil_multiplier()

						-- Modify starting here
						local kick_tweak_data = weap_tweak_data.kick[fire_mode] or weap_tweak_data.kick
						local up, down, left, right = unpack(kick_tweak_data[self._state_data.in_steelsight and "steelsight" or self._state_data.ducking and "crouching" or "standing"])

						local apply_spray = false
						if fire_mode == "auto" and weap_tweak_data.spray then -- temporary spray check before we add it to all weapons
							pattern_tweak_data = weap_tweak_data.spray.pattern -- first part of spray pattern
							persist_pattern_tweak_data = weap_tweak_data.spray.persist_pattern -- second part of spray pattern (persist pattern)
							recoil_recovery = weap_tweak_data.recoil_recovery_timer
							apply_spray = true
						end

						if apply_spray and not _G.IS_VR then
							self._camera_unit:base():pattern_recoil_kick(pattern_tweak_data, persist_pattern_tweak_data, recoil_multiplier, recoil_recovery)
						else
							self._camera_unit:base():recoil_kick(up * recoil_multiplier, down * recoil_multiplier, left * recoil_multiplier, right * recoil_multiplier)
						end
						-- End modification

						if self._shooting_t then
							local time_shooting = t - self._shooting_t
							local achievement_data = tweak_data.achievement.never_let_you_go

							if achievement_data and weap_base:get_name_id() == achievement_data.weapon_id and achievement_data.timer <= time_shooting then
								managers.achievment:award(achievement_data.award)

								self._shooting_t = nil
							end
						end

						if managers.player:has_category_upgrade(primary_category, "stacking_hit_damage_multiplier") then
							self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
							self._state_data.stacking_dmg_mul[primary_category] = self._state_data.stacking_dmg_mul[primary_category] or {
								nil,
								0,
							}
							local stack = self._state_data.stacking_dmg_mul[primary_category]

							if fired.hit_enemy then
								stack[1] = t + managers.player:upgrade_value(primary_category, "stacking_hit_expire_t", 1)
								stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_weapon_dmg_mul_stacks or 5)
							else
								stack[1] = nil
								stack[2] = 0
							end
						end

						if (not params or not params.no_recharge_clbk) and weap_base.set_recharge_clbk then
							weap_base:set_recharge_clbk(callback(self, self, "weapon_recharge_clbk_listener"))
						end

						managers.hud:set_ammo_amount(weap_base:selection_index(), weap_base:ammo_info())

						if self._ext_network then
							local impact = not fired.hit_enemy
							local sync_blank_func = self._primary_action_funcs.sync_blank[fire_mode]

							if not sync_blank_func or not sync_blank_func(self, t, input, params, weap_unit, weap_base, impact) then
								sync_blank_func = self._primary_action_funcs.sync_blank.default

								if sync_blank_func then
									sync_blank_func(self, t, input, params, weap_unit, weap_base, impact)
								end
							end
						end

						local stop_volley_func = self._primary_action_get_value.check_stop_shooting_volley[fire_mode]

						if stop_volley_func then
							new_action = stop_volley_func(self, t, input, params, weap_unit, weap_base)
						else
							stop_volley_func = self._primary_action_get_value.check_stop_shooting_volley.default

							if stop_volley_func then
								new_action = stop_volley_func(self, t, input, params, weap_unit, weap_base)
							end
						end
					else
						local not_fired_func = self._primary_action_get_value.not_fired[fire_mode]

						if not_fired_func then
							new_action = not_fired_func(self, t, input, params, weap_unit, weap_base)
						else
							not_fired_func = self._primary_action_get_value.not_fired.default

							if not_fired_func then
								new_action = not_fired_func(self, t, input, params, weap_unit, weap_base)
							end
						end
					end
				end
			end
		elseif self:_is_reloading() and self._equipped_unit and self._equipped_unit:base():reload_interuptable() and input.btn_primary_attack_press then
			self._queue_reload_interupt = true
		end
	end

	self:_chk_action_stop_shooting(new_action)

	return new_action
end

-- No more sixth sense
Hooks:OverrideFunction(PlayerStandard, "_update_omniscience", function(self, ...)
	return
end)

-- Don't update sixth sense anymore and add sprint reload upgrade to shotguns
Hooks:OverrideFunction(PlayerStandard, "update", function(self, t, dt)
	PlayerMovementState.update(self, t, dt)
	self:_calculate_standard_variables(t, dt)
	self:_update_ground_ray()
	self:_update_fwd_ray()
	self:_update_check_actions(t, dt)

	if self._menu_closed_fire_cooldown > 0 then
		self._menu_closed_fire_cooldown = self._menu_closed_fire_cooldown - dt
	end

	self:_update_movement(t, dt)
	self:_upd_nav_data()
	managers.hud:_update_crosshair_offset(t, dt)
	self:_upd_stance_switch_delay(t, dt)
	self.RUN_AND_RELOAD = managers.player:has_category_upgrade("player", "run_and_reload")
		or self._equipped_unit and self._equipped_unit:base():is_category("shotgun") and managers.player:has_category_upgrade("shotgun", "run_and_reload")
end)

-- Melee while running
-- Code from melee overhaul
Hooks:PostHook(PlayerStandard, "_start_action_running", "eclipse_start_action_running", function(self, t)
	if managers.player and managers.player:has_category_upgrade("player", "run_and_melee_eclipse") then
		if not self._move_dir then
			self._running_wanted = true
			return
		end

		if self:on_ladder() or self:_on_zipline() then
			return
		end

		if
			self._shooting and not managers.player.RUN_AND_SHOOT
			or self:_changing_weapon()
			or self._use_item_expire_t
			or self._state_data.in_air
			or self:_is_throwing_projectile()
			or self:_is_charging_weapon()
		then
			self._running_wanted = true
			return
		end

		if self._state_data.ducking and not self:_can_stand() then
			self._running_wanted = true
			return
		end

		if not self:_can_run_directional() then
			return
		end

		if not self:_is_meleeing() and self._camera_unit:base()._melee_item_units then
			self._running_wanted = true
			return
		end

		self._running_wanted = false

		if managers.player:get_player_rule("no_run") then
			return
		end

		if not self._unit:movement():is_above_stamina_threshold() then
			return
		end

		if (not self._state_data.shake_player_start_running or not self._ext_camera:shaker():is_playing(self._state_data.shake_player_start_running)) and managers.user:get_setting("use_headbob") then
			self._state_data.shake_player_start_running = self._ext_camera:play_shaker("player_start_running", 0.75)
		end

		self:set_running(true)

		self._end_running_expire_t = nil
		self._start_running_t = t

		if not self.RUN_AND_RELOAD then
			self:_interupt_action_reload(t)
		end

		self:_interupt_action_steelsight(t)
		self:_interupt_action_ducking(t)
	end
end)

function PlayerStandard:_end_action_running(t)
	if not self._end_running_expire_t then
		local speed_multiplier = self._equipped_unit:base():exit_run_speed_multiplier()
		self._end_running_expire_t = t + 0.4 / speed_multiplier
		local stop_running = not self._equipped_unit:base():run_and_shoot_allowed() and (not self.RUN_AND_RELOAD or not self:_is_reloading())

		if not self:_is_meleeing() and stop_running then
			self._ext_camera:play_redirect(self:get_animation("stop_running"), speed_multiplier)
		end
	end
end

Hooks:PreHook(PlayerStandard, "_start_action_melee", "eclipse_pre_start_action_melee", function(self, t, input, instant)
	self._state_data.melee_running_wanted = true and self._running and not self._end_running_expire_t
end)

Hooks:PostHook(PlayerStandard, "_start_action_melee", "eclipse_post_start_action_melee", function(self, t, input, instant)
	if self._state_data.melee_running_wanted then
		self._running_wanted = true
	end

	self._state_data.melee_running_wanted = nil
end)

Hooks:PreHook(PlayerStandard, "_update_melee_timers", "eclipse_update_melee_timers", function(self, t, input)
	local melee_entry = managers.blackmarket:equipped_melee_weapon()
	local instant = tweak_data.blackmarket.melee_weapons[melee_entry].instant

	if not instant and not self._state_data.melee_repeat_expire_t and self._state_data.melee_expire_t and t >= self._state_data.melee_expire_t then
		if self._running and not self._end_running_expire_t then
			if not self:_is_reloading() or not self.RUN_AND_RELOAD then
				if not self._equipped_unit:base():run_and_shoot_allowed() and not self._state_data.meleeing then
					self._ext_camera:play_redirect(self:get_animation("start_running"))
				else
					if not self._state_data.meleeing then
						self._ext_camera:play_redirect(self:get_animation("idle"))
					end
				end
			end
		end
	end

	if instant and self._state_data.melee_expire_t and t >= self._state_data.melee_expire_t then
		if self._running and not self._end_running_expire_t then
			if not self:_is_reloading() or not self.RUN_AND_RELOAD then
				if not self._equipped_unit:base():run_and_shoot_allowed() and not self._state_data.meleeing then
					self._ext_camera:play_redirect(self:get_animation("start_running"))
				else
					if not self._state_data.meleeing then
						self._ext_camera:play_redirect(self:get_animation("idle"))
					end
				end
			end
		end
	end
end)

Hooks:PostHook(PlayerStandard, "_interupt_action_melee", "eclipse_interupt_action_melee", function(self, t)
	if managers.player and managers.player:has_category_upgrade("player", "run_and_melee_eclipse") then
		local running = self._running and not self._end_running_expire_t

		self:_interupt_action_running(t)

		if running then
			self._running_wanted = true
		end
	end
end)
-- End melee overhaul code

-- no interaction cooldown, credit goes to chibibowa
local old_check_use = PlayerStandard._check_use_item

function PlayerStandard:_check_use_item(t, input)
	if input.btn_use_item_release and self._throw_time and t and t < self._throw_time then
		managers.player:drop_carry()
		self._throw_time = nil
		return true
	else
		return old_check_use(self, t, input)
	end
end

function PlayerManager.carry_blocked_by_cooldown()
	return false
end

function PlayerStandard:_get_interaction_speed()
	local dt = managers.player:player_timer():delta_time()
	local morale_boost_bonus = self._ext_movement:morale_boost()
	if morale_boost_bonus then
		dt = dt * morale_boost_bonus.move_speed_bonus
	end
	
	return dt
end

-- Viewbob when in ADS
function PlayerStandard:_get_walk_headbob()
	if self._state_data.in_steelsight then
		return 0.00125
	elseif self._state_data.in_air then
		return 0
	elseif self._state_data.ducking then
		return 0.0125
	elseif self._running then
		return 0.1
	end
	return 0.025
end

-- Gesture Variety
function PlayerStandard:_start_action_intimidate(t, secondary)
	if not self._intimidate_t or tweak_data.player.movement_state.interaction_delay < t - self._intimidate_t then
		local skip_alert = managers.groupai:state():whisper_mode()
		local voice_type, plural, prime_target = self:_get_unit_intimidation_action(not secondary, not secondary, true, false, true, nil, nil, nil, secondary)

		if prime_target and prime_target.unit and prime_target.unit.base and (prime_target.unit:base().unintimidateable or prime_target.unit:anim_data() and prime_target.unit:anim_data().unintimidateable) then
			return
		end

		local interact_type, sound_name = nil
		local sound_suffix = plural and "plu" or "sin"

		if voice_type == "stop" then
			interact_type = "cmd_stop"
			sound_name = self._shout_down_t and t < self._shout_down_t + 2 and self._last_shout_down_target == prime_target.unit and "f02b_sin" or "f02x_" .. sound_suffix
			self._shout_down_t = t
			self._last_shout_down_target = prime_target.unit
		elseif voice_type == "stop_cop" then
			interact_type = "cmd_stop"
			sound_name = "l01x_" .. sound_suffix
		elseif voice_type == "mark_cop" or voice_type == "mark_cop_quiet" then
			interact_type = "cmd_point"

			if voice_type == "mark_cop_quiet" then
				sound_name = tweak_data.character[prime_target.unit:base()._tweak_table].silent_priority_shout .. "_any"
			else
				sound_name = tweak_data.character[prime_target.unit:base()._tweak_table].priority_shout .. "x_any"
				sound_name = managers.modifiers:modify_value("PlayerStandart:_start_action_intimidate", sound_name, prime_target.unit)
			end

			if self._highlight_special_mul then
				local contour_ext = prime_target.unit:contour()

				if contour_ext then
					contour_ext:add(managers.player:get_contour_for_marked_enemy(), true, self._highlight_special_mul)
				end
			end
		elseif voice_type == "down" then
			interact_type = "cmd_point"
			sound_name = self._shout_down_t and t < self._shout_down_t + 2 and self._last_shout_down_target == prime_target.unit and "f02b_sin" or "f02x_" .. sound_suffix
			self._shout_down_t = t
			self._last_shout_down_target = prime_target.unit
		elseif voice_type == "down_cop" then
			interact_type = "cmd_down"
			sound_name = "l02x_" .. sound_suffix
		elseif voice_type == "cuff_cop" then
			interact_type = "cmd_point"
			sound_name = "l03x_" .. sound_suffix
		elseif voice_type == "down_stay" then
			interact_type = "cmd_down"

			if self._shout_down_t and t < self._shout_down_t + 2 then
				sound_name = "f03b_any"
				interact_type = "cmd_point"
			else
				sound_name = "f03a_" .. sound_suffix
			end
		elseif voice_type == "come" then
			interact_type = "cmd_come"
			local static_data = managers.criminals:character_static_data_by_unit(prime_target.unit)

			if static_data then
				local character_code = static_data.ssuffix
				sound_name = "f21" .. character_code .. "_sin"
			else
				sound_name = "f38_any"
			end
		elseif voice_type == "revive" then
			interact_type = "cmd_get_up"
			local static_data = managers.criminals:character_static_data_by_unit(prime_target.unit)

			if not static_data then
				return
			end

			local character_code = static_data.ssuffix
			sound_name = "f36x_any"

			if math.random() < self._ext_movement:rally_skill_data().revive_chance then
				prime_target.unit:interaction():interact(self._unit)
			end

			self._ext_movement:rally_skill_data().morale_boost_delay_t = managers.player:player_timer():time() + (self._ext_movement:rally_skill_data().morale_boost_cooldown_t or 3.5)
		elseif voice_type == "boost" then
			interact_type = "cmd_gogo"
			local static_data = managers.criminals:character_static_data_by_unit(prime_target.unit)

			if not static_data then
				return
			end

			local character_code = static_data.ssuffix
			sound_name = "g18"
			self._ext_movement:rally_skill_data().morale_boost_delay_t = managers.player:player_timer():time() + (self._ext_movement:rally_skill_data().morale_boost_cooldown_t or 3.5)
		elseif voice_type == "escort" then
			interact_type = "cmd_point"
			sound_name = "f41_" .. sound_suffix
		elseif voice_type == "escort_keep" or voice_type == "escort_go" then
			interact_type = "cmd_point"
			sound_name = "f40_any"
		elseif voice_type == "bridge_codeword" then
			sound_name = "bri_14"
			interact_type = "cmd_point"
		elseif voice_type == "bridge_chair" then
			sound_name = "bri_29"
			interact_type = "cmd_point"
		elseif voice_type == "undercover_interrogate" then
			sound_name = "f46x_any"
			interact_type = "cmd_point"
		elseif voice_type == "undercover_escort" then
			sound_name = "f41_any"
			interact_type = "cmd_point"
		elseif voice_type == "mark_camera" then
			sound_name = "f39_any"
			interact_type = "cmd_point"

			prime_target.unit:contour():add("mark_unit", true, self._highlight_special_mul)
		elseif voice_type == "mark_turret" then
			sound_name = "f44x_any"
			interact_type = "cmd_point"
			local contour_ext = prime_target.unit:contour()

			if contour_ext then
				local type = prime_target.unit:base().get_type and prime_target.unit:base():get_type()

				prime_target.unit:contour():add(managers.player:get_contour_for_marked_enemy(type), true, self._highlight_special_mul)
			end
		elseif voice_type == "ai_stay" then
			sound_name = "f48x_any"
			interact_type = "cmd_stop"
		end

		self:_do_action_intimidate(t, interact_type, sound_name, skip_alert)
	end
end


--==Реплики издают шум==--
function PlayerStandard:say_line(sound_name, skip_alert)
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	self._unit:sound():say(sound_name, true, false)
	skip_alert = skip_alert or managers.groupai:state():whisper_mode()
	local alert_rad = tweak_data.whisper_alert_radius
	local new_alert = {
		"vo_cbt",
		self._unit:movement():m_head_pos(),
		alert_rad,
		self._unit:movement():SO_access(),
		self._unit
	}
	if difficulty == "easy_wish" or difficulty == "sm_wish" then
		managers.groupai:state():propagate_alert(new_alert)
	end
end

--remove screen shake when dealing melee damage
function PlayerStandard:_do_melee_damage(t, bayonet_melee, melee_hit_ray, melee_entry, hand_id)
	melee_entry = melee_entry or managers.blackmarket:equipped_melee_weapon()
	local instant_hit = tweak_data.blackmarket.melee_weapons[melee_entry].instant
	local melee_damage_delay = tweak_data.blackmarket.melee_weapons[melee_entry].melee_damage_delay or 0
	local charge_lerp_value = instant_hit and 0 or self:_get_melee_charge_lerp_value(t, melee_damage_delay)

	local sphere_cast_radius = 20
	local col_ray = nil

	if melee_hit_ray then
		col_ray = melee_hit_ray ~= true and melee_hit_ray or nil
	else
		col_ray = self:_calc_melee_hit_ray(t, sphere_cast_radius)
	end

	if col_ray and alive(col_ray.unit) then
		local damage, damage_effect = managers.blackmarket:equipped_melee_weapon_damage_info(charge_lerp_value)
		local damage_effect_mul = math.max(managers.player:upgrade_value("player", "melee_knockdown_mul", 1), managers.player:upgrade_value(self._equipped_unit:base():weapon_tweak_data().categories and self._equipped_unit:base():weapon_tweak_data().categories[1], "melee_knockdown_mul", 1))
		damage = damage * managers.player:get_melee_dmg_multiplier()
		damage_effect = damage_effect * damage_effect_mul
		col_ray.sphere_cast_radius = sphere_cast_radius
		local hit_unit = col_ray.unit

		if hit_unit:character_damage() then
			if bayonet_melee then
				self._unit:sound():play("fairbairn_hit_body", nil, false)
			else
				local hit_sfx = "hit_body"

				if hit_unit:character_damage() and hit_unit:character_damage().melee_hit_sfx then
					hit_sfx = hit_unit:character_damage():melee_hit_sfx()
				end

				self:_play_melee_sound(melee_entry, hit_sfx, self._melee_attack_var)
			end

			if not hit_unit:character_damage()._no_blood then
				managers.game_play_central:play_impact_flesh({
					col_ray = col_ray
				})
				managers.game_play_central:play_impact_sound_and_effects({
					no_decal = true,
					no_sound = true,
					col_ray = col_ray
				})
			end

			self._camera_unit:base():play_anim_melee_item("hit_body")
		else
			if self._on_melee_restart_drill and hit_unit:base() and (hit_unit:base().is_drill or hit_unit:base().is_saw) then
				hit_unit:base():on_melee_hit(managers.network:session():local_peer():id())
			end

			if bayonet_melee then
				self._unit:sound():play("knife_hit_gen", nil, false)
			else
				self:_play_melee_sound(melee_entry, "hit_gen", self._melee_attack_var)
			end

			self._camera_unit:base():play_anim_melee_item("hit_gen")
			managers.game_play_central:play_impact_sound_and_effects({
				no_decal = true,
				no_sound = true,
				col_ray = col_ray,
				effect = Idstring("effects/payday2/particles/impacts/fallback_impact_pd2")
			})
		end

		local custom_data = nil

		if _G.IS_VR and hand_id then
			custom_data = {
				engine = hand_id == 1 and "right" or "left"
			}
		end

		managers.rumble:play("melee_hit", nil, nil, custom_data)
		managers.game_play_central:physics_push(col_ray)

		local character_unit, shield_knock = nil
		local can_shield_knock = managers.player:has_category_upgrade("player", "shield_knock")

		if can_shield_knock and hit_unit:in_slot(8) and alive(hit_unit:parent()) and not hit_unit:parent():character_damage():is_immune_to_shield_knockback() then
			shield_knock = true
			character_unit = hit_unit:parent()
		end

		character_unit = character_unit or hit_unit

		if character_unit:character_damage() and character_unit:character_damage().damage_melee then
			local dmg_multiplier = 1

			if not managers.enemy:is_civilian(character_unit) and not managers.groupai:state():is_enemy_special(character_unit) then
				dmg_multiplier = dmg_multiplier * managers.player:upgrade_value("player", "non_special_melee_multiplier", 1)
			else
				dmg_multiplier = dmg_multiplier * managers.player:upgrade_value("player", "melee_damage_multiplier", 1)
			end

			dmg_multiplier = dmg_multiplier * managers.player:upgrade_value("player", "melee_" .. tostring(tweak_data.blackmarket.melee_weapons[melee_entry].stats.weapon_type) .. "_damage_multiplier", 1)

			if character_unit:base() and character_unit:base().char_tweak and character_unit:base():char_tweak().priority_shout then
				dmg_multiplier = dmg_multiplier * (tweak_data.blackmarket.melee_weapons[melee_entry].stats.special_damage_multiplier or 1)
			end

			if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
				self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
				self._state_data.stacking_dmg_mul.melee = self._state_data.stacking_dmg_mul.melee or {
					nil,
					0
				}
				local stack = self._state_data.stacking_dmg_mul.melee

				if stack[1] and t < stack[1] then
					dmg_multiplier = dmg_multiplier * (1 + managers.player:upgrade_value("melee", "stacking_hit_damage_multiplier", 0) * stack[2])
				else
					stack[2] = 0
				end
			end

			local health_ratio = self._ext_damage:health_ratio()
			local damage_health_ratio = managers.player:get_damage_health_ratio(health_ratio, "melee")

			if damage_health_ratio > 0 then
				dmg_multiplier = dmg_multiplier * (1 + self._damage_health_ratio_mul_melee * damage_health_ratio)
			end

			dmg_multiplier = dmg_multiplier * managers.player:temporary_upgrade_value("temporary", "berserker_damage_multiplier", 1)
			local target_dead = character_unit:character_damage().dead and not character_unit:character_damage():dead()
			local target_hostile = managers.enemy:is_enemy(character_unit) and not tweak_data.character[character_unit:base()._tweak_table].is_escort and character_unit:brain():is_hostile()
			local life_leach_available = managers.player:has_category_upgrade("temporary", "melee_life_leech") and not managers.player:has_activate_temporary_upgrade("temporary", "melee_life_leech")

			if target_dead and target_hostile and life_leach_available then
				managers.player:activate_temporary_upgrade("temporary", "melee_life_leech")
				self._unit:character_damage():restore_health(managers.player:temporary_upgrade_value("temporary", "melee_life_leech", 1))
			end

			local action_data = {
				variant = "melee"
			}

			if _G.IS_VR and melee_entry == "weapon" and not bayonet_melee then
				dmg_multiplier = 0.1
			end

			action_data.damage = shield_knock and 0 or damage * dmg_multiplier
			action_data.damage_effect = damage_effect
			action_data.attacker_unit = self._unit
			action_data.col_ray = col_ray

			if shield_knock then
				action_data.shield_knock = can_shield_knock
			end

			action_data.name_id = melee_entry
			action_data.charge_lerp_value = charge_lerp_value

			if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
				self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
				self._state_data.stacking_dmg_mul.melee = self._state_data.stacking_dmg_mul.melee or {
					nil,
					0
				}
				local stack = self._state_data.stacking_dmg_mul.melee

				if character_unit:character_damage().dead and not character_unit:character_damage():dead() then
					stack[1] = t + managers.player:upgrade_value("melee", "stacking_hit_expire_t", 1)
					stack[2] = math.min(stack[2] + 1, tweak_data.upgrades.max_melee_weapon_dmg_mul_stacks or 5)
				else
					stack[1] = nil
					stack[2] = 0
				end
			end

			local defense_data = character_unit:character_damage():damage_melee(action_data)

			self:_check_melee_special_damage(col_ray, character_unit, defense_data, melee_entry)
			self:_perform_sync_melee_damage(hit_unit, col_ray, action_data.damage)

			return defense_data
		else
			self:_perform_sync_melee_damage(hit_unit, col_ray, damage)
		end
	end

	if managers.player:has_category_upgrade("melee", "stacking_hit_damage_multiplier") then
		self._state_data.stacking_dmg_mul = self._state_data.stacking_dmg_mul or {}
		self._state_data.stacking_dmg_mul.melee = self._state_data.stacking_dmg_mul.melee or {
			nil,
			0
		}
		local stack = self._state_data.stacking_dmg_mul.melee
		stack[1] = nil
		stack[2] = 0
	end

	return col_ray
end


--==Бег в определенном радиусе будет тревожить гражданских/охранников.==--
Hooks:PreHook(PlayerStandard, "_update_movement", "PlayerStandard_update_movement", function(self, t)
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	local cur_pos = pos_new or self._pos
	local move_dis = mvector3.distance_sq(cur_pos, self._last_sent_pos)
	if not self:_on_zipline() and (move_dis > 22500 or move_dis > 400 and (t - self._last_sent_pos_t > 1.5 or not pos_new)) then
		self._ext_network:send("action_walk_nav_point", cur_pos)
		mvector3.set(self._last_sent_pos, cur_pos)
		self._last_sent_pos_t = t
		if self._move_dir and self._running and not self._state_data.ducking and not managers.groupai:state():enemy_weapons_hot() then
			local alert_epicenter = mvector3.copy(self._last_sent_pos)
			mvector3.set_z(alert_epicenter, alert_epicenter.z + 150)
			local alert_rad = (tweak_data.footstep_alert_radius) * mvector3.length(self._move_dir)
			local footstep_alert = {
				"footstep",
				alert_epicenter,
				alert_rad,
				managers.groupai:state():get_unit_type_filter("civilians_enemies"),
				self._unit
			}
			if difficulty_index > 3 then
				managers.groupai:state():propagate_alert(footstep_alert)
			end
		end
	end
end)

local function set_hos(self)
    self._ext_network:send("set_stance", 2, false, false)
end

local function set_cbt(self)
    self._ext_network:send("set_stance", 3, false, false)
end

Hooks:PostHook(PlayerStandard, "_enter", "_enter_hos", set_hos)
Hooks:PostHook(PlayerStandard, "_end_action_steelsight", "_end_action_steelsight_hos", set_hos)
Hooks:PostHook(PlayerStandard, "set_running", "set_running_hos", set_hos)


--this code is 'supposedly' better at restoring the old ADS animations than my old code