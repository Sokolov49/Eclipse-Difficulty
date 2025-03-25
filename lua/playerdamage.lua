-- uppers cooldown
PlayerDamage._UPPERS_COOLDOWN = 120

-- Pro-Job adds bleedout time and revive health scaling (as well as friendly fire)
Hooks:PreHook(PlayerDamage, "replenish", "eclipse_replenish", function(self)
	if Global.game_settings and Global.game_settings.one_down then
		self._lives_init = 4
		tweak_data.player.damage.DOWNED_TIME = 25
		tweak_data.player.damage.DOWNED_TIME_DEC = 10
		tweak_data.player.damage.DOWNED_TIME_MIN = 1
		tweak_data.player.damage.REVIVE_HEALTH_STEPS = { 0.4, 0.2, 0.1 }
	end
end)

-- Remove suppression
function PlayerDamage:_upd_suppression(t, dt) end

-- Aimpunch stuffs
Hooks:PreHook( PlayerDamage, "damage_bullet", "ssa_damage_bullet", function(self, attack_data)
	if not attack_data or not attack_data.damage then
		return
	end

	local has_tough_guy = managers.player:has_category_upgrade("player", "damage_shake_multiplier")
	local shake_armor_multiplier = managers.player:body_armor_value("damage_shake") * (self:get_real_armor() > 0 and 1 or 2)
	
	if has_tough_guy then
		self._unit:camera()._damage_bullet_shake_multiplier = ( math.clamp(attack_data.damage, 0, 10) * shake_armor_multiplier ) * managers.player:upgrade_value( "player", "damage_shake_multiplier", 1 )
	else
		self._unit:camera()._damage_bullet_shake_multiplier = ( math.clamp(attack_data.damage, 0, 10) * shake_armor_multiplier )
	end
	
end)

-- Friendly Fire
function PlayerDamage:is_friendly_fire(unit)
	local attacker_mov_ext = alive(unit) and unit:movement()

	if not attacker_mov_ext or not attacker_mov_ext.team or not attacker_mov_ext.friendly_fire then
		return false
	end

	local my_team = self._unit:movement():team()
	local attacker_team = attacker_mov_ext:team()

	if attacker_team ~= my_team and attacker_mov_ext:friendly_fire() then
		return false
	end
	local pro_job_enabled = Global.game_settings and Global.game_settings.one_down
	local attacked_by_foe = attacker_team and my_team and my_team.foes[attacker_team.id]
	local friendly_fire_mutator_active = managers.mutators:modify_value("PlayerDamage:FriendlyFire", friendly_fire_mutator_active) == false
	if not attacked_by_foe then
		if pro_job_enabled or friendly_fire_mutator_active then
			return false
		end
		return true
	end
	return false
end

-- Armor Breaking GP / Panic
function PlayerDamage:_calc_armor_damage(attack_data)
	local health_subtracted = 0

	if self:get_real_armor() > 0 then
		health_subtracted = self:get_real_armor()

		self:change_armor(-attack_data.damage)

		health_subtracted = health_subtracted - self:get_real_armor()

		self:_damage_screen()
		SoundDevice:set_rtpc("shield_status", self:armor_ratio() * 100)
		self:_send_set_armor()

		local has_armor_panic = managers.player:has_enabled_cooldown_upgrade("cooldown", "panic_on_armor_break")

		if self:get_real_armor() <= 0 then
			-- Armor breaking causes enemies to panic
			if has_armor_panic then
				local pos = managers.player:player_unit():position()
				local skill = tweak_data.upgrades.values.player.armor_panic[1]

				if skill then
					local area = skill.area
					local chance = skill.chance
					local amount = skill.amount
					local enemies = World:find_units_quick("sphere", pos, area, managers.slot:get_mask("enemies"))

					for i, unit in ipairs(enemies) do
						if unit:character_damage() then
							unit:character_damage():build_suppression(amount, chance)
						end
					end
				end

				managers.player:disable_cooldown_upgrade("cooldown", "panic_on_armor_break")
			end

			self._unit:sound():play("player_armor_gone_stinger")

			if attack_data.armor_piercing then
				self._unit:sound():play("player_sniper_hit_armor_gone")
			end

			-- Add significantly longer grace period on armor break (repurposing Anarchist/Armorer damage timer) (sh)
			self._can_take_dmg_timer = math.max(self._dmg_interval, 0.3)

			local pm = managers.player

			self:_start_regen_on_the_side(pm:upgrade_value("player", "passive_always_regen_armor", 0))

			if pm:has_inactivate_temporary_upgrade("temporary", "armor_break_invulnerable") then
				pm:activate_temporary_upgrade("temporary", "armor_break_invulnerable")

				self._can_take_dmg_timer = pm:temporary_upgrade_value("temporary", "armor_break_invulnerable", 0)
			end
		end
	end

	managers.hud:damage_taken()

	return health_subtracted
end

-- Grace period protects no matter the new potential damage but is shorter in general (sh)
function PlayerDamage:_chk_dmg_too_soon()
	local next_allowed_dmg_t = type(self._next_allowed_dmg_t) == "number" and self._next_allowed_dmg_t or Application:digest_value(self._next_allowed_dmg_t, false)
	return managers.player:player_timer():time() < next_allowed_dmg_t
end

function PlayerDamage:_calc_health_damage(attack_data)
	-- damage tagging, (IT WAS NOT) worth the experiment i think
	-- if attack_data.weapon_unit and attack_data.damage > 15 then
	-- 	local armor_value_tagged = managers.player:body_armor_value("damage_tagged")
	-- 	local skill_value_tagged = managers.player:upgrade_value("player", "player_tagged_speed_mul", 1)
	-- 	local slowdown_data = {
	-- 		max_mul = math.clamp(0.2 * armor_value_tagged * skill_value_tagged, 0, 1),
	-- 		add_mul = math.clamp(math.min(0.07, 0.0015 * attack_data.damage) / armor_value_tagged * skill_value_tagged, 0, 1),
	-- 		decay_time = math.min(1.5, 0.01 * attack_data.damage),
	-- 		id = "snowthrower_cold",
	-- 		duration = 2,
	-- 		mul = math.clamp(math.min(0.7, 60 / attack_data.damage) * armor_value_tagged / skill_value_tagged, 0, 1),
	-- 		prevents_running = false,
	-- 	}

	-- 	self:apply_slowdown(slowdown_data)
	-- end

	if managers.player:has_activate_temporary_upgrade("temporary", "mrwi_health_invulnerable") then
		return 0
	end

	local health_subtracted = 0
	health_subtracted = self:get_real_health()

	self:change_health(-attack_data.damage)

	health_subtracted = health_subtracted - self:get_real_health()

	if managers.player:has_activate_temporary_upgrade("temporary", "copr_ability") and health_subtracted > 0 then
		local teammate_heal_level = managers.player:upgrade_level_nil("player", "copr_teammate_heal")

		if teammate_heal_level and self:get_real_health() > 0 then
			self._unit:network():send("copr_teammate_heal", teammate_heal_level)
		end
	end

	if self._has_mrwi_health_invulnerable then
		local health_threshold = self._mrwi_health_invulnerable_threshold or 0.5
		local is_cooling_down = managers.player:get_temporary_property("mrwi_health_invulnerable", false)

		-- Make <50%hp invuln upgrade not proc on armor hits
		if self:health_ratio() <= health_threshold and health_subtracted > 0 and not is_cooling_down then -- was it so hard to just add one more check, overkill?
			local cooldown_time = self._mrwi_health_invulnerable_cooldown or 10

			managers.player:activate_temporary_upgrade("temporary", "mrwi_health_invulnerable")
			managers.player:activate_temporary_property("mrwi_health_invulnerable", cooldown_time, true)
		end
	end

	local trigger_skills = table.contains({
		"bullet",
		"explosion",
		"melee",
		"delayed_tick",
	}, attack_data.variant)

	if self:get_real_health() == 0 and trigger_skills then
		self:_chk_cheat_death()
	end

	self:_damage_screen()
	self:_check_bleed_out(trigger_skills)
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false),
	})
	self:_send_set_health()
	self:_set_health_effect()
	managers.statistics:health_subtracted(health_subtracted)

	return health_subtracted
end

function PlayerDamage:on_incapacitated()
	local is_pro = Global.game_settings and Global.game_settings.one_down

	self:on_downed()

	if is_pro then
		self._revives = Application:digest_value(Application:digest_value(self._revives, false) - 1, true) -- instant incaps (cloakers / tasers) count as downs
		self:_send_set_revives()
	end

	self._incapacitated = true
end

-- make healing fixed instead of % of max health
function PlayerDamage:restore_health(health_restored, is_static, chk_health_ratio)
	if chk_health_ratio and managers.player:is_damage_health_ratio_active(self:health_ratio()) then
		return false
	end

	return self:change_health(health_restored * self._healing_reduction)
end

-- lower the on-kill godmode length for leech
function PlayerDamage:on_copr_killshot()
	self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + 0.45, true)
	self._last_received_dmg = self:_max_health()
end

-- add an upgrade that gives increased bleedout timer
Hooks:PostHook(PlayerDamage, "_regenerated", "eclipse__regenerated", function(self)
	self._down_time = tweak_data.player.damage.DOWNED_TIME + managers.player:upgrade_value("player", "increased_bleedout_timer", 0)

	self._down_timer_max = self._down_time -- store the max bleedout timer so that fak down restore can go up to 35
end)

-- bring back decreasing bleedout timer based on the amount of downs
Hooks:PreHook(PlayerDamage, "revive", "eclipse_revive", function(self)
	if not self:arrested() then
		self._down_time = math.max(tweak_data.player.damage.DOWNED_TIME_MIN, self._down_time - tweak_data.player.damage.DOWNED_TIME_DEC)
	end
end)

-- faks only heal a small portion but then heal you over time
function PlayerDamage:band_aid_health(hot_regen)
	if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
		return
	end

	self:restore_health(tweak_data.upgrades.values.first_aid_kit.heal_amount)
	if hot_regen then
		managers.player:activate_temporary_upgrade("temporary", "first_aid_health_regen")
	end

	self._said_hurt = false
end

-- Fix Anarchist regen not triggering HUD armor update for clients
Hooks:PostHook(PlayerDamage, "change_armor", "sh_change_armor", function(self, change)
	if change > 0 and self:armor_ratio() < 1 then
		self:_send_set_armor()
	end
end)

-- armor regen time depends on the armor you're wearing
function PlayerDamage:set_regenerate_timer_to_max()
	local mul = managers.player:body_armor_regen_multiplier(alive(self._unit) and self._unit:movement():current_state()._moving, self:health_ratio())
	self._regenerate_timer = managers.player:body_armor_value("regen_timer") * mul
	self._regenerate_timer = self._regenerate_timer * managers.player:upgrade_value("player", "armor_regen_time_mul", 1)
	self._regenerate_speed = self._regenerate_speed or 1
	self._current_state = self._update_regenerate_timer
end

--danger effective audio feedback
Hooks:PostHook(PlayerDamage, "update", "post_update", function(self, unit, t, dt)
	
	local cur_state = self._unit:movement():current_state_name()	
	local armor_broken = self:_max_armor() > 0 and self:get_real_armor() <= 0
	local armor_regenerated = self:get_real_armor() > 0
	local current_max_health = self:_max_health() / 100
	local current_health = self:get_real_health()
	local low_health = current_max_health * 20 >= current_health
	
	local concuss_chk = not self._concussion_data or not self._concussion_data.intensity or self._concussion_data and self._concussion_data.intensity and self._concussion_data.intensity <= 0
	
	local tinnitus_chk = not self._tinnitus_data or not self._tinnitus_data.intensity or self._tinnitus_data and self._tinnitus_data.intensity and self._tinnitus_data.intensity <= 0
	
	if not self:is_downed() and not self._bleed_out and not self._dead and cur_state ~= "fatal" and cur_state ~= "bleedout" and concuss_chk and tinnitus_chk and not self._downed_progression then
		if armor_broken and self:is_regenerating_armor() then
			if not low_health then
				self._needs_dedampen = 32
			else
				self._needs_dedampen = 50
			end
			SoundDevice:set_rtpc("downed_state_progression", self._needs_dedampen)	
			SoundDevice:set_rtpc("concussion_effect", self._needs_dedampen)			
			--log("damping sound")
		end
	end
	
	if self:_max_armor() > 0 and armor_regenerated then
		self._should_dedampen = true
	else
		self._should_dedampen = nil
	end
	
	if self._should_dedampen then
		self:_begin_smooth_snddedampen()
	end
end)

function PlayerDamage:_begin_smooth_snddedampen()
	local t = TimerManager:game():time()
	local dedamp_t_chk = not self._next_dedampen_t or self._next_dedampen_t and self._next_dedampen_t < t
	if self._needs_dedampen and self._needs_dedampen > 0 and dedamp_t_chk then
		self._needs_dedampen = self._needs_dedampen - 1
		self._next_dedampen_t = t + 0.011
		--log("dedamping sound")
		SoundDevice:set_rtpc("downed_state_progression", self._needs_dedampen)
		SoundDevice:set_rtpc("concussion_effect", self._needs_dedampen)
	else
		--self._is_damping = nil
		self._should_dedampen = nil
	end
end

Hooks:PostHook(PlayerDamage, "_regenerate_armor", "post_regenarmor", function(self, no_sound)
	if self._needs_dedampen then
		--self._is_damping = true
		self:_begin_smooth_snddedampen()
	end
end)

Hooks:PreHook(PlayerDamage,"update","nomoretinnitus",function(self,unit,t,dt)
	if self._concussion_data then
	self._concussion_data.intensity = (self._concussion_data.end_t - t) / self._concussion_data.duration

		if self._concussion_data.intensity <= 0 then
			self:_stop_concussion()
		else
			SoundDevice:set_rtpc("downed_state_progression", self._concussion_data.intensity * 100)
		end
		
	end
	
end)

--no more tinnitus also play shaker when face-blasted
function PlayerDamage:_start_concussion(mul)
--for criminal concussion grenades

	if self._concussion_data then
		self._concussion_data.intensity = mul
		local duration_tweak = tweak_data.projectiles.concussion.duration
		self._concussion_data.duration = duration_tweak.min + mul * math.lerp(duration_tweak.additional - 2, duration_tweak.additional + 2, math.random())
		self._concussion_data.end_t = managers.player:player_timer():time() + self._concussion_data.duration

		SoundDevice:set_rtpc("downed_state_progression", self._concussion_data.intensity * 100)
		--use a nice sound muffle instead of the ringing and echo
		
		self._unit:camera():play_shaker("player_bullet_damage" and self._damage_bullet_shake_multiplier or effect == "player_bullet_damage_knock_out" and self._damage_bullet_shake_multiplier or amplitude)
		--use aimpunch as a reaction instead of original ground shake

--formerly used "concussion_effect" which has those god-awful sfx
	else
		local duration = 4 + mul * math.lerp(8, 12, math.random())
		self._concussion_data = {
			intensity = mul,
			duration = duration,
			end_t = managers.player:player_timer():time() + duration
		}
	end

--	normally plays "concussion_player_disoriented_sfx" for tinnitus ringing
--	normally plays "concussion_effect_on" for sound duplication
end


function PlayerDamage:_start_tinnitus(sound_eff_mul, skip_explosion_sfx)
	--for cop flashbangs
	if self._tinnitus_data then
		if sound_eff_mul < self._tinnitus_data.intensity then
			return
		end

		self._tinnitus_data.intensity = sound_eff_mul
		self._tinnitus_data.duration = 4 + sound_eff_mul * math.lerp(8, 12, math.random())
		self._tinnitus_data.end_t = managers.player:player_timer():time() + self._tinnitus_data.duration

		if self._tinnitus_data.snd_event then
			self._tinnitus_data.snd_event:stop()
		end

		SoundDevice:set_rtpc("downed_state_progression", math.max(self._downed_progression or 0, self._tinnitus_data.intensity * 100))
--normally plays "tinnitus_beep", ain't having none of that

		self._unit:camera():play_shaker("player_bullet_damage" and self._damage_bullet_shake_multiplier or effect == "player_bullet_damage_knock_out" and self._damage_bullet_shake_multiplier or amplitude)
		--use aimpunch as a reaction instead of original ground shake	
	else
		local duration = 4 + sound_eff_mul * math.lerp(8, 12, math.random())

		SoundDevice:set_rtpc("downed_state_progression", math.max(self._downed_progression or 0, sound_eff_mul * 100))

		self._tinnitus_data = {
			intensity = sound_eff_mul,
			duration = duration,
			end_t = managers.player:player_timer():time() + duration
--normally plays "tinnitus_beep"
		}
	end

	if not skip_explosion_sfx then
		self._unit:sound():play("flashbang_explode_sfx_player")
	end
end

function PlayerDamage:update_downed(t, dt)
	if self._downed_timer and self._downed_paused_counter == 0 then
		self._downed_timer = self._downed_timer - dt
		if self._downed_start_time == 0 then
			self._downed_progression = 100
		else
			self._downed_progression = math.clamp(1 - self._downed_timer / self._downed_start_time, 0, 1) * 100
		end
		managers.environment_controller:set_downed_value(self._downed_progression + 37) -- self._downed_progression + 50 should be ok
		SoundDevice:set_rtpc("downed_state_progression", self._downed_progression + 37)
		return self._downed_timer <= 0
	end
	return false
end

Hooks:PostHook(PlayerDamage, "_upd_health_regen", "marcusization", function(self, t, dt)
	if self._has_good_luck_charm == nil then
		self._has_good_luck_charm = managers.skilltree:skill_completed("hellotothemarcusreadingthis")
	end
	
	if self._has_good_luck_charm then
		local max_health = self:_max_health()
		if self:get_real_health() < max_health then
			local chance = math.random(1000)
			if chance == 666 or chance == 777 then
				local regen_rate = 0.01
				local health_to_add = max_health * regen_rate
				self:change_health(health_to_add)
			end
		end
	end
end)

function PlayerDamage:play_whizby(position)
	self._unit:sound():play_whizby({
		position = position
	})
	
	if has_tough_guy then
		self._unit:camera():play_shaker("whizby", 0.1)
	else
		self._unit:camera():play_shaker("whizby", 0.225) --357
	end

	if not _G.IS_VR then
		managers.rumble:play("bullet_whizby")
	end
end

--Tear gas damage slowly scales when the player is exposed to it
local damage_killzone_original = PlayerDamage.damage_killzone
function PlayerDamage:damage_killzone(attack_data, ...)
	if attack_data.variant ~= "teargas" then
		return damage_killzone_original(self, attack_data, ...)
	end

	local damage_info = {
		result = {
			variant = "killzone",
			type = "hurt",
		},
	}

	if self._god_mode or self._invulnerable or self._mission_damage_blockers.invulnerable then
		self:_call_listeners(damage_info)
		return
	elseif self:incapacitated() or self._unit:movement():current_state().immortal then
		self._last_teargas_hit_t = nil
		return
	end

	local t = managers.player:player_timer():time()
	if not self._last_teargas_hit_t or self._last_teargas_hit_t + 5 < t then
		self._teargas_damage_ramp = -0.1
	else
		self._teargas_damage_ramp = math.min(self._teargas_damage_ramp + 0.1, 1)
	end

	self._last_teargas_hit_t = t

	self._unit:sound():play("player_hit")

	self:_hit_direction(attack_data.col_ray.origin, attack_data.col_ray.ray)

	if self._bleed_out then
		return
	end

	attack_data.damage = managers.player:modify_value("damage_taken", attack_data.damage, attack_data) * self._teargas_damage_ramp

	self._unit:movement():subtract_stamina(10 * self._teargas_damage_ramp)

	self:mutator_update_attack_data(attack_data)
	self:_check_chico_heal(attack_data)

	self:_calc_health_damage(attack_data)

	self:_call_listeners(damage_info)
end