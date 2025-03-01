local mvec3_dist_sq = mvector3.distance_sq

--Adds inspire animation, I think.
function TeamAILogicTravel.check_inspire(data, attention)
	if not attention then
		return
	end

	local range_sq = 810000
	local pos = data.unit:position()
	local target = attention.unit:position()
	local dist = mvec3_dist_sq(pos, target)

	if dist < range_sq and not attention.unit:character_damage():arrested() then
		data.unit:brain():set_objective()
		data.unit:sound():say("f36x_any", true, false)

		local can_play_action = not data.unit:movement():chk_action_forbidden("action") and not data.unit:anim_data().reload and not data.internal_data.firing and not data.internal_data.shooting

		if can_play_action then
			local new_action = {
				variant = "cmd_get_up",
				align_sync = true,
				body_part = 3,
				type = "act"
			}

			if data.unit:brain():action_request(new_action) then
				data.internal_data.gesture_arrest = true
			end
		end

		local cooldown = managers.player:crew_ability_upgrade_value("crew_inspire", 360)

		managers.player:start_custom_cooldown("team", "crew_inspire", cooldown)
		TeamAILogicTravel.actually_revive(data, attention.unit, true)

		local skip_alert = managers.groupai:state():whisper_mode()

		if not skip_alert then
			local alert_rad = 500
			local new_alert = {
				"vo_cbt",
				data.unit:movement():m_head_pos(),
				alert_rad,
				data.SO_access,
				data.unit
			}

			managers.groupai:state():propagate_alert(new_alert)
		end
	end
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel._upd_pathing(data, my_data)
	if data.pathing_results then
		local pathing_results = data.pathing_results
		data.pathing_results = nil
		local path = pathing_results[my_data.advance_path_search_id]

		if path and my_data.processing_advance_path then
			my_data.processing_advance_path = nil

			if path ~= "failed" then
				my_data.advance_path = path
			else
				data.path_fail_t = data.t

				data.objective_failed_clbk(data.unit, data.objective)

				return
			end
		end

		local path = pathing_results[my_data.coarse_path_search_id]

		if path and my_data.processing_coarse_path then
			my_data.processing_coarse_path = nil

			if path ~= "failed" then
				my_data.coarse_path = path
				my_data.coarse_path_index = 1
			elseif my_data.path_safely then
				my_data.path_safely = nil
			else
				print("[TeamAILogicTravel:_upd_pathing] coarse_path failed unsafe", data.unit, my_data.coarse_path_index)

				data.path_fail_t = data.t

				data.objective_failed_clbk(data.unit, data.objective)

				return
			end
		end
	end
end

--Stops CopLogicTravel changes from changing bot behavior
local _get_exact_move_pos_original = CopLogicTravel._get_exact_move_pos
function TeamAILogicTravel._get_exact_move_pos(data, nav_index, ...)
	local my_data = data.internal_data

	if alive(data.objective.shield_cover_unit) then
		if my_data.moving_to_cover then
			managers.navigation:release_cover(my_data.moving_to_cover[1])
			my_data.moving_to_cover = nil
		end

		return CopLogicTravel._get_pos_behind_unit(data, data.objective.shield_cover_unit, 50, 300)
	end

	local to_pos = nil
	local coarse_path = my_data.coarse_path
	local total_nav_points = #coarse_path

	if total_nav_points <= nav_index then
		return _get_exact_move_pos_original(data, nav_index, ...)
	end

	local nav_seg = coarse_path[nav_index][1]
	local area = managers.groupai:state():get_area_from_nav_seg_id(nav_seg)
	local cover = managers.navigation:find_cover_in_nav_seg_1(area.nav_segs)

	if my_data.moving_to_cover then
		managers.navigation:release_cover(my_data.moving_to_cover[1])
		my_data.moving_to_cover = nil
	end

	if cover then
		managers.navigation:reserve_cover(cover, data.pos_rsrv_id)
		my_data.moving_to_cover = {
			cover
		}
		to_pos = cover[1]
	else
		to_pos = CopLogicTravel._get_pos_on_wall(managers.navigation:find_random_position_in_segment(nav_seg), 500)
	end

	return to_pos
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel._determine_destination_occupation(data, objective)
	local occupation
	if objective.type == "investigate_area" then
		if objective.guard_obj then
			occupation = managers.groupai:state():verify_occupation_in_area( objective ) or objective.guard_obj
			occupation.type = "guard"
		else
			occupation = managers.groupai:state():find_occupation_in_area( objective.nav_seg )
		end
	elseif objective.type == "defend_area" then
		if objective.cover then
			occupation = { type = "defend", seg = objective.nav_seg, cover = objective.cover, radius = objective.radius }
		elseif objective.pos then
			occupation = { type = "defend", seg = objective.nav_seg, pos = objective.pos, radius = objective.radius }
		else
			local near_pos = objective.follow_unit and objective.follow_unit:movement():nav_tracker():field_position()
			local cover = CopLogicTravel._find_cover( data, objective.nav_seg, near_pos )
			if cover then
				local cover_entry = { cover }
				occupation = { type = "defend", seg = objective.nav_seg, cover = cover_entry, radius = objective.radius }
			else
				near_pos = CopLogicTravel._get_pos_on_wall( managers.navigation._nav_segments[ objective.nav_seg ].pos, 700 )
				occupation = { type = "defend", seg = objective.nav_seg, pos = near_pos, radius = objective.radius }
			end
		end
	elseif objective.type == "phalanx" then
		local logic = data.unit:brain():get_logic_by_name(objective.type)

		logic.register_in_group_ai(data.unit)

		local phalanx_circle_pos = logic.calc_initial_phalanx_pos(data.m_pos, objective)
		occupation = {
			type = "defend",
			seg = objective.nav_seg,
			pos = phalanx_circle_pos,
			radius = objective.radius
		}
	elseif objective.type == "act" then
		occupation = { type = "act", seg = objective.nav_seg, pos = objective.pos }
	elseif objective.type == "follow" then
		local follow_pos, follow_nav_seg
		local follow_unit_objective = objective.follow_unit:brain() and objective.follow_unit:brain():objective()
		if not follow_unit_objective or follow_unit_objective.in_place or not follow_unit_objective.nav_seg then	-- our follow unit is static
			follow_pos = objective.follow_unit:movement():m_pos()
			follow_nav_seg = objective.follow_unit:movement():nav_tracker():nav_segment()
		else	-- our follow unit is on the move
			follow_pos = follow_unit_objective.pos or objective.follow_unit:movement():m_pos()
			follow_nav_seg = follow_unit_objective.nav_seg
		end
		
		local distance = objective.distance and math.lerp( objective.distance * 0.5, objective.distance, math.random() ) or 700
		local to_pos = CopLogicTravel._get_pos_on_wall( follow_pos, distance )
		occupation = { type = "defend", nav_seg = follow_nav_seg, pos = to_pos }
	elseif objective.type == "revive" then
		local is_local_player = objective.follow_unit:base().is_local_player
		local revive_u_mv = objective.follow_unit:movement()
		local revive_u_tracker = revive_u_mv:nav_tracker()
		local revive_u_rot = is_local_player and Rotation(0, 0, 0) or revive_u_mv:m_rot()
		local revive_u_fwd = revive_u_rot:y()
		local revive_u_right = revive_u_rot:x()
		local revive_u_pos = revive_u_tracker:lost() and revive_u_tracker:field_position() or revive_u_mv:m_pos()
		local ray_params = {
			trace = true,
			tracker_from = revive_u_tracker
		}

		if revive_u_tracker:lost() then
			ray_params.pos_from = revive_u_pos
		end

		local stand_dis = nil

		if is_local_player or objective.follow_unit:base().is_husk_player then
			stand_dis = 120
		else
			stand_dis = 90
			local mid_pos = mvector3.copy(revive_u_fwd)

			mvector3.multiply(mid_pos, -20)
			mvector3.add(mid_pos, revive_u_pos)

			ray_params.pos_to = mid_pos
			local ray_res = managers.navigation:raycast(ray_params)
			revive_u_pos = ray_params.trace[1]
		end

		local rand_side_mul = math.random() > 0.5 and 1 or -1
		local revive_pos = mvector3.copy(revive_u_right)

		mvector3.multiply(revive_pos, rand_side_mul * stand_dis)
		mvector3.add(revive_pos, revive_u_pos)

		ray_params.pos_to = revive_pos
		local ray_res = managers.navigation:raycast(ray_params)

		if ray_res then
			local opposite_pos = mvector3.copy(revive_u_right)

			mvector3.multiply(opposite_pos, -rand_side_mul * stand_dis)
			mvector3.add(opposite_pos, revive_u_pos)

			ray_params.pos_to = opposite_pos
			local old_trace = ray_params.trace[1]
			local opposite_ray_res = managers.navigation:raycast(ray_params)

			if opposite_ray_res then
				if mvector3.distance(revive_pos, revive_u_pos) < mvector3.distance(ray_params.trace[1], revive_u_pos) then
					revive_pos = ray_params.trace[1]
				else
					revive_pos = old_trace
				end
			else
				revive_pos = ray_params.trace[1]
			end
		else
			revive_pos = ray_params.trace[1]
		end

		local revive_rot = revive_u_pos - revive_pos
		local revive_rot = Rotation(revive_rot, math.UP)
		occupation = {
			type = "revive",
			pos = revive_pos,
			rot = revive_rot
		}
	else
		occupation = { seg = objective.nav_seg, pos = objective.pos }
	end
	return occupation
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel._get_all_paths(data)
	return {
		advance_path = data.internal_data.advance_path
	}
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel._set_verified_paths(data, verified_paths)
	data.internal_data.advance_path = verified_paths.advance_path
end


--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel.chk_should_turn(data, my_data)
return not my_data.advancing and not my_data.turning and not my_data.has_old_action and not data.unit:movement():chk_action_forbidden("turn") and (not my_data.coarse_path or my_data.coarse_path_index < #my_data.coarse_path - 1 or not data.objective.rot)
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel.action_complete_clbk(data, action)
	--print( "CopLogicTravel.action_complete_clbk", action:type() )
	local my_data = data.internal_data
	local action_type = action:type()
	if action_type == "walk" then
		if action:expired() and not my_data.starting_advance_action and my_data.coarse_path_index and not my_data.has_old_action and my_data.advancing then	-- Action has terminated normally ( was not interrupted )
			my_data.coarse_path_index = my_data.coarse_path_index + 1
			if my_data.coarse_path_index > #my_data.coarse_path then
				debug_pause_unit( data.unit, "[CopLogicTravel.action_complete_clbk] invalid coarse path index increment", inspect( my_data.coarse_path ), my_data.coarse_path_index )
				my_data.coarse_path_index = my_data.coarse_path_index - 1
			end
		end
		
		my_data.advancing = nil
		
		if my_data.moving_to_cover then
			if action:expired() then	-- Action has terminated normally ( was not interrupted )
				if my_data.best_cover then	-- We are leaving our old cover
					managers.navigation:release_cover( my_data.best_cover[1] )
				end
				my_data.best_cover = my_data.moving_to_cover
				
				CopLogicBase.chk_cancel_delayed_clbk( my_data, my_data.cover_update_task_key )
				
				local high_ray = CopLogicTravel._chk_cover_height( data, my_data.best_cover[1], data.visibility_slotmask )
				my_data.best_cover[4] = high_ray
				my_data.in_cover = true
				local cover_wait_t = my_data.cover_wait_t or { 0.7, 0.8 } -- 0.7 to 1.5
				my_data.cover_leave_t = data.t + cover_wait_t[1] + cover_wait_t[2] * math.random()
			else
				managers.navigation:release_cover( my_data.moving_to_cover[1] )
				if my_data.best_cover then	-- We are leaving our old cover
					local dis = mvector3.distance( my_data.best_cover[1][1], data.unit:movement():m_pos() )
					if dis > 100 then
						managers.navigation:release_cover( my_data.best_cover[1] )
						my_data.best_cover = nil
					end
				end
			end
			my_data.moving_to_cover = nil
		else
			if my_data.best_cover then	-- We are leaving our old cover
				local dis = mvector3.distance( my_data.best_cover[1][1], data.unit:movement():m_pos() )
				if dis > 100 then
					managers.navigation:release_cover( my_data.best_cover[1] )
					my_data.best_cover = nil
				end
			end
		end
	elseif action_type == "turn" then
		data.internal_data.turning = nil
	elseif action_type == "shoot" then
		data.internal_data.shooting = nil
	elseif action_type == "dodge" then
		local objective = data.objective
		local allow_trans, obj_failed = CopLogicBase.is_obstructed( data, objective, nil, nil )
		if allow_trans then
			local wanted_state = data.logic._get_logic_state_from_reaction( data )
			if wanted_state and wanted_state ~= data.name then
				if obj_failed then
					if data.unit:in_slot( managers.slot:get_mask( "enemies" ) ) or data.unit:in_slot( 17 ) then
						managers.groupai:state():on_objective_failed( data.unit, data.objective )
					elseif data.unit:in_slot( managers.slot:get_mask( "criminals" ) ) then
						managers.groupai:state():on_criminal_objective_failed( data.unit, data.objective, false )
					end
					
					if my_data == data.internal_data then -- if we haven't changed state already, change now
						debug_pause_unit( data.unit, "[CopLogicTravel.action_complete_clbk] exiting without discarding objective", data.unit, inspect( data.objective ) )
						CopLogicBase._exit( data.unit, wanted_state )
					end
				end
			end
		end
	end
end

function TeamAILogicTravel.update(data)
	if data.objective.type == "revive" and managers.player:is_custom_cooldown_not_active("team", "crew_inspire") then
		local attention = data.detected_attention_objects[data.objective.follow_unit:key()]

		TeamAILogicTravel.check_inspire(data, attention)
	end

	return TeamAILogicTravel.upd_advance(data)
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel.upd_advance(data)
	local unit = data.unit
	local my_data = data.internal_data
	local objective = data.objective
	local t = TimerManager:game():time()
	data.t = t

	if my_data.has_old_action then
		CopLogicAttack._upd_stop_old_action(data, my_data)
	elseif my_data.warp_pos then
		local action_desc = {
			body_part = 1,
			type = "warp",
			position = mvector3.copy(objective.pos),
			rotation = objective.rot
		}

		if unit:movement():action_request(action_desc) then
			TeamAILogicTravel._on_destination_reached(data)
		end
	elseif my_data.advancing then
		if my_data.coarse_path then
			if my_data.announce_t and my_data.announce_t < t then
				CopLogicTravel._try_anounce(data, my_data)
			end

			CopLogicTravel._chk_stop_for_follow_unit(data, my_data)

			if my_data ~= data.internal_data then
				return
			end
		end
	elseif my_data.advance_path then
		CopLogicTravel._chk_begin_advance(data, my_data)

		if my_data.advancing and my_data.path_ahead then
			CopLogicTravel._check_start_path_ahead(data)
		end
	elseif my_data.processing_advance_path or my_data.processing_coarse_path then
		TeamAILogicTravel._upd_pathing(data, my_data)

		if my_data ~= data.internal_data then
			return
		end
	elseif my_data.cover_leave_t then
		if not my_data.turning and not unit:movement():chk_action_forbidden("walk") and not data.unit:anim_data().reload then
			if my_data.cover_leave_t < t then
				my_data.cover_leave_t = nil
			elseif data.attention_obj and AIAttentionObject.REACT_SCARED <= data.attention_obj.reaction and (not my_data.best_cover or not my_data.best_cover[4]) and not unit:anim_data().crouch and (not data.char_tweak.allowed_poses or data.char_tweak.allowed_poses.crouch) then
				CopLogicAttack._chk_request_action_crouch(data)
			end
		end
	elseif objective and (objective.nav_seg or objective.type == "follow") then
		if my_data.coarse_path then
			if my_data.coarse_path_index == #my_data.coarse_path then
				TeamAILogicTravel._on_destination_reached(data)

				return
			else
				CopLogicTravel._chk_start_pathing_to_next_nav_point(data, my_data)
			end
		else
			CopLogicTravel._begin_coarse_pathing(data, my_data)
		end
	else
		CopLogicBase._exit(data.unit, "idle")

		return
	end
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel._on_destination_reached(data)
	local objective = data.objective
	objective.in_place = true

	if objective.type == "free" then
		if not objective.action_duration then
			data.objective_complete_clbk(data.unit, objective)

			return
		end
	elseif objective.type == "flee" then
		data.unit:brain():set_active(false)
		data.unit:base():set_slot(data.unit, 0)

		return
	elseif objective.type == "defend_area" then
		if objective.grp_objective and objective.grp_objective.type == "retire" then
			data.unit:brain():set_active(false)
			data.unit:base():set_slot(data.unit, 0)

			return
		else
			managers.groupai:state():on_defend_travel_end(data.unit, objective)
		end
	end

	data.logic.on_new_objective(data)
end

--Stops CopLogicTravel changes from changing bot behavior, is copy of vanilla CopLogicTravel function.
function TeamAILogicTravel._update_cover(ignore_this, data)
	--print( "CopLogicTravel._update_cover", data.t )
	local my_data = data.internal_data
	CopLogicBase.on_delayed_clbk( my_data, my_data.cover_update_task_key )
	
	local cover_release_dis = 100
	local nearest_cover = my_data.nearest_cover
	local best_cover = my_data.best_cover
	local m_pos = data.m_pos
	
	if not my_data.in_cover and nearest_cover and mvector3.distance( nearest_cover[1][1], m_pos ) > cover_release_dis	then -- I dont want cover and have one
		managers.navigation:release_cover( nearest_cover[1] )
		my_data.nearest_cover = nil
		nearest_cover = nil
	end
	if best_cover and mvector3.distance( best_cover[1][1], m_pos ) > cover_release_dis	then -- I dont want cover and have one
		managers.navigation:release_cover( best_cover[1] )
		my_data.best_cover = nil
		best_cover = nil
	end
	
	if nearest_cover or best_cover then
		CopLogicBase.add_delayed_clbk( my_data, my_data.cover_update_task_key, callback( CopLogicTravel, CopLogicTravel, "_update_cover", data ), data.t + 1 )
	end
end

function TeamAILogicTravel._upd_enemy_detection(data)
	data.t = TimerManager:game():time()
	local my_data = data.internal_data
	local max_reaction = nil

	if data.cool then
		max_reaction = AIAttentionObject.REACT_SURPRISED
	end

	local delay = CopLogicBase._upd_attention_obj_detection(data, AIAttentionObject.REACT_CURIOUS, max_reaction)
	local new_attention, new_prio_slot, new_reaction = TeamAILogicIdle._get_priority_attention(data, data.detected_attention_objects, nil)

	TeamAILogicBase._set_attention_obj(data, new_attention, new_reaction)
	TeamAILogicIdle.check_idle_reload(data, new_reaction) --Fix reloading behavior.

	if new_attention then
		local objective = data.objective
		local allow_trans, obj_failed = nil
		local dont_exit = false

		if data.unit:movement():chk_action_forbidden("walk") and not data.unit:anim_data().act_idle then
			dont_exit = true
		else
			allow_trans, obj_failed = CopLogicBase.is_obstructed(data, objective, nil, new_attention)
		end

		if obj_failed and not dont_exit then
			if objective.type == "follow" then
				debug_pause_unit(data.unit, "failing follow", allow_trans, obj_failed, inspect(objective))
			end

			data.objective_failed_clbk(data.unit, data.objective)

			return
		end
	end

	CopLogicAttack._upd_aim(data, my_data)

	--New intimidation assistance behavior. TODO: FILL OUT DETAILS LATER.
	if not my_data._intimidate_chk_t or my_data._intimidate_chk_t + 0.5 < data.t then
		if not data.unit:brain()._intimidate_t or data.unit:brain()._intimidate_t + 2 < data.t then
			my_data._intimidate_chk_t = data.t

			if data.unit:movement()._should_stay then
				local can_turn = nil

				if not my_data._turning_to_intimidate_t or my_data._turning_to_intimidate_t + 2 < data.t then
					if not data.unit:movement():chk_action_forbidden("turn") then
						if not new_prio_slot or new_prio_slot > 5 then
							can_turn = true
						end
					end
				end

				local shout_angle = can_turn and 180 or 90
				local shout_distance = 1200
				local civ = TeamAILogicIdle.find_civilian_to_intimidate(data.unit, shout_angle, shout_distance)

				if civ then
					if can_turn and CopLogicAttack._chk_request_action_turn_to_enemy(data, my_data, data.m_pos, civ:movement():m_pos()) then
						my_data._turning_to_intimidate_t = data.t
					else
						if TeamAILogicIdle.intimidate_civilians(data, data.unit, true, true) then
							data.unit:brain()._intimidate_t = data.t
						end
					end
				end
			else
				local civ = TeamAILogicIdle.intimidate_civilians(data, data.unit, true, true)

				if civ then
					data.unit:brain()._intimidate_t = data.t

					if not data.attention_obj then
						CopLogicBase._set_attention_on_unit(data, civ)

						local key = "RemoveAttentionOnUnit" .. tostring(data.key)

						CopLogicBase.queue_task(my_data, key, TeamAILogicTravel._remove_enemy_attention, {
							data = data,
							target_key = civ:key()
						}, data.t + 1.5)
					end
				end
			end
		end
	end

	TeamAILogicAssault._chk_request_combat_chatter(data, my_data)
	TeamAILogicIdle._upd_sneak_spotting(data, my_data)
	CopLogicBase.queue_task(my_data, my_data.detection_task_key, TeamAILogicTravel._upd_enemy_detection, data, data.t + delay)
end

function TeamAILogicTravel._find_cover(data, search_nav_seg, near_pos)
	local cover = nil
	local search_area = managers.groupai:state():get_area_from_nav_seg_id(search_nav_seg)

	if data.unit:movement():cool() then
		cover = managers.navigation:find_cover_in_nav_seg_1(search_area.nav_segs)
	else
		local optimal_threat_dis, threat_pos = nil

		if data.objective.attitude == "engage" then
			optimal_threat_dis = data.internal_data.weapon_range.optimal
		else
			optimal_threat_dis = data.internal_data.weapon_range.far
		end

		near_pos = near_pos or search_area.pos
		local all_criminals = managers.groupai:state():all_char_criminals()
		local closest_crim_u_data, closest_crim_dis = nil

		for u_key, u_data in pairs(all_criminals) do
			local crim_area = managers.groupai:state():get_area_from_nav_seg_id(u_data.tracker:nav_segment())

			if crim_area == search_area then
				threat_pos = u_data.m_pos

				break
			else
				local crim_dis = mvector3.distance_sq(near_pos, u_data.m_pos)

				if not closest_crim_dis or crim_dis < closest_crim_dis then
					threat_pos = u_data.m_pos
					closest_crim_dis = crim_dis
				end
			end
		end

		cover = managers.navigation:find_cover_from_threat(search_area.nav_segs, optimal_threat_dis, near_pos, threat_pos)
	end

	return cover
end

-- Take the direct path if possible and immediately start pathing instead of waiting for the next update (thanks to RedFlame)
function TeamAILogicTravel._check_start_path_ahead(data)
	local my_data = data.internal_data

	if my_data.processing_advance_path then
		return
	end

	local coarse_path = my_data.coarse_path
	local next_index = my_data.coarse_path_index + 2
	local total_nav_points = #coarse_path

	if next_index > total_nav_points then
		return
	end

	local to_pos = data.logic._get_exact_move_pos(data, next_index)
	local from_pos = data.pos_rsrv.move_dest.position

	if math_abs(from_pos.z - to_pos.z) < 100 and not managers.navigation:raycast({allow_entry = false, pos_from = from_pos, pos_to = to_pos}) then
		my_data.advance_path = {
			mvec3_copy(from_pos),
			to_pos
		}

		return
	end

	my_data.processing_advance_path = true
	local prio = data.logic.get_pathing_prio(data)
	local nav_segs = CopLogicTravel._get_allowed_travel_nav_segs(data, my_data, to_pos)

	data.unit:brain():search_for_path_from_pos(my_data.advance_path_search_id, from_pos, to_pos, prio, nil, nav_segs)
end

function TeamAILogicTravel._chk_start_pathing_to_next_nav_point(data, my_data)
	if not CopLogicTravel.chk_group_ready_to_move(data, my_data) then
		return
	end

	local from_pos = data.unit:movement():nav_tracker():field_position()
	local to_pos = CopLogicTravel._get_exact_move_pos(data, my_data.coarse_path_index + 1)

	if math_abs(from_pos.z - to_pos.z) < 100 and not managers.navigation:raycast({allow_entry = false, pos_from = from_pos, pos_to = to_pos}) then
		my_data.advance_path = {
			mvec3_copy(from_pos),
			to_pos
		}

		-- If we don't have to wait for the pathing results, immediately start advancing
		CopLogicTravel._chk_begin_advance(data, my_data)
		if my_data.advancing and my_data.path_ahead then
			CopLogicTravel._check_start_path_ahead(data)
		end

		return
	end

	my_data.processing_advance_path = true
	local prio = data.logic.get_pathing_prio(data)
	local nav_segs = CopLogicTravel._get_allowed_travel_nav_segs(data, my_data, to_pos)

	data.unit:brain():search_for_path(my_data.advance_path_search_id, to_pos, prio, nil, nav_segs)
end