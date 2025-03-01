local math_min = math.min
local mvec3_set = mvector3.set
local mvec3_set_z = mvector3.set_z
local mvec3_sub = mvector3.subtract
local mvec3_dot = mvector3.dot
local mvec3_norm = mvector3.normalize
local temp_vec1 = Vector3()
local temp_vec2 = Vector3()

function TeamAILogicAssault._upd_enemy_detection(data, is_synchronous)
	managers.groupai:state():on_unit_detection_updated(data.unit)

	data.t = TimerManager:game():time()
	local my_data = data.internal_data
	local max_reaction = nil

	if data.cool then
		max_reaction = AIAttentionObject.REACT_SURPRISED
	end

	local delay = CopLogicBase._upd_attention_obj_detection(data, nil, max_reaction)
	local new_attention, new_prio_slot, new_reaction = TeamAILogicIdle._get_priority_attention(data, data.detected_attention_objects, nil)
	local old_att_obj = data.attention_obj

	TeamAILogicBase._set_attention_obj(data, new_attention, new_reaction)
	TeamAILogicAssault._chk_exit_attack_logic(data, new_reaction)

	if my_data ~= data.internal_data then
		return
	end

	if data.objective and data.objective.type == "follow" and TeamAILogicIdle._check_should_relocate(data, my_data, data.objective) and not data.unit:movement():chk_action_forbidden("walk") then
		data.objective.in_place = nil

		if new_prio_slot and new_prio_slot > 5 then
			data.objective.called = true
		end

		TeamAILogicBase._exit(data.unit, "travel")

		return
	end

	CopLogicAttack._upd_aim(data, my_data)

	if not data.unit:brain()._intimidate_t or data.unit:brain()._intimidate_t + 2 < data.t then
		if not my_data._turning_to_intimidate and data.unit:character_damage():health_ratio() > 0.5 then
			local can_turn = nil

			if not new_prio_slot or new_prio_slot > 5 then
				if not data.unit:movement():chk_action_forbidden("turn") then
					can_turn = true
				end
			end

			local is_assault = managers.groupai:state():get_assault_mode()
			local shout_angle = can_turn and 180 or 60
			local shout_distance = is_assault and 800 or 1200
			local civ = TeamAILogicIdle.find_civilian_to_intimidate(data.unit, shout_angle, shout_distance)

			if civ then
				data.unit:brain()._intimidate_t = data.t

				if can_turn and CopLogicAttack._chk_request_action_turn_to_enemy(data, my_data, data.unit:movement():m_pos(), civ:movement():m_pos()) then
					my_data._turning_to_intimidate = true
					my_data._primary_intimidation_target = civ
				else
					TeamAILogicIdle.intimidate_civilians(data, data.unit, true, false)
				end
			end
		end
	end

	if not my_data.acting then
		if not TeamAILogicAssault._mark_special_chk_t or TeamAILogicAssault._mark_special_chk_t + 0.75 < data.t then
			if not TeamAILogicAssault._mark_special_t or TeamAILogicAssault._mark_special_t + 3 < data.t then
				if not data.unit:sound():speaking() then
					TeamAILogicAssault._mark_special_chk_t = data.t

					local nmy = TeamAILogicAssault.find_enemy_to_mark(data.detected_attention_objects)

					if nmy then
						TeamAILogicAssault._mark_special_t = data.t
						TeamAILogicAssault.mark_enemy(data, data.unit, nmy, true, true)
					end
				end
			end
		end
	end

	TeamAILogicAssault._chk_request_combat_chatter(data, my_data)

	if not is_synchronous then
		CopLogicBase.queue_task(my_data, my_data.detection_task_key, TeamAILogicAssault._upd_enemy_detection, data, data.t + delay)
	end
end

function TeamAILogicAssault.find_enemy_to_mark(attention_objects)
	local best_nmy, best_nmy_wgt = nil

	for key, attention_info in pairs(attention_objects) do
		if attention_info.identified then
			if attention_info.verified or attention_info.nearly_visible then
				if attention_info.reaction and AIAttentionObject.REACT_COMBAT <= attention_info.reaction and attention_info.unit:contour() then
					if attention_info.is_deployable or attention_info.is_person and attention_info.char_tweak and attention_info.char_tweak.priority_shout then
						local in_range = nil

						if attention_info.is_deployable then
							local turret_tweak = attention_info.unit:brain() and attention_info.unit:brain()._tweak_data

							if turret_tweak then
								local actual_range = math_min(turret_tweak.FIRE_RANGE, turret_tweak.DETECTION_RANGE)

								if attention_info.verified_dis < actual_range then
									in_range = true
								end
							end
						elseif not attention_info.char_tweak.priority_shout_max_dis or attention_info.verified_dis < attention_info.char_tweak.priority_shout_max_dis then
							in_range = true
						end

						if in_range then
							local att_contour = attention_info.unit:contour()
							local mark = false

							if not att_contour._contour_list then
								mark = true
							else
								if attention_info.is_deployable then
									if not att_contour:has_id("mark_unit_dangerous") and not att_contour:has_id("mark_unit_dangerous_damage_bonus") and not att_contour:has_id("mark_unit_dangerous_damage_bonus_distance") then
										mark = true
									end
								else
									if not att_contour:has_id("mark_enemy") and not att_contour:has_id("mark_enemy_damage_bonus") and not att_contour:has_id("mark_enemy_damage_bonus_distance") then
										mark = true
									end
								end
							end

							if mark then
								if not best_nmy_wgt or attention_info.verified_dis < best_nmy_wgt then
									best_nmy_wgt = attention_info.verified_dis
									best_nmy = attention_info.unit
								end
							end
						end
					end
				end
			end
		end
	end

	return best_nmy
end

function TeamAILogicAssault.mark_enemy(data, criminal, to_mark, play_sound, play_action)
	if play_sound then
		if to_mark:base().sentry_gun then
			criminal:sound():say("f44x_any", true)
		elseif to_mark:base():char_tweak().bot_priority_shout then
			criminal:sound():say(to_mark:base():char_tweak().bot_priority_shout, true)
		elseif to_mark:base():char_tweak().priority_shout then
			criminal:sound():say(to_mark:base():char_tweak().priority_shout .. "x_any", true)
		end
	end

	if play_action then
		local can_play_action = not criminal:movement():chk_action_forbidden("action") and not criminal:anim_data().reload and not data.internal_data.firing and not data.internal_data.shooting

		if can_play_action then
			local new_action = {
				type = "act",
				variant = "arrest",
				body_part = 3,
				align_sync = true
			}

			if criminal:brain():action_request(new_action) then
				data.internal_data.gesture_arrest = true
			end
		end
	end

	if to_mark:base().sentry_gun then
		to_mark:contour():add("mark_unit_dangerous", true)
	else
		to_mark:contour():add("mark_enemy", true)
	end

	local skip_alert = managers.groupai:state():whisper_mode()

	if not skip_alert then
		local alert_rad = 500
		local alert = {
			"vo_cbt",
			criminal:movement():m_head_pos(),
			alert_rad,
			data.SO_access,
			criminal
		}

		managers.groupai:state():propagate_alert(alert)
	end
end

function TeamAILogicAssault._chk_request_combat_chatter(data, my_data)
	if not data.unit:sound():speaking() then
		if my_data.firing or my_data.shooting then
			local focus_enemy = data.attention_obj

			if focus_enemy and focus_enemy.identified and focus_enemy.verified and focus_enemy.is_person and focus_enemy.reaction and AIAttentionObject.REACT_COMBAT <= focus_enemy.reaction then
				managers.groupai:state():chk_say_teamAI_combat_chatter(data.unit)
			end
		end
	end
end

--the functions below are from coplogicattack, since the bots use that
function TeamAILogicAssault._upd_combat_movement( data )
	local my_data = data.internal_data
	local t = data.t
	local unit = data.unit
	local focus_enemy = data.attention_obj
	local in_cover = my_data.in_cover
	local best_cover = my_data.best_cover
	
	local enemy_visible = focus_enemy.verified
	local enemy_visible_soft = focus_enemy.verified_t and t - focus_enemy.verified_t < 2
	local enemy_visible_softer = focus_enemy.verified_t and t - focus_enemy.verified_t < 15
	
	local alert_soft = data.is_suppressed
	
	local action_taken = data.logic.action_taken( data, my_data )
	local want_to_take_cover = my_data.want_to_take_cover
	-- Check if we should crouch or stand
	
	if not action_taken then
		if want_to_take_cover and ( not in_cover or not in_cover[4] ) or ( not data.char_tweak.allowed_poses or data.char_tweak.allowed_poses.stand ) then  -- I do not have cover or my cover is low and I am not crouched
			if not unit:anim_data().crouch then
				action_taken = CopLogicAttack._chk_request_action_crouch( data )
			end
		elseif unit:anim_data().crouch then
			if data.char_tweak.allowed_poses and not data.char_tweak.allowed_poses.crouch or my_data.cover_test_step > 2 then
				action_taken = CopLogicAttack._chk_request_action_stand( data )
			end
		end
	end
	
	local move_to_cover, want_flank_cover	-- "want_flank_cover" means we want to look for a cover that flanks the focus_enemy instead of one closest to us. It's used by _update_cover()
	
	if my_data.cover_test_step ~= 1 and not enemy_visible_softer and ( action_taken or want_to_take_cover or not in_cover ) then
		my_data.cover_test_step = 1 -- reset the "_peek_for_pos_sideways" check
	end
	
	if my_data.stay_out_time and ( enemy_visible_soft or not my_data.at_cover_shoot_pos or action_taken or want_to_take_cover ) then
		my_data.stay_out_time = nil -- reset how long we may wait for the enemy to appear on its own
	elseif my_data.attitude == "engage" and not my_data.stay_out_time and not enemy_visible_soft and my_data.at_cover_shoot_pos and not ( action_taken or want_to_take_cover ) then
		my_data.stay_out_time = t + 7
	end
	
	-- check if we should move somewhere
	if action_taken then
	elseif want_to_take_cover then -- we don't want trouble
		move_to_cover = true
	elseif not enemy_visible_soft then -- we want trouble and haven't seen our enemy recently
		if data.tactics and data.tactics.charge and data.objective and data.objective.grp_objective and data.objective.grp_objective.charge and ( not my_data.charge_path_failed_t or data.t - my_data.charge_path_failed_t > 6 ) then
			if my_data.charge_path then
				local path = my_data.charge_path
				my_data.charge_path = nil
				action_taken = CopLogicAttack._chk_request_action_walk_to_cover_shoot_pos( data, my_data, path )
			elseif not my_data.charge_path_search_id and data.attention_obj.nav_tracker then
				my_data.charge_pos = CopLogicTravel._get_pos_on_wall( data.attention_obj.nav_tracker:field_position(), my_data.weapon_range.optimal, 45, nil )
				if my_data.charge_pos then
					my_data.charge_path_search_id = "charge"..tostring(data.key)
					unit:brain():search_for_path( my_data.charge_path_search_id, my_data.charge_pos, nil, nil, nil )
					--debug_pause_unit( data.unit, "decided to charge", data.unit )
				else
					debug_pause_unit( data.unit, "failed to find charge_pos", data.unit )
					my_data.charge_path_failed_t = TimerManager:game():time()
				end
			end
		elseif in_cover then
			if my_data.cover_test_step <= 2 then -- peek sideways for a line of fire
				local height
				if in_cover[4] then
					height = 150
				else
					height = 80
				end
				
				local my_tracker = unit:movement():nav_tracker()
				local shoot_from_pos = CopLogicAttack._peek_for_pos_sideways( data, my_data, my_tracker, focus_enemy.m_head_pos, height )
				
				if shoot_from_pos then
					local path = { my_tracker:position(), shoot_from_pos }
					action_taken = CopLogicAttack._chk_request_action_walk_to_cover_shoot_pos( data, my_data, path, math.random() < 0.5 and "run" or "walk" )
				else
					my_data.cover_test_step = my_data.cover_test_step + 1
				end
			elseif not enemy_visible_softer then -- we are in cover and haven't found a suitable peek position in a long time. find new cover
				if math.random() < 0.05 then
					move_to_cover = true
					want_flank_cover = true -- turn on the flanking algorithm
				end
			end
		else -- not in_cover
			if my_data.walking_to_cover_shoot_pos then -- Moving out of cover to fire
			elseif my_data.at_cover_shoot_pos then -- we stand beside our cover in hope of getting a line of fire
				if my_data.stay_out_time < t then -- wait a few seconds in case the enemy pops up
					move_to_cover = true
				end
			else
				move_to_cover = true
			end
		end
	end
	
	if not ( my_data.processing_cover_path or my_data.cover_path or my_data.charge_path_search_id or action_taken )
	and best_cover
	and ( not in_cover or best_cover[1] ~= in_cover[1] ) 
	and ( not my_data.cover_path_failed_t or data.t - my_data.cover_path_failed_t > 5 ) then
		CopLogicAttack._cancel_cover_pathing( data, my_data )
		local search_id = tostring( unit:key() ).."cover"
		if data.unit:brain():search_for_path_to_cover( search_id, best_cover[1], best_cover[5] ) then
			my_data.cover_path_search_id = search_id
			my_data.processing_cover_path = best_cover
		end
	end
	
	if not action_taken and move_to_cover and my_data.cover_path then
		action_taken = CopLogicAttack._chk_request_action_walk_to_cover( data, my_data )
	end
	
	
	if want_flank_cover then
		if not my_data.flank_cover then
			local sign = math.random() < 0.5 and -1 or 1
			local step = 30
			my_data.flank_cover = { step = step, angle = step * sign, sign = sign }
		end
	else
		my_data.flank_cover = nil
	end
	
	-- my_data.flank_cover = nil
	
	if not ( my_data.turning or data.unit:movement():chk_action_forbidden( "walk" ) ) and CopLogicAttack._can_move( data ) then
		
		if data.attention_obj.verified and not ( in_cover and in_cover[4] ) then
			if data.is_suppressed and data.t - data.unit:character_damage():last_suppression_t() < 0.7 then -- suppressed and recently received fire
				--print( "suppressed" )
				action_taken = CopLogicBase.chk_start_action_dodge( data, "scared" )
			end
			
			if not action_taken and focus_enemy.is_person and focus_enemy.dis < 2000 and ( ( data.group and data.group.size > 1 ) or math.random() < 0.5 ) then
				--print( "is_person" )
				local dodge
				if focus_enemy.is_local_player then
					local e_movement_state = focus_enemy.unit:movement():current_state()
					if not ( e_movement_state:_is_reloading() or e_movement_state:_interacting() or e_movement_state:is_equipping() ) then
						--print( "not threatened1" )
						dodge = true
					end
				else
					local e_anim_data = focus_enemy.unit:anim_data()
					if ( e_anim_data.move or e_anim_data.idle ) and not e_anim_data.reload then
						--print( "not threatened2" )
						dodge = true
					end
				end
				
				if dodge then
					--print( "threatened" )
					if focus_enemy.aimed_at then
						--print( "in cone!" )
						--Application:set_pause( true )
						action_taken = CopLogicBase.chk_start_action_dodge( data, "preemptive" )
					end
				end
			end
		end
	--else
		--print( "action taken" )
	end
	
	-- Check should we hastily retreat from our focus enemy?
	if not action_taken and want_to_take_cover and not best_cover then
		action_taken = CopLogicAttack._chk_start_action_move_back( data, my_data, focus_enemy, false )
	end
	
	if not action_taken then
		action_taken = CopLogicAttack._chk_start_action_move_out_of_the_way( data, my_data )
	end
end

-- Remove some of the strict conditions for enemies shooting while on the move
-- This will result in enemies opening fire more likely while moving
-- Also greatly simplified the function
function TeamAILogicAssault._upd_aim(data, my_data)
	local focus_enemy = data.attention_obj
	local verified = focus_enemy and focus_enemy.verified
	local nearly_visible = focus_enemy and focus_enemy.nearly_visible

	local aim, shoot, expected_pos = CopLogicAttack._check_aim_shoot(data, my_data, focus_enemy, verified, nearly_visible)

	if aim or shoot then
		if verified or nearly_visible then
			if my_data.attention_unit ~= focus_enemy.u_key then
				CopLogicBase._set_attention(data, focus_enemy)
				my_data.attention_unit = focus_enemy.u_key
			end
		elseif expected_pos then
			if my_data.attention_unit ~= expected_pos then
				CopLogicBase._set_attention_on_pos(data, expected_pos)
				my_data.attention_unit = expected_pos
			end
		end

		if not my_data.shooting and not my_data.spooc_attack and not data.unit:anim_data().reload and not data.unit:movement():chk_action_forbidden("action") then
			my_data.shooting = data.unit:brain():action_request({
				body_part = 3,
				type = "shoot"
			})
		end
	else
		if my_data.shooting then
			local success = data.unit:brain():action_request({
				body_part = 3,
				type = "idle"
			})
			if success then
				my_data.shooting = nil
			end
		end

		if my_data.attention_unit then
			CopLogicBase._reset_attention(data)
			my_data.attention_unit = nil
		end
	end

	CopLogicAttack.aim_allow_fire(shoot, aim, data, my_data)
end

-- Helper function to reuse in other enemy logic _upd_aim functions
function TeamAILogicAssault._check_aim_shoot(data, my_data, focus_enemy, verified, nearly_visible)
	if not focus_enemy or focus_enemy.reaction < AIAttentionObject.REACT_AIM then
		return
	end

	local advancing = my_data.advancing and not my_data.advancing:stopping()
	local running = data.unit:anim_data().run or advancing and my_data.advancing._cur_vel and my_data.advancing._cur_vel > 300
	local time_since_verification = focus_enemy.verified_t and data.t - focus_enemy.verified_t or math.huge
	local weapon_range = data.internal_data.weapon_range or { close = 1000, far = 4000 }
	local firing_range = running and weapon_range.close or weapon_range.far

	local aim = not advancing or time_since_verification < math.lerp(4, 1, focus_enemy.verified_dis / firing_range) or focus_enemy.verified_dis < 800 or data.char_tweak.always_face_enemy
	local shoot = aim and my_data.shooting and AIAttentionObject.REACT_SHOOT <= focus_enemy.reaction and time_since_verification < (running and 2 or 4)
	local expected_pos = not shoot and focus_enemy.verified_dis < weapon_range.close and focus_enemy.m_head_pos or focus_enemy.last_verified_pos or focus_enemy.verified_pos

	if verified or nearly_visible then
		if not shoot and AIAttentionObject.REACT_SHOOT <= focus_enemy.reaction then
			local last_sup_t = data.unit:character_damage():last_suppression_t()

			if last_sup_t and data.t - last_sup_t < 7 * (running and 0.5 or 1) * (verified and 1 or 0.5) then
				shoot = true
			elseif verified and focus_enemy.verified_dis < firing_range then
				shoot = true
			elseif verified and focus_enemy.criminal_record and focus_enemy.criminal_record.assault_t and data.t - focus_enemy.criminal_record.assault_t < (running and 2 or 4) then
				shoot = true
			elseif my_data.attitude == "engage" and my_data.firing and time_since_verification < 4 then
				shoot = true
			end
		end

		aim = aim or shoot or focus_enemy.verified_dis < firing_range
	end

	return aim, shoot, expected_pos
end