Hooks:PostHook(WeaponFactoryTweakData, "init", "eclipse_init_mods", function(self)	
	local stat_blacklist = {
		"foregrip",
		"extra",
		"grip",
		"stock",
		"lower_body",
		"body",
		"vertical_grip",
		"lower_reciever",
		"upper_reciever",
		"drag_handle",
		"bolt",
		"slide",
		"gadget",
	}

	local secondary_sights = {
		"wpn_fps_upg_o_xpsg33_magnifier",
		"wpn_fps_upg_o_45rds",
		"wpn_fps_upg_o_45rds_v2",
		"wpn_fps_upg_o_sig",
		"wpn_fps_upg_o_45steel",
	}

	for id, part in pairs(self.parts) do
		local is_second_sight = table.contains(secondary_sights, id)

		if not part.custom_stats then
			part.custom_stats = {}
		end
		
		if table.contains(stat_blacklist, part.type) and not is_second_sight then
			part.stats = {}
			part.custom_stats = {}
		end

		if part.stats then
			local is_sight = part.type and part.type == "sight"
			local is_magazine = part.type and part.type == "magazine"
			local is_optic = is_sight and part.perks and table.contains(part.perks, "scope")
			local is_scope = is_optic and part.stats.zoom and part.stats.zoom > 3
			local is_silencer = part.perks and table.contains(part.perks, "silencer")

			if part.stats.suppression then
				part.stats.suppression = 0
			end

			if part.stats.spread_moving then
				part.stats.spread_moving = 0
			end

			local shortdot = id == "wpn_fps_upg_o_shortdot"
			if is_optic and not shortdot then
				part.stats.concealment = -1
				part.stats.recoil = 1
				part.stats.spread = 0

				if is_scope then
					local zoom_to_spread
					local zoom_to_concealment
					local zoom_level = part.stats.zoom
					if zoom_level then
						zoom_to_spread = math.clamp((zoom_level - 3) * 1, 1, 4)
						zoom_to_concealment = -math.clamp((zoom_level - 3) * 1, 1, 4)
					end

					part.stats.recoil = 0
					part.stats.spread = zoom_to_spread or 1
					part.stats.concealment = zoom_to_concealment or -2
				end
			end

			if is_second_sight then
				part.stats.spread = 0
				part.stats.recoil = 0
				part.stats.concealment = -1
			end

			if is_sight and id:match("_standard$") or id:match("_iron") then
				part.stats.concealment = 0
				part.stats.recoil = 0
				part.stats.zoom = 0
			end

			if is_magazine and id:match("_quick$") or id:match("_speed$") then
				part.stats = {}
				part.stats.concealment = -1
				part.custom_stats = { reload_speed_multiplier = 1.1 }
			end

			if id:match("_legend") and not is_silencer then
				part.stats = {}
				part.custom_stats = {}
			end
		end
	end

	local slug_stance_muls = {
		spread = {
			standing = {
				hipfire = 1.25,
				crouching = 0.75,
				steelsight = 0.5,
			},
			moving = {
				hipfire = 1.5,
				crouching = 1,
				steelsight = 0.75,
			},
		},
		recoil = {
			standing = {
				hipfire = 1.25,
				crouching = 1,
				steelsight = 1,
			},
			moving = {
				hipfire = 1.5,
				crouching = 1,
				steelsight = 1,
			},
		},
	}

	-- SHOTGUNS --
	local shotgun_ammo_overrides = {
		wpn_fps_upg_a_custom = {
			very_heavy = { -- double barrels
				stats = { damage = 26, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = 20, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = 17, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			light = { -- semi autos
				stats = { damage = 13, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			very_light = { -- full autos
				stats = { damage = 10, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			default = { -- for custom shotties
				stats = { damage = 17, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
		},
		wpn_fps_upg_a_custom_free = {
			very_heavy = { -- double barrels
				stats = { damage = 26, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = 20, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = 17, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			light = { -- semi autos
				stats = { damage = 13, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			very_light = { -- full autos
				stats = { damage = 10, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
			default = { -- for custom shotties
				stats = { damage = 17, total_ammo_mod = -6, recoil = -2 },
				custom_stats = { rays = 6, ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, muzzleflash = "effects/payday2/particles/weapons/shotgun/resmod1", damage_near_mul = 0.8, damage_far_mul = 0.6 },
			},
		},
		wpn_fps_upg_a_explosive = {
			very_heavy = { -- double barrels
				stats = { damage = 315, total_ammo_mod = -10, recoil = -2, spread = 3, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ignore_statistic = true,
					ammo_pickup_max_mul = 0.5,
					ammo_pickup_min_mul = 0.5,
					stance_mul = slug_stance_muls,
					bullet_class = "InstantExplosiveBulletBase",
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					muzzleflash = "effects/payday2/particles/weapons/pistol/pis_muzzleflash",
				},
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = 245, total_ammo_mod = -10, recoil = -2, spread = 3, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ignore_statistic = true,
					ammo_pickup_max_mul = 0.5,
					ammo_pickup_min_mul = 0.5,
					stance_mul = slug_stance_muls,
					bullet_class = "InstantExplosiveBulletBase",
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					muzzleflash = "effects/payday2/particles/weapons/pistol/pis_muzzleflash",
				},
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = 210, total_ammo_mod = -10, recoil = -2, spread = 3, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ignore_statistic = true,
					ammo_pickup_max_mul = 0.5,
					ammo_pickup_min_mul = 0.5,
					stance_mul = slug_stance_muls,
					bullet_class = "InstantExplosiveBulletBase",
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					muzzleflash = "effects/payday2/particles/weapons/pistol/pis_muzzleflash",
				},
			},
			light = { -- semi autos
				stats = { damage = 175, total_ammo_mod = -10, recoil = -2, spread = 3, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ignore_statistic = true,
					ammo_pickup_max_mul = 0.5,
					ammo_pickup_min_mul = 0.5,
					stance_mul = slug_stance_muls,
					bullet_class = "InstantExplosiveBulletBase",
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					muzzleflash = "effects/payday2/particles/weapons/pistol/pis_muzzleflash",
				},
			},
			very_light = { -- full autos
				stats = { damage = 160, total_ammo_mod = -10, recoil = -2, spread = 3, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ignore_statistic = true,
					ammo_pickup_max_mul = 0.5,
					ammo_pickup_min_mul = 0.5,
					stance_mul = slug_stance_muls,
					bullet_class = "InstantExplosiveBulletBase",
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					muzzleflash = "effects/payday2/particles/weapons/pistol/pis_muzzleflash",
				},
			},
			default = { -- for custom shotties
				stats = { damage = 210, total_ammo_mod = -10, recoil = -2, spread = 3, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ignore_statistic = true,
					ammo_pickup_max_mul = 0.5,
					ammo_pickup_min_mul = 0.5,
					stance_mul = slug_stance_muls,
					bullet_class = "InstantExplosiveBulletBase",
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					muzzleflash = "effects/payday2/particles/weapons/pistol/pis_muzzleflash",
				},
			},
		},
		wpn_fps_upg_a_slug = {
			very_heavy = { -- double barrels
				stats = { damage = 200, total_ammo_mod = -4, recoil = -2, spread = 4, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					can_shoot_through_wall = true,
					can_shoot_through_enemy = true,
					stance_mul = slug_stance_muls,
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					check_additional_achievements = true,
					muzzleflash = "effects/payday2/particles/weapons/50cal_auto_fps",
				},
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = 155, total_ammo_mod = -4, recoil = -2, spread = 4, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					can_shoot_through_wall = true,
					can_shoot_through_enemy = true,
					stance_mul = slug_stance_muls,
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					check_additional_achievements = true,
					muzzleflash = "effects/payday2/particles/weapons/50cal_auto_fps",
				},
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = 130, total_ammo_mod = -4, recoil = -2, spread = 4, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					can_shoot_through_wall = true,
					can_shoot_through_enemy = true,
					stance_mul = slug_stance_muls,
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					check_additional_achievements = true,
					muzzleflash = "effects/payday2/particles/weapons/50cal_auto_fps",
				},
			},
			light = { -- semi autos
				stats = { damage = 95, total_ammo_mod = -4, recoil = -2, spread = 4, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					can_shoot_through_wall = true,
					can_shoot_through_enemy = true,
					stance_mul = slug_stance_muls,
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					check_additional_achievements = true,
					muzzleflash = "effects/payday2/particles/weapons/50cal_auto_fps",
				},
			},
			very_light = { -- full autos
				stats = { damage = 80, total_ammo_mod = -4, recoil = -2, spread = 4, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					can_shoot_through_wall = true,
					can_shoot_through_enemy = true,
					stance_mul = slug_stance_muls,
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					check_additional_achievements = true,
					muzzleflash = "effects/payday2/particles/weapons/50cal_auto_fps"
				},
			},
			default = { -- for custom shotties
				stats = { damage = 130, total_ammo_mod = -4, recoil = -2, spread = 4, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					armor_piercing_add = 1,
					can_shoot_through_shield = true,
					can_shoot_through_wall = true,
					can_shoot_through_enemy = true,
					stance_mul = slug_stance_muls,
					damage_near_mul = 3,
					damage_far_mul = 2,
					rays = 1,
					check_additional_achievements = true,
					muzzleflash = "effects/payday2/particles/weapons/50cal_auto_fps",
				},
			},
		},
		wpn_fps_upg_a_piercing = {
			very_heavy = { -- double barrels
				stats = { damage = -18, total_ammo_mod = -6, recoil = -3, spread = 2 },
				custom_stats = { rays = 12, armor_piercing_add = 1, can_shoot_through_enemy = true, muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_fle_muzzleflash", damage_near_mul = 1, damage_far_mul = 1.1 },
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = -14, total_ammo_mod = -6, recoil = -3, spread = 2 },
				custom_stats = { rays = 12, armor_piercing_add = 1, can_shoot_through_enemy = true, muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_fle_muzzleflash", damage_near_mul = 1, damage_far_mul = 1.1 },
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = -12, total_ammo_mod = -6, recoil = -3, spread = 2 },
				custom_stats = { rays = 12, armor_piercing_add = 1, can_shoot_through_enemy = true, muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_fle_muzzleflash", damage_near_mul = 1, damage_far_mul = 1.1 },
			},
			light = { -- semi autos
				stats = { damage = -10, total_ammo_mod = -6, recoil = -3, spread = 2 },
				custom_stats = { rays = 12, armor_piercing_add = 1, can_shoot_through_enemy = true, muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_fle_muzzleflash", damage_near_mul = 1, damage_far_mul = 1.1 },
			},
			very_light = { -- full autos
				stats = { damage = -8, total_ammo_mod = -6, recoil = -3, spread = 2 },
				custom_stats = { rays = 12, armor_piercing_add = 1, can_shoot_through_enemy = true, muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_fle_muzzleflash", damage_near_mul = 1, damage_far_mul = 1.1 },
			},
			default = { -- for custom shotties
				stats = { damage = -12, total_ammo_mod = -6, recoil = -3, spread = 2 },
				custom_stats = { rays = 12, armor_piercing_add = 1, can_shoot_through_enemy = true, muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_fle_muzzleflash", damage_near_mul = 1, damage_far_mul = 1.1 },
			},
		},
		wpn_fps_upg_a_dragons_breath = {
			very_heavy = { -- double barrels
				stats = { damage = -24, total_ammo_mod = -8, spread = -2 },
				custom_stats = {
					ammo_pickup_min_mul = 0.7,
					ammo_pickup_max_mul = 0.7,
					armor_piercing_add = 1,
					rays = 10,
					dot_data_name = "ammo_dragons_breath_heavy",
					bullet_class = "FlameBulletBase",
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
				},
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = -23, total_ammo_mod = -8, spread = -2 },
				custom_stats = {
					ammo_pickup_min_mul = 0.7,
					ammo_pickup_max_mul = 0.7,
					armor_piercing_add = 1,
					rays = 10,
					dot_data_name = "ammo_dragons_breath_heavy",
					bullet_class = "FlameBulletBase",
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
				},
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = -20, total_ammo_mod = -8, spread = -2 },
				custom_stats = {
					ammo_pickup_min_mul = 0.7,
					ammo_pickup_max_mul = 0.7,
					armor_piercing_add = 1,
					rays = 10,
					dot_data_name = "ammo_dragons_breath_medium",
					bullet_class = "FlameBulletBase",
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
				},
			},
			light = { -- semi autos
				stats = { damage = -16, total_ammo_mod = -8, spread = -2 },
				custom_stats = {
					ammo_pickup_min_mul = 0.7,
					ammo_pickup_max_mul = 0.7,
					armor_piercing_add = 1,
					rays = 10,
					dot_data_name = "ammo_dragons_breath_light",
					bullet_class = "FlameBulletBase",
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
				},
			},
			very_light = { -- full autos
				stats = { damage = -12, total_ammo_mod = -8, spread = -2 },
				custom_stats = {
					ammo_pickup_min_mul = 0.7,
					ammo_pickup_max_mul = 0.7,
					armor_piercing_add = 1,
					rays = 10,
					dot_data_name = "ammo_dragons_breath_light",
					bullet_class = "FlameBulletBase",
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
				},
			},
			default = { -- for custom shotties
				stats = { damage = -20, total_ammo_mod = -8, spread = -2 },
				custom_stats = {
					ammo_pickup_min_mul = 0.7,
					ammo_pickup_max_mul = 0.7,
					armor_piercing_add = 1,
					rays = 10,
					dot_data_name = "ammo_dragons_breath_medium",
					bullet_class = "FlameBulletBase",
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_dragons_breath",
				},
			},
		},
		wpn_fps_upg_a_rip = {
			very_heavy = { -- double barrels
				stats = { damage = 120, total_ammo_mod = -10, spread = 2, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ammo_pickup_min_mul = 0.6,
					ammo_pickup_max_mul = 0.6,
					armor_piercing_add = 1,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_rip_heavy",
					stance_mul = slug_stance_muls,
					damage_near_mul = 1.5,
					damage_far_mul = 1,
					rays = 1,
					bullet_class = "PoisonBulletBase",
				},
			},
			heavy = { -- shotguns like gsps and the trench gun
				stats = { damage = 85, total_ammo_mod = -10, spread = 2, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ammo_pickup_min_mul = 0.6,
					ammo_pickup_max_mul = 0.6,
					armor_piercing_add = 1,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_rip_heavy",
					stance_mul = slug_stance_muls,
					damage_near_mul = 1.5,
					damage_far_mul = 1,
					rays = 1,
					bullet_class = "PoisonBulletBase",
				},
			},
			medium = { -- raven, loco, reinfeld, etc
				stats = { damage = 70, total_ammo_mod = -10, spread = 2, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ammo_pickup_min_mul = 0.6,
					ammo_pickup_max_mul = 0.6,
					armor_piercing_add = 1,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_rip_medium",
					stance_mul = slug_stance_muls,
					damage_near_mul = 1.5,
					damage_far_mul = 1,
					rays = 1,
					bullet_class = "PoisonBulletBase",
				},
			},
			light = { -- semi autos
				stats = { damage = 55, total_ammo_mod = -10, spread = 2, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ammo_pickup_min_mul = 0.6,
					ammo_pickup_max_mul = 0.6,
					armor_piercing_add = 1,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_rip_light",
					stance_mul = slug_stance_muls,
					damage_near_mul = 1.5,
					damage_far_mul = 1,
					rays = 1,
					bullet_class = "PoisonBulletBase",
				},
			},
			very_light = { -- full autos
				stats = { damage = 40, total_ammo_mod = -10, spread = 2, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ammo_pickup_min_mul = 0.6,
					ammo_pickup_max_mul = 0.6,
					armor_piercing_add = 1,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_rip_light",
					stance_mul = slug_stance_muls,
					damage_near_mul = 1.5,
					damage_far_mul = 1,
					rays = 1,
					bullet_class = "PoisonBulletBase",
				},
			},
			default = { -- for custom shotties
				stats = { damage = 70, total_ammo_mod = -10, spread = 2, spread_multi = { 0.5, 0.5 } },
				custom_stats = {
					ammo_pickup_min_mul = 0.6,
					ammo_pickup_max_mul = 0.6,
					armor_piercing_add = 1,
					muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_rip",
					dot_data_name = "ammo_rip_medium",
					stance_mul = slug_stance_muls,
					damage_near_mul = 1.5,
					damage_far_mul = 1,
					rays = 1,
					bullet_class = "PoisonBulletBase",
				},
			},
		},
	}

	local shotgun_table = {
		"wpn_fps_shot_saiga",
		"wpn_fps_sho_aa12",
		"wpn_fps_sho_basset",
		"wpn_fps_sho_sko12",
		"wpn_fps_sho_ben",
		"wpn_fps_sho_striker",
		"wpn_fps_sho_spas12",
		"wpn_fps_sho_rota",
		"wpn_fps_sho_ultima",
		"wpn_fps_shot_r870",
		"wpn_fps_shot_serbu",
		"wpn_fps_sho_ksg",
		"wpn_fps_pis_judge",
		"wpn_fps_sho_m590",
		"wpn_fps_sho_supernova",
		"wpn_fps_sho_boot",
		"wpn_fps_shot_m37",
		"wpn_fps_shot_m1897",
		"wpn_fps_shot_huntsman",
		"wpn_fps_shot_b682",
		"wpn_fps_sho_coach",
	}

	local shotgun_ammo_table = {
		"wpn_fps_upg_a_custom",
		"wpn_fps_upg_a_custom_free",
		"wpn_fps_upg_a_explosive",
		"wpn_fps_upg_a_slug",
		"wpn_fps_upg_a_piercing",
		"wpn_fps_upg_a_dragons_breath",
		"wpn_fps_upg_a_rip",
	}

	local shotgun_ammo_override_map = {
		["wpn_fps_shot_saiga"] = "very_light",
		["wpn_fps_sho_aa12"] = "very_light",
		["wpn_fps_sho_basset"] = "very_light",
		["wpn_fps_sho_sko12"] = "very_light",
		["wpn_fps_sho_ben"] = "light",
		["wpn_fps_sho_striker"] = "light",
		["wpn_fps_sho_spas12"] = "light",
		["wpn_fps_sho_rota"] = "light",
		["wpn_fps_sho_ultima"] = "light",
		["wpn_fps_shot_r870"] = "medium",
		["wpn_fps_shot_serbu"] = "medium",
		["wpn_fps_sho_ksg"] = "medium",
		["wpn_fps_pis_judge"] = "medium",
		["wpn_fps_sho_m590"] = "medium",
		["wpn_fps_sho_supernova"] = "medium",
		["wpn_fps_sho_boot"] = "heavy",
		["wpn_fps_shot_m37"] = "heavy",
		["wpn_fps_shot_m1897"] = "heavy",
		["wpn_fps_shot_huntsman"] = "very_heavy",
		["wpn_fps_shot_b682"] = "very_heavy",
		["wpn_fps_sho_coach"] = "very_heavy",
	}

	for index, part_id in ipairs(shotgun_ammo_table) do
		if self.parts[part_id].stats then
			self.parts[part_id].stats = shotgun_ammo_overrides[part_id]["default"].stats
		end

		if self.parts[part_id].custom_stats then
			self.parts[part_id].custom_stats = shotgun_ammo_overrides[part_id]["default"].custom_stats
		end
	end

	for index, weapon_id in ipairs(shotgun_table) do
		if not self[weapon_id].override then
			self[weapon_id].override = {}
		end
	end

	for index, weapon_id in ipairs(shotgun_table) do
		for index, ammo_id in ipairs(shotgun_ammo_table) do
			local ammo_override = shotgun_ammo_override_map[weapon_id]

			if ammo_override and shotgun_ammo_overrides[ammo_id] and shotgun_ammo_overrides[ammo_id][ammo_override] then
				self[weapon_id].override[ammo_id] = shotgun_ammo_overrides[ammo_id][ammo_override]
			end
		end
	end

	local grenade_launcher_ammo_overrides = {
		wpn_fps_upg_a_grenade_launcher_incendiary = {
			heavy = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.6, ammo_pickup_min_mul = 0.6, launcher_grenade = "launcher_incendiary" },
			},
			medium = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.6, ammo_pickup_min_mul = 0.6, launcher_grenade = "launcher_incendiary" },
			},
			light = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.6, ammo_pickup_min_mul = 0.6, launcher_grenade = "launcher_incendiary" },
			},
			default = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.6, ammo_pickup_min_mul = 0.6, launcher_grenade = "launcher_incendiary" },
			},
		},
		wpn_fps_upg_a_grenade_launcher_electric = {
			heavy = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, launcher_grenade = "launcher_electric" },
			},
			medium = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, launcher_grenade = "launcher_electric" },
			},
			light = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, launcher_grenade = "launcher_electric" },
			},
			default = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.8, ammo_pickup_min_mul = 0.8, launcher_grenade = "launcher_electric" },
			},
		},
		wpn_fps_upg_a_grenade_launcher_poison = {
			heavy = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.4, ammo_pickup_min_mul = 0.4, launcher_grenade = "launcher_poison" },
			},
			medium = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.4, ammo_pickup_min_mul = 0.4, launcher_grenade = "launcher_poison" },
			},
			light = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.4, ammo_pickup_min_mul = 0.4, launcher_grenade = "launcher_poison" },
			},
			default = {
				stats = { damage = 0 },
				custom_stats = { ammo_pickup_max_mul = 0.4, ammo_pickup_min_mul = 0.4, launcher_grenade = "launcher_poison" },
			},
		},
	}

	local grenade_launcher_table = {
		"wpn_fps_gre_arbiter",
		"wpn_fps_gre_ms3gl",
		"wpn_fps_gre_m32",
		"wpn_fps_gre_china",
		"wpn_fps_gre_m79",
		"wpn_fps_gre_slap",
		"wpn_fps_ass_contraband",
		"wpn_fps_ass_groza",
	}

	local grenade_launcher_ammo_table = {
		"wpn_fps_upg_a_grenade_launcher_incendiary",
		"wpn_fps_upg_a_grenade_launcher_electric",
		"wpn_fps_upg_a_grenade_launcher_poison",
	}

	local grenade_launcher_ammo_override_map = {
		["wpn_fps_gre_arbiter"] = "light",
		["wpn_fps_gre_ms3gl"] = "light",
		["wpn_fps_gre_m32"] = "medium",
		["wpn_fps_gre_china"] = "medium",
		["wpn_fps_gre_m79"] = "heavy",
		["wpn_fps_gre_slap"] = "heavy",
		["wpn_fps_ass_contraband"] = "heavy",
		["wpn_fps_ass_groza"] = "heavy",
	}

	for index, part_id in ipairs(grenade_launcher_ammo_table) do
		if self.parts[part_id].stats then
			self.parts[part_id].stats = grenade_launcher_ammo_overrides[part_id]["default"].stats
		end

		if self.parts[part_id].custom_stats then
			self.parts[part_id].custom_stats = grenade_launcher_ammo_overrides[part_id]["default"].custom_stats
		end
	end

	for index, weapon_id in ipairs(grenade_launcher_table) do
		if not self[weapon_id].override then
			self[weapon_id].override = {}
		end
	end

	for index, weapon_id in ipairs(grenade_launcher_table) do
		for index, ammo_id in ipairs(grenade_launcher_ammo_table) do
			local ammo_override = grenade_launcher_ammo_override_map[weapon_id]

			if ammo_override and grenade_launcher_ammo_overrides[ammo_id] and grenade_launcher_ammo_overrides[ammo_id][ammo_override] then
				self[weapon_id].override[ammo_id] = grenade_launcher_ammo_overrides[ammo_id][ammo_override]
			end
		end
	end

	local piggyback_stats = { value = 1, gadget_zoom = 1 }

	self.parts.wpn_fps_upg_o_specter_piggyback.stats = clone(piggyback_stats)
	self.parts.wpn_fps_upg_o_cs_piggyback.stats = clone(piggyback_stats)
	self.parts.wpn_fps_upg_o_atibal_reddot.stats = clone(piggyback_stats)
	self.parts.wpn_fps_upg_o_hamr_reddot.stats = clone(piggyback_stats)
	self.parts.wpn_fps_upg_o_northtac_reddot.stats = clone(piggyback_stats)
	self.parts.wpn_fps_upg_o_schmidt_magnified.stats = clone(piggyback_stats)
	self.parts.wpn_fps_upg_o_schmidt_magnified.stats.gadget_zoom = 7

	self.parts.wpn_fps_upg_o_mbus_pro.stats.zoom = 0
	self.parts.wpn_fps_upg_o_mbus_pro.stats.recoil = 0
	self.parts.wpn_fps_upg_o_mbus_pro.stats.concealment = 0

	--make all car weapons use the 30 rnd magazine by default

	-- Assault Rifle Mods
	self.parts.wpn_fps_upg_m4_m_straight_vanilla = deep_clone(self.parts.wpn_fps_m4_uupg_m_std)
	self.parts.wpn_fps_upg_m4_m_straight_vanilla.stats = nil
	self.parts.wpn_fps_upg_m4_m_straight_vanilla.pcs = nil

	self.parts.wpn_fps_m4_uupg_m_std = deep_clone(self.parts.wpn_fps_upg_m4_m_straight)
	self.parts.wpn_fps_m4_uupg_m_std.stats.extra_ammo = -5

	-- DMR Mods
	self.parts.wpn_fps_ass_m14_body_ruger.stats.spread = -6
	self.parts.wpn_fps_ass_m14_body_ruger.stats.recoil = -2
	self.parts.wpn_fps_ass_m14_body_ruger.stats.concealment = 8

	-- Pistol mods
	self.parts.wpn_fps_pis_g18c_m_mag_33rnd.stats.extra_ammo = 8

	self.parts.wpn_fps_pis_beretta_m_extended.stats.extra_ammo = 5

	self.parts.wpn_fps_pis_1911_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_1911_b_long.stats.recoil = -2

	self.parts.wpn_fps_pis_1911_m_extended.stats.extra_ammo = 3

	self.parts.wpn_fps_pis_1911_m_big.stats.extra_ammo = 5
	self.parts.wpn_fps_pis_1911_m_big.stats.recoil = 0

	self.parts.wpn_fps_pis_rage_b_comp1.stats.spread = 1
	self.parts.wpn_fps_pis_rage_b_comp1.stats.concealment = -1

	self.parts.wpn_fps_pis_rage_b_comp2.stats.recoil = 1
	self.parts.wpn_fps_pis_rage_b_comp2.stats.concealment = -1

	self.parts.wpn_fps_pis_rage_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_rage_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_rage_b_short.stats.spread = -2
	self.parts.wpn_fps_pis_rage_b_short.stats.concealment = 2

	self.parts.wpn_fps_pis_deagle_m_extended.stats.extra_ammo = 0
	self.parts.wpn_fps_pis_deagle_m_extended.custom_stats = { ammo_offset = 3 }

	self.parts.wpn_fps_pis_usp_b_expert.stats.spread = 1
	self.parts.wpn_fps_pis_usp_b_expert.stats.concealment = -1

	self.parts.wpn_fps_pis_usp_b_match.stats.recoil = 3
	self.parts.wpn_fps_pis_usp_b_match.stats.concealment = -3

	self.parts.wpn_fps_pis_usp_m_extended.stats.extra_ammo = 3

	self.parts.wpn_fps_pis_usp_m_big.stats.extra_ammo = 6
	self.parts.wpn_fps_pis_usp_m_big.stats.recoil = 0

	self.parts.wpn_fps_pis_ppk_b_long.stats.spread = 1
	self.parts.wpn_fps_pis_ppk_b_long.stats.recoil = -1

	self.parts.wpn_fps_pis_p226_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_p226_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_p226_m_extended.stats.extra_ammo = 3

	self.parts.wpn_fps_pis_g22c_b_long.stats.spread = 1
	self.parts.wpn_fps_pis_g22c_b_long.stats.recoil = -1

	self.parts.wpn_fps_pis_c96_s_solid.stats.recoil = 3
	self.parts.wpn_fps_pis_c96_s_solid.stats.concealment = -3

	self.parts.wpn_fps_pis_c96_m_extended.stats.extra_ammo = 5
	
	self.parts.wpn_fps_pis_g26_m_mag_33rnd = deep_clone(self.parts.wpn_fps_pis_g18c_m_mag_33rnd)
	self.parts.wpn_fps_pis_g26_m_mag_33rnd.stats.extra_ammo = 0
	self.parts.wpn_fps_pis_g26_m_mag_33rnd.custom_stats = { ammo_offset = 23 }
		
	self.parts.wpn_fps_pis_g26_m_contour.stats.recoil = 0

	self.parts.wpn_fps_pis_hs2000_sl_custom.stats.spread = -1
	self.parts.wpn_fps_pis_hs2000_sl_custom.stats.concealment = 1

	self.parts.wpn_fps_pis_hs2000_m_extended.stats.extra_ammo = 4

	self.parts.wpn_fps_pis_2006m_b_long.stats.spread = 1
	self.parts.wpn_fps_pis_2006m_b_long.stats.recoil = 0
	self.parts.wpn_fps_pis_2006m_b_long.stats.concealment = -1

	self.parts.wpn_fps_pis_2006m_b_medium.stats.spread = -1
	self.parts.wpn_fps_pis_2006m_b_medium.stats.recoil = 0
	self.parts.wpn_fps_pis_2006m_b_medium.stats.concealment = 1

	self.parts.wpn_fps_pis_2006m_b_short.stats.spread = -2
	self.parts.wpn_fps_pis_2006m_b_short.stats.recoil = 0
	self.parts.wpn_fps_pis_2006m_b_short.stats.concealment = 2

	self.parts.wpn_fps_pis_peacemaker_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_peacemaker_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_peacemaker_b_short.stats.spread = -1
	self.parts.wpn_fps_pis_peacemaker_b_short.stats.concealment = 1

	self.parts.wpn_fps_pis_peacemaker_s_skeletal.stats.recoil = 2
	self.parts.wpn_fps_pis_peacemaker_s_skeletal.stats.concealment = -2

	self.parts.wpn_fps_pis_sparrow_b_comp.stats.spread = 1
	self.parts.wpn_fps_pis_sparrow_b_comp.stats.recoil = 1
	self.parts.wpn_fps_pis_sparrow_b_comp.stats.concealment = -2

	self.parts.wpn_fps_pis_sparrow_b_threaded.stats.spread = 1
	self.parts.wpn_fps_pis_sparrow_b_threaded.stats.recoil = 0
	self.parts.wpn_fps_pis_sparrow_b_threaded.stats.concealment = -1

	self.parts.wpn_fps_pis_pl14_m_extended.stats.extra_ammo = 2

	self.parts.wpn_fps_pis_packrat_m_extended.stats.extra_ammo = 5

	self.parts.wpn_fps_pis_breech_b_reinforced.stats.spread = 0
	self.parts.wpn_fps_pis_breech_b_reinforced.stats.recoil = 1
	self.parts.wpn_fps_pis_breech_b_reinforced.stats.concealment = -1

	self.parts.wpn_fps_pis_breech_b_short.stats.spread = -1
	self.parts.wpn_fps_pis_breech_b_short.stats.concealment = 1

	self.parts.wpn_fps_pis_chinchilla_b_satan.stats.spread = 1
	self.parts.wpn_fps_pis_chinchilla_b_satan.stats.recoil = 1
	self.parts.wpn_fps_pis_chinchilla_b_satan.stats.concealment = -2

	self.parts.wpn_fps_pis_lemming_m_ext.stats.extra_ammo = 5

	self.parts.wpn_fps_pis_shrew_m_extended.stats.extra_ammo = 3

	self.parts.wpn_fps_pis_holt_m_extended.stats.extra_ammo = 5

	self.parts.wpn_fps_pis_beer_b_robo.stats.spread = 4
	self.parts.wpn_fps_pis_beer_b_robo.stats.recoil = -1
	self.parts.wpn_fps_pis_beer_b_robo.stats.concealment = -3

	self.parts.wpn_fps_pis_beer_s_std.stats.recoil = 2
	self.parts.wpn_fps_pis_beer_s_std.stats.concealment = -2

	self.parts.wpn_fps_pis_beer_m_extended.stats.extra_ammo = 0
	self.parts.wpn_fps_pis_beer_m_extended.custom_stats = { ammo_offset = 9 }

	self.parts.wpn_fps_pis_czech_b_long.spread = 2
	self.parts.wpn_fps_pis_czech_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_czech_s_standard.stats.recoil = 2
	self.parts.wpn_fps_pis_czech_s_standard.stats.concealment = -2

	self.parts.wpn_fps_pis_czech_m_extended.stats.extra_ammo = 6

	self.parts.wpn_fps_pis_stech_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_stech_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_stech_s_standard.stats.recoil = 3
	self.parts.wpn_fps_pis_stech_s_standard.stats.concealment = -3

	self.parts.wpn_fps_pis_stech_m_extended.stats.extra_ammo = 5

	self.parts.wpn_fps_pis_model3_b_long.stats.spread = 1
	self.parts.wpn_fps_pis_model3_b_long.stats.recoil = 1
	self.parts.wpn_fps_pis_model3_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_model3_b_short.stats.spread = -1
	self.parts.wpn_fps_pis_model3_b_short.stats.concealment = 1

	self.parts.wpn_fps_pis_m1911_m_extended.stats.extra_ammo = 1

	self.parts.wpn_fps_pis_type54_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_type54_b_long.stats.recoil = 0
	self.parts.wpn_fps_pis_type54_b_long.stats.concealment = -2

	self.parts.wpn_fps_pis_type54_m_ext.stats.extra_ammo = 3

	self.parts.wpn_fps_pis_rsh12_b_short.stats.damage = 0
	self.parts.wpn_fps_pis_rsh12_b_short.stats.spread = 2
	self.parts.wpn_fps_pis_rsh12_b_short.stats.recoil = 1
	self.parts.wpn_fps_pis_rsh12_b_short.stats.concealment = -3

	self.parts.wpn_fps_pis_rsh12_b_short.stats.spread = -2
	self.parts.wpn_fps_pis_rsh12_b_short.stats.recoil = 0
	self.parts.wpn_fps_pis_rsh12_b_short.stats.concealment = 2

	self.parts.wpn_fps_pis_maxim9_b_marksman.stats.spread = 0
	self.parts.wpn_fps_pis_maxim9_b_marksman.stats.recoil = 2
	self.parts.wpn_fps_pis_maxim9_b_marksman.stats.concealment = -2

	self.parts.wpn_fps_pis_maxim9_b_long.stats.spread = 2
	self.parts.wpn_fps_pis_maxim9_b_long.stats.recoil = 1
	self.parts.wpn_fps_pis_maxim9_b_long.stats.concealment = -3

	self.parts.wpn_fps_pis_maxim9_m_ext.stats.extra_ammo = 0
	self.parts.wpn_fps_pis_maxim9_m_ext.custom_stats = { ammo_offset = 9 }

	self.parts.wpn_fps_pis_korth_b_railed.stats.damage = 0
	self.parts.wpn_fps_pis_korth_b_railed.stats.spread = 0
	self.parts.wpn_fps_pis_korth_b_railed.stats.recoil = 0
	self.parts.wpn_fps_pis_korth_b_railed.stats.concealment = 0

	self.parts.wpn_fps_pis_korth_m_6.stats.extra_ammo = -1
	self.parts.wpn_fps_pis_korth_m_6.stats.total_ammo_mod = -5
	self.parts.wpn_fps_pis_korth_m_6.stats.damage = 60
	self.parts.wpn_fps_pis_korth_m_6.stats.spread = 2
	self.parts.wpn_fps_pis_korth_m_6.stats.recoil = -3
	self.parts.wpn_fps_pis_korth_m_6.stats.concealment = 0
	self.parts.wpn_fps_pis_korth_m_6.custom_stats = { ammo_pickup_max_mul = 0.75, ammo_pickup_min_mul = 0.75 }

	-- SMG Mods
	self.parts.wpn_fps_smg_mp5_m_straight.stats.total_ammo_mod = -5
	self.parts.wpn_fps_smg_mp5_m_straight.stats.damage = 10
	self.parts.wpn_fps_smg_mp5_m_straight.stats.concealment = 0
	self.parts.wpn_fps_smg_mp5_m_straight.custom_stats = { ammo_pickup_max_mul = 0.8333333333333333, ammo_pickup_min_mul = 0.8333333333333333 }

	self.parts.wpn_fps_smg_scorpion_m_extended.stats.extra_ammo = 0
	self.parts.wpn_fps_smg_scorpion_m_extended.stats.recoil = 0
	self.parts.wpn_fps_smg_scorpion_m_extended.stats.concealment = -2
	self.parts.wpn_fps_smg_scorpion_m_extended.custom_stats.reload_speed_multiplier = 1.2

	self.parts.wpn_fps_smg_shepheard_mag_extended.unit = "units/pd2_dlc_joy/weapons/wpn_fps_smg_shepheard_pts/wpn_fps_smg_shepheard_mag_standard"
	self.parts.wpn_fps_smg_shepheard_mag_extended.bullet_objects = { amount = 20, prefix = "g_bullet_" }
	self.parts.wpn_fps_smg_shepheard_mag_extended.stats = { value = 1, extra_ammo = -5, concealment = 1, reload = 2 }

	self.parts.wpn_fps_smg_shepheard_mag_standard.unit = "units/pd2_dlc_joy/weapons/wpn_fps_smg_shepheard_pts/wpn_fps_smg_shepheard_mag_extended"
	self.parts.wpn_fps_smg_shepheard_mag_standard.bullet_objects = { amount = 30, prefix = "g_bullet_" }

	-- Shotgun Mods
	self.parts.wpn_fps_sho_saiga_b_short.stats.spread = -2
	self.parts.wpn_fps_sho_saiga_b_short.stats.concealment = 2

	self.parts.wpn_fps_sho_saiga_fg_holy.stats.recoil = -2
	self.parts.wpn_fps_sho_saiga_fg_holy.stats.concealment = 2

	self.parts.wpn_fps_sho_basset_m_extended.stats.extra_ammo = 0
	self.parts.wpn_fps_sho_basset_m_extended.custom_stats = { ammo_offset = 3 }

	self.parts.wpn_fps_sho_aa12_mag_drum.stats.extra_ammo = 6

	self.parts.wpn_fps_shot_r870_body_rack.stats.concealment = -2
	self.parts.wpn_fps_shot_r870_body_rack.custom_stats.reload_speed_multiplier = 1.2


	self.parts.wpn_fps_shot_shorty_m_extended_short.stats.extra_ammo = 0
	self.parts.wpn_fps_shot_shorty_m_extended_short.custom_stats = { ammo_offset = 1 }

	self.parts.wpn_fps_upg_o_dd_rear.stats = {}
	self.parts.wpn_fps_upg_o_mbus_rear.stats = {}

	self.parts.wpn_fps_sho_ksg_b_long.stats.extra_ammo = 1
	self.parts.wpn_fps_sho_ksg_b_long.stats.spread = 2
	self.parts.wpn_fps_sho_ksg_b_long.stats.recoil = 0
	self.parts.wpn_fps_sho_ksg_b_long.stats.concealment = -2

	self.parts.wpn_fps_sho_ksg_b_short.stats.extra_ammo = -1
	self.parts.wpn_fps_sho_ksg_b_short.stats.spread = -2
	self.parts.wpn_fps_sho_ksg_b_short.stats.recoil = 0
	self.parts.wpn_fps_sho_ksg_b_short.stats.concealment = 2

	self.parts.wpn_fps_shot_huntsman_b_short.stats.spread = -4
	self.parts.wpn_fps_shot_huntsman_b_short.stats.recoil = -2
	self.parts.wpn_fps_shot_huntsman_b_short.stats.concealment = 6

	self.parts.wpn_fps_shot_huntsman_s_short.stats.spread = -2
	self.parts.wpn_fps_shot_huntsman_s_short.stats.recoil = -6
	self.parts.wpn_fps_shot_huntsman_s_short.stats.concealment = 6

	self.parts.wpn_fps_shot_b682_b_short.stats.spread = -4
	self.parts.wpn_fps_shot_b682_b_short.stats.recoil = -2
	self.parts.wpn_fps_shot_b682_b_short.stats.concealment = 6

	self.parts.wpn_fps_shot_b682_s_short.stats.spread = -2
	self.parts.wpn_fps_shot_b682_s_short.stats.recoil = -4
	self.parts.wpn_fps_shot_b682_s_short.stats.concealment = 6

	self.parts.wpn_fps_sho_coach_b_short.stats.spread = -4
	self.parts.wpn_fps_sho_coach_b_short.stats.recoil = -2
	self.parts.wpn_fps_sho_coach_b_short.stats.concealment = 6

	self.parts.wpn_fps_sho_coach_s_short.stats.spread = -2
	self.parts.wpn_fps_sho_coach_s_short.stats.recoil = -4
	self.parts.wpn_fps_sho_coach_s_short.stats.concealment = 6

	-- Sniper Rifle Mods
	self.parts.wpn_fps_snp_sbl_b_long.stats.extra_ammo = -1
	self.parts.wpn_fps_snp_sbl_b_long.stats.spread = 2
	self.parts.wpn_fps_snp_sbl_b_long.stats.recoil = 0
	self.parts.wpn_fps_snp_sbl_b_long.stats.concealment = -1

	self.parts.wpn_fps_snp_sbl_b_short.stats.extra_ammo = -1
	self.parts.wpn_fps_snp_sbl_b_short.stats.spread = 0
	self.parts.wpn_fps_snp_sbl_b_short.stats.recoil = 0
	self.parts.wpn_fps_snp_sbl_b_short.stats.concealment = -1

	-- LMG Mods
	self.parts.wpn_fps_upg_bp_lmg_lionbipod.stats.concealment = -1

	self.parts.wpn_fps_lmg_m249_b_long.stats.damage = 0
	self.parts.wpn_fps_lmg_m249_b_long.stats.spread = 1
	self.parts.wpn_fps_lmg_m249_b_long.stats.recoil = 0
	self.parts.wpn_fps_lmg_m249_b_long.stats.concealment = -1

	self.parts.wpn_fps_lmg_hk21_b_long.stats.damage = 0
	self.parts.wpn_fps_lmg_hk21_b_long.stats.spread = 2
	self.parts.wpn_fps_lmg_hk21_b_long.stats.recoil = 0
	self.parts.wpn_fps_lmg_hk21_b_long.stats.concealment = -2

	self.parts.wpn_fps_lmg_hk21_fg_short.stats.spread = -2
	self.parts.wpn_fps_lmg_hk21_fg_short.stats.recoil = -1
	self.parts.wpn_fps_lmg_hk21_fg_short.stats.concealment = 3

	self.parts.wpn_fps_lmg_mg42_b_mg34.stats.damage = 0
	self.parts.wpn_fps_lmg_mg42_b_mg34.stats.spread = 2
	self.parts.wpn_fps_lmg_mg42_b_mg34.stats.recoil = 2
	self.parts.wpn_fps_lmg_mg42_b_mg34.custom_stats = { fire_rate_multiplier = 900 / 1200 }

	self.parts.wpn_fps_lmg_par_m_standard.bullet_objects = {
		amount = 5,
		prefix = "g_bullet_",
	}

	self.parts.wpn_fps_lmg_par_b_short.stats.spread = -2
	self.parts.wpn_fps_lmg_par_b_short.stats.concealment = 2

	self.parts.wpn_fps_ass_tecci_b_long.stats.damage = 0
	self.parts.wpn_fps_ass_tecci_b_long.stats.spread = 2
	self.parts.wpn_fps_ass_tecci_b_long.stats.recoil = 0
	self.parts.wpn_fps_ass_tecci_b_long.stats.concealment = -2

	self.parts.wpn_fps_lmg_m60_b_short.stats.spread = -2
	self.parts.wpn_fps_lmg_m60_b_short.stats.recoil = 0
	self.parts.wpn_fps_lmg_m60_b_short.stats.concealment = 2

	self.parts.wpn_fps_lmg_hk51b_b_fluted.stats.damage = 0
	self.parts.wpn_fps_lmg_hk51b_b_fluted.stats.spread = 2
	self.parts.wpn_fps_lmg_hk51b_b_fluted.stats.recoil = 0
	self.parts.wpn_fps_lmg_hk51b_b_fluted.stats.concealment = -2

	self.parts.wpn_fps_lmg_hk51b_s_extended.stats.recoil = 2
	self.parts.wpn_fps_lmg_hk51b_s_extended.stats.concealment = -2

	self.parts.wpn_fps_lmg_hcar_barrel_short.stats.spread = -2
	self.parts.wpn_fps_lmg_hcar_barrel_short.stats.recoil = 0
	self.parts.wpn_fps_lmg_hcar_barrel_short.stats.concealment = 2

	self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats.extra_ammo = 0
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats.total_ammo_mod = 0
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats.damage = 0
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats.spread = 2
	self.parts.wpn_fps_lmg_hcar_barrel_dmr.stats.concealment = -2

	self.parts.wpn_fps_lmg_hcar_m_stick.stats.extra_ammo = 5

	self.parts.wpn_fps_lmg_hcar_m_drum.stats.extra_ammo = 15
	self.parts.wpn_fps_lmg_hcar_m_drum.stats.spread = 0

	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats.extra_ammo = 15
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats.total_ammo_mod = 13
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats.damage = -30
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats.spread = -4
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats.recoil = 2
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.stats.concealment = 0
	self.parts.wpn_fps_lmg_hcar_body_conversionkit.custom_stats = { fire_rate_multiplier = 1.5, ammo_pickup_min_mul = 3 / 2, ammo_pickup_max_mul = 3 / 2 }

	self.parts.wpn_fps_lmg_kacchainsaw_b_long.stats.damage = 0
	self.parts.wpn_fps_lmg_kacchainsaw_b_long.stats.spread = 2
	self.parts.wpn_fps_lmg_kacchainsaw_b_long.stats.recoil = 0
	self.parts.wpn_fps_lmg_kacchainsaw_b_long.stats.concealment = -2

	self.parts.wpn_fps_lmg_kacchainsaw_mag_b.stats.extra_ammo = -25
	self.parts.wpn_fps_lmg_kacchainsaw_mag_b.stats.recoil = 0

	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.stats.total_ammo_mod = -10
	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.stats.spread = 0
	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.stats.recoil = 0
	self.parts.wpn_fps_lmg_kacchainsaw_flamethrower.stats.concealment = -4

	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats.extra_ammo = 50
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats.total_ammo_mod = 10
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats.damage = -10
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats.spread = -3
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats.recoil = 0
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.stats.concealment = 0
	self.parts.wpn_fps_lmg_kacchainsaw_conversionkit.custom_stats = { fire_rate_multiplier = 1.25, ammo_pickup_min_mul = 4 / 3, ammo_pickup_max_mul = 4 / 3 }

	--Minigun Mods
	self.parts.wpn_fps_lmg_m134_barrel_extreme.stats.spread = 3
	self.parts.wpn_fps_lmg_m134_barrel_extreme.stats.recoil = -1
	self.parts.wpn_fps_lmg_m134_barrel_extreme.stats.concealment = -2

	self.parts.wpn_fps_lmg_m134_barrel_short.stats.spread = -3
	self.parts.wpn_fps_lmg_m134_barrel_short.stats.recoil = -1
	self.parts.wpn_fps_lmg_m134_barrel_short.stats.concealment = 4

	self.parts.wpn_fps_lmg_m134_body_upper_light.stats.total_ammo_mod = -10
	self.parts.wpn_fps_lmg_m134_body_upper_light.stats.spread = 0
	self.parts.wpn_fps_lmg_m134_body_upper_light.stats.recoil = 2
	self.parts.wpn_fps_lmg_m134_body_upper_light.stats.concealment = 2

	self.parts.wpn_fps_lmg_shuno_b_heat_long.stats.spread = 0
	self.parts.wpn_fps_lmg_shuno_b_heat_long.stats.recoil = 1
	self.parts.wpn_fps_lmg_shuno_b_heat_long.stats.concealment = -1

	self.parts.wpn_fps_lmg_shuno_b_heat_short.stats.spread = -1
	self.parts.wpn_fps_lmg_shuno_b_heat_short.stats.recoil = 0
	self.parts.wpn_fps_lmg_shuno_b_heat_short.stats.concealment = 1

	self.parts.wpn_fps_lmg_shuno_b_short.stats.spread = -2
	self.parts.wpn_fps_lmg_shuno_b_short.stats.recoil = 0
	self.parts.wpn_fps_lmg_shuno_b_short.stats.concealment = 2

	self.parts.wpn_fps_hailstorm_b_extended.stats.damage = 0
	self.parts.wpn_fps_hailstorm_b_extended.stats.spread = 1
	self.parts.wpn_fps_hailstorm_b_extended.stats.recoil = 1
	self.parts.wpn_fps_hailstorm_b_extended.stats.concealment = -2

	self.parts.wpn_fps_hailstorm_b_suppressed.stats.damage = -3
	self.parts.wpn_fps_hailstorm_b_suppressed.stats.spread = 0
	self.parts.wpn_fps_hailstorm_b_suppressed.stats.recoil = 0
	self.parts.wpn_fps_hailstorm_b_suppressed.stats.concealment = -2

	self.parts.wpn_fps_hailstorm_b_ext_suppressed.stats.damage = 0
	self.parts.wpn_fps_hailstorm_b_ext_suppressed.stats.spread = 1
	self.parts.wpn_fps_hailstorm_b_ext_suppressed.stats.recoil = 1
	self.parts.wpn_fps_hailstorm_b_ext_suppressed.stats.concealment = -3

	self.parts.wpn_fps_hailstorm_conversion.stats.total_ammo_mod = 0
	self.parts.wpn_fps_hailstorm_conversion.stats.spread = 2
	self.parts.wpn_fps_hailstorm_conversion.stats.recoil = 2
	self.parts.wpn_fps_hailstorm_conversion.stats.concealment = 0
	self.parts.wpn_fps_hailstorm_conversion.custom_stats = { fire_rate_multiplier = 1500 / 2000 }
	
	-- Conversion kits and various barrels, family based modifications --

	local dmr_stance_muls = {
		spread = {
			standing = {
				hipfire = 1.25,
				crouching = 0.75,
				steelsight = 0.5,
			},
			moving = {
				hipfire = 1.5,
				crouching = 1,
				steelsight = 0.875,
			},
		},
		recoil = {
			standing = {
				hipfire = 1.25,
				crouching = 1,
				steelsight = 0.85,
			},
			moving = {
				hipfire = 1.3,
				crouching = 1,
				steelsight = 1,
			},
		},
	}

	local conversion_kit_stats = {
		low_dmr_to_high_dmr = {
			custom_stats = { ammo_pickup_min_mul = 0.75, ammo_pickup_max_mul = 0.75 },
			stats = { value = 1, total_ammo_mod = -5, concealment = -3, spread = 2, recoil = -4, damage = 40 },
		},
		high_dmg = {
			custom_stats = {
				can_shoot_through_enemy = true,
				armor_piercing_add = 1,
				steelsight_speed_mul = 0.75,
				steelsight_move_speed_mul = 0.5,
				ammo_pickup_min_mul = 0.4,
				ammo_pickup_max_mul = 0.4,
				stance_mul = dmr_stance_muls,
			},
			stats = { value = 1, total_ammo_mod = -10, concealment = -6, spread = 4, recoil = -8, damage = 80, suppression = -10, alert_size = 4 },
		},
		low_dmg = {
			custom_stats = {
				can_shoot_through_enemy = true,
				armor_piercing_add = 1,
				steelsight_speed_mul = 0.75,
				steelsight_move_speed_mul = 0.5,
				ammo_pickup_min_mul = 0.4,
				ammo_pickup_max_mul = 0.4,
				stance_mul = dmr_stance_muls,
			},
			stats = { value = 1, total_ammo_mod = -12, concealment = -6, spread = 4, recoil = -11, damage = 60, suppression = -10, alert_size = 4 },
		},
	}

	-- ak family
	self.parts.wpn_fps_upg_ass_ak_b_zastava.custom_stats = conversion_kit_stats.high_dmg.custom_stats
	self.parts.wpn_fps_upg_ass_ak_b_zastava.stats = conversion_kit_stats.high_dmg.stats
	self.parts.wpn_fps_upg_ass_ak_b_zastava.has_description = true
	self.parts.wpn_fps_upg_ass_ak_b_zastava.desc_id = "bm_wp_dmr_kit_penetration_desc"

	self.wpn_fps_ass_74.override.wpn_fps_upg_ass_ak_b_zastava.custom_stats = conversion_kit_stats.low_dmg.custom_stats
	self.wpn_fps_ass_74.override.wpn_fps_upg_ass_ak_b_zastava.stats = conversion_kit_stats.low_dmg.stats

	-- car family
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.custom_stats = conversion_kit_stats.low_dmg.custom_stats
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.stats = conversion_kit_stats.low_dmg.stats
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.has_description = true
	self.parts.wpn_fps_upg_ass_m4_b_beowulf.desc_id = "bm_wp_dmr_kit_penetration_desc"

	self.wpn_fps_ass_m16.override.wpn_fps_upg_ass_m4_b_beowulf.custom_stats = conversion_kit_stats.high_dmg.custom_stats
	self.wpn_fps_ass_m16.override.wpn_fps_upg_ass_m4_b_beowulf.stats = conversion_kit_stats.high_dmg.stats

	-- gewehr
	self.parts.wpn_fps_ass_g3_b_sniper.custom_stats = conversion_kit_stats.low_dmr_to_high_dmr.custom_stats
	self.parts.wpn_fps_ass_g3_b_sniper.stats = conversion_kit_stats.low_dmr_to_high_dmr.stats
	self.parts.wpn_fps_ass_g3_b_sniper.has_description = true
	self.parts.wpn_fps_ass_g3_b_sniper.desc_id = "bm_wp_dmr_kit_penetration_desc"
	self.parts.wpn_fps_ass_g3_b_sniper.adds = {} -- wtf is this, why do you need a separate dummy mod for ammo pickup specifically

	self.parts.wpn_fps_ass_g3_b_short.custom_stats = {}
	self.parts.wpn_fps_ass_g3_b_short.stats = { spread = -2, concealment = 2 }

	-- falcon
	self.parts.wpn_fps_ass_fal_fg_04.custom_stats = conversion_kit_stats.low_dmr_to_high_dmr.custom_stats
	self.parts.wpn_fps_ass_fal_fg_04.stats = conversion_kit_stats.low_dmr_to_high_dmr.stats
	self.parts.wpn_fps_ass_fal_fg_04.has_description = true
	self.parts.wpn_fps_ass_fal_fg_04.desc_id = "bm_wp_dmr_kit_penetration_desc"

	self.parts.wpn_fps_ass_fal_fg_01.stats = { spread = -4, concealment = 4 }
	self.parts.wpn_fps_ass_fal_s_01.stats = { spread = -2, concealment = 2 }

	-- ks12
	self.parts.wpn_fps_ass_shak12_body_vks.custom_stats = conversion_kit_stats.low_dmr_to_high_dmr.custom_stats
	self.parts.wpn_fps_ass_shak12_body_vks.stats = conversion_kit_stats.low_dmr_to_high_dmr.stats
	self.parts.wpn_fps_ass_shak12_body_vks.has_description = true
	self.parts.wpn_fps_ass_shak12_body_vks.desc_id = "bm_wp_dmr_kit_penetration_desc"

	-- broomstick
	self.parts.wpn_fps_pis_c96_b_long.custom_stats = conversion_kit_stats.high_dmg.custom_stats
	self.parts.wpn_fps_pis_c96_b_long.stats = { value = 1, total_ammo_mod = -5, concealment = -6, spread = 2, recoil = -3, damage = 70, suppression = -5, alert_size = 4 }
	self.parts.wpn_fps_pis_c96_b_long.has_description = true
	self.parts.wpn_fps_pis_c96_b_long.desc_id = "bm_wp_dmr_kit_penetration_desc"

	-- Flamethrower Tanks
	-- MK1
	self.parts.wpn_fps_fla_mk2_mag_rare.stats.damage = -10
	self.parts.wpn_fps_fla_mk2_mag_rare.stats.concealment = 3
	self.parts.wpn_fps_fla_mk2_mag_rare.custom_stats = { ammo_pickup_max_mul = 1.65, ammo_pickup_min_mul = 1.25 }
	self.parts.wpn_fps_fla_mk2_mag_rare.desc_id = "bm_wp_upg_mk2_rare_desc"
	self.parts.wpn_fps_fla_mk2_mag_rare.has_description = true

	self.parts.wpn_fps_fla_mk2_mag_welldone.stats.damage = 10
	self.parts.wpn_fps_fla_mk2_mag_welldone.stats.concealment = -3
	self.parts.wpn_fps_fla_mk2_mag_welldone.custom_stats = { ammo_pickup_max_mul = 1, ammo_pickup_min_mul = 0.75 }
	self.parts.wpn_fps_fla_mk2_mag_welldone.desc_id = "bm_wp_upg_mk2_welldone_desc"
	self.parts.wpn_fps_fla_mk2_mag_welldone.has_description = true
	-- MA-17
	self.parts.wpn_fps_fla_system_m_high.stats.damage = 10
	self.parts.wpn_fps_fla_system_m_high.stats.concealment = -3
	self.parts.wpn_fps_fla_system_m_high.custom_stats = { ammo_pickup_max_mul = 1, ammo_pickup_min_mul = 0.75 }
	self.parts.wpn_fps_fla_system_m_high.desc_id = "bm_wp_upg_mk2_welldone_desc"
	self.parts.wpn_fps_fla_system_m_high.has_description = true

	self.parts.wpn_fps_fla_system_m_low.stats.damage = -10
	self.parts.wpn_fps_fla_system_m_low.stats.concealment = 3
	self.parts.wpn_fps_fla_system_m_low.custom_stats = { ammo_pickup_max_mul = 1.65, ammo_pickup_min_mul = 1.25 }
	self.parts.wpn_fps_fla_system_m_low.desc_id = "bm_wp_upg_mk2_rare_desc"
	self.parts.wpn_fps_fla_system_m_low.has_description = true

	-- Barrel Extensions, Silencers --

	-- Generic Extensions and Silencers
	local barrel_ext_stats = {
		balanced = { value = 1, recoil = 1, spread = 1, concealment = -2 },
		spread_favored = { value = 1, spread = 2, concealment = -2 },
		recoil_favored = { value = 1, recoil = 2, concealment = -2 },
		spread_heavily_favored = { value = 1, recoil = -1, spread = 3, concealment = -2 },
		recoil_heavily_favored = { value = 1, recoil = 3, spread = -1, concealment = -2 },
		small_silencer = { value = 1, damage = -5, concealment = -1 },
		medium_silencer = { value = 1, damage = -3, spread = 1, concealment = -2 },
		big_silencer = { value = 1, recoil = 1, spread = 1, concealment = -3 },
		massive_silencer = { value = 1, recoil = 3, spread = 2, concealment = -5 },
	}

	-- Stubby
	self.parts.wpn_fps_upg_ns_ass_smg_stubby.stats = barrel_ext_stats.recoil_favored
	-- Tank
	self.parts.wpn_fps_upg_ns_ass_smg_tank.stats = barrel_ext_stats.spread_favored
	-- Fire Breather
	self.parts.wpn_fps_upg_ns_ass_smg_firepig.stats = barrel_ext_stats.balanced
	-- Competitor's
	self.parts.wpn_fps_upg_ass_ns_jprifles.stats = barrel_ext_stats.recoil_heavily_favored
	-- Bootleg
	self.parts.wpn_fps_ass_tecci_ns_special.stats = barrel_ext_stats.recoil_heavily_favored
	-- Tactical
	self.parts.wpn_fps_upg_ass_ns_surefire.stats = barrel_ext_stats.spread_heavily_favored
	-- Funnel of Fun
	self.parts.wpn_fps_upg_ass_ns_linear.stats = barrel_ext_stats.recoil_favored
	-- Ported
	self.parts.wpn_fps_upg_ass_ns_battle.stats = barrel_ext_stats.spread_favored
	-- Marmon
	self.parts.wpn_fps_upg_ns_ass_smg_v6.stats = barrel_ext_stats.balanced
	-- Verdunkeln
	self.parts.wpn_fps_lmg_hk51b_ns_jcomp.stats = barrel_ext_stats.balanced
	--Taktika
	self.parts.wpn_fps_upg_ak_ns_zenitco.stats = barrel_ext_stats.spread_favored
	--Fyodor
	self.parts.wpn_fps_upg_ak_ns_jmac.stats = barrel_ext_stats.recoil_favored
	-- KS-12 A-Burst
	self.parts.wpn_fps_ass_shak12_ns_muzzle.stats = barrel_ext_stats.recoil_heavily_favored
	-- Dourif
	self.parts.wpn_fps_lmg_kacchainsaw_ns_muzzle.stats = barrel_ext_stats.spread_heavily_favored
	-- Low Profile
	self.parts.wpn_fps_upg_ns_ass_smg_small.stats = barrel_ext_stats.small_silencer
	-- Medium
	self.parts.wpn_fps_upg_ns_ass_smg_medium.stats = barrel_ext_stats.medium_silencer
	-- The Bigger The Better
	self.parts.wpn_fps_upg_ns_ass_smg_large.stats = barrel_ext_stats.big_silencer
	-- PBS
	self.parts.wpn_fps_upg_ns_ass_pbs1.stats = barrel_ext_stats.big_silencer
	-- Rami
	self.parts.wpn_fps_lmg_kacchainsaw_ns_suppressor.stats = barrel_ext_stats.medium_silencer
	-- KS-12 Suppressor (to be restricted from all but ks12)
	self.parts.wpn_fps_ass_shak12_ns_suppressor.stats = barrel_ext_stats.massive_silencer
	-- Federation
	self.parts.wpn_fps_upg_ak_ns_tgp.stats = barrel_ext_stats.medium_silencer

	-- Generic Shotgun Extensions and Silencers
	local shotgun_barrel_ext_stats = {
		medium_loud = { spread = 2, concealment = -2 },
		big_loud = { spread = 3, concealment = -3 },
		horizontal_loud = { spread = -2, recoil = 1, spread_multi = { 2.25, 0.5 }, concealment = -3 },
		medium_silencer = { value = 1, damage = -3, spread = 1, concealment = -2 },
		big_silencer = { value = 1, recoil = 1, spread = 1, concealment = -3 },
	}

	-- Shark Teeth
	self.parts.wpn_fps_upg_ns_shot_shark.stats = shotgun_barrel_ext_stats.medium_loud
	-- King's Crown
	self.parts.wpn_fps_upg_shot_ns_king.stats = shotgun_barrel_ext_stats.big_loud
	-- Donald's Horizontal
	self.parts.wpn_fps_upg_ns_duck.stats = shotgun_barrel_ext_stats.horizontal_loud
	-- Silent Killer
	self.parts.wpn_fps_upg_ns_shot_thick.stats = shotgun_barrel_ext_stats.medium_silencer
	-- Shh
	self.parts.wpn_fps_upg_ns_sho_salvo_large.stats = shotgun_barrel_ext_stats.big_silencer

	-- Generic Pistol Extensions and Silencers
	local pistol_barrel_ext_stats = {
		balanced = { value = 1, recoil = 1, spread = 1, concealment = -2 },
		spread_favored = { value = 1, spread = 2, concealment = -2 },
		recoil_favored = { value = 1, recoil = 2, concealment = -2 },
		small_silencer = { value = 1, damage = -5, concealment = -1 },
		medium_silencer = { value = 1, damage = -3, spread = 1, concealment = -2 },
		big_silencer = { value = 1, recoil = 1, spread = 1, concealment = -3 },
		massive_silencer = { value = 1, recoil = 3, spread = 1, concealment = -4 },
	}

	-- Flash Hider
	self.parts.wpn_fps_upg_pis_ns_flash.stats = pistol_barrel_ext_stats.balanced
	-- IPSC
	self.parts.wpn_fps_upg_ns_pis_ipsccomp.stats = pistol_barrel_ext_stats.spread_favored
	-- Facepunch
	self.parts.wpn_fps_upg_ns_pis_meatgrinder.stats = pistol_barrel_ext_stats.recoil_favored
	-- Hurricane
	self.parts.wpn_fps_upg_ns_pis_typhoon.stats = pistol_barrel_ext_stats.balanced
	-- Standard Issue
	self.parts.wpn_fps_upg_ns_pis_medium.stats = pistol_barrel_ext_stats.medium_silencer
	-- Medved R4
	self.parts.wpn_fps_upg_ns_pis_putnik.stats = pistol_barrel_ext_stats.medium_silencer
	-- Size Doesn't Matter
	self.parts.wpn_fps_upg_ns_pis_small.stats = pistol_barrel_ext_stats.small_silencer
	-- Monolith
	self.parts.wpn_fps_upg_ns_pis_large.stats = pistol_barrel_ext_stats.big_silencer
	-- Asepsis
	self.parts.wpn_fps_upg_ns_pis_medium_slim.stats = pistol_barrel_ext_stats.medium_silencer
	-- Budget
	self.parts.wpn_fps_upg_ns_ass_filter.stats = { value = 1, recoil = -1, spread = -2, concealment = -2, damage = -5 }
	-- Jungle Ninja
	self.parts.wpn_fps_upg_ns_pis_jungle.stats = pistol_barrel_ext_stats.massive_silencer
	-- Roctec
	self.parts.wpn_fps_upg_ns_pis_medium_gem.stats = pistol_barrel_ext_stats.medium_silencer
	-- Champion's
	self.parts.wpn_fps_upg_ns_pis_large_kac.stats = pistol_barrel_ext_stats.big_silencer

	-- set suppression and alert size for all suppressors
	for id, part in pairs(self.parts) do
		local is_silencer = part.perks and table.contains(part.perks, "silencer")

		if part.stats and is_silencer then
			part.stats.suppression = 10
			part.stats.alert_size = -12
		end
	end

	-- Flamethrower mods

	self.parts.wpn_fps_fla_mk2_a_rare = {
		type = "ammo",
		a_obj = "a_body",
		internal_part = true,
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		name_id = "bm_wp_fla_mk2_a_rare",
		pcs = {},
		stats = {
			value = 0,
		},
		custom_stats = {
			bullet_class = "FlameBulletBase",
			dot_data_name = "ammo_flamethrower_mk2_rare",
		},
	}

	self.parts.wpn_fps_fla_mk2_a_welldone = {
		type = "ammo",
		a_obj = "a_body",
		internal_part = true,
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		name_id = "bm_wp_fla_mk2_a_welldone",
		pcs = {},
		stats = {
			value = 0,
		},
		custom_stats = {
			bullet_class = "FlameBulletBase",
			dot_data_name = "ammo_flamethrower_mk2_welldone",
		},
	}

	self.parts.wpn_fps_fla_mk2_mag_rare.stats = { damage = -5 }
	self.parts.wpn_fps_fla_mk2_mag_rare.adds = { "wpn_fps_fla_mk2_a_rare" }
	self.parts.wpn_fps_fla_mk2_mag_rare.custom_stats = {}
	self.parts.wpn_fps_fla_mk2_mag_rare.has_description = true
	self.parts.wpn_fps_fla_mk2_mag_rare.desc_id = "bm_wp_fla_mk2_mag_rare_desc"

	self.parts.wpn_fps_fla_mk2_mag_welldone.stats = { damage = 5 }
	self.parts.wpn_fps_fla_mk2_mag_welldone.adds = { "wpn_fps_fla_mk2_a_welldone" }
	self.parts.wpn_fps_fla_mk2_mag_welldone.custom_stats = {}
	self.parts.wpn_fps_fla_mk2_mag_welldone.has_description = true
	self.parts.wpn_fps_fla_mk2_mag_welldone.desc_id = "bm_wp_fla_mk2_mag_welldone_desc"

	self.parts.wpn_fps_fla_system_b_wtf.stats.total_ammo_mod = 0
	self.parts.wpn_fps_fla_system_b_wtf.stats.concealment = 0

	self.parts.wpn_fps_fla_system_a_low = {
		type = "ammo",
		a_obj = "a_body",
		internal_part = true,
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		name_id = "bm_wp_system_a_low",
		pcs = {},
		stats = {
			value = 0,
		},
		custom_stats = {
			bullet_class = "FlameBulletBase",
			dot_data_name = "ammo_system_low",
		},
	}

	self.parts.wpn_fps_fla_system_a_high = {
		type = "ammo",
		a_obj = "a_body",
		internal_part = true,
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		name_id = "bm_wp_system_a_high",
		pcs = {},
		stats = {
			value = 0,
		},
		custom_stats = {
			bullet_class = "FlameBulletBase",
			dot_data_name = "ammo_system_high",
		},
	}

	self.parts.wpn_fps_fla_system_m_low.stats = { damage = -5 }
	self.parts.wpn_fps_fla_system_m_low.adds = { "wpn_fps_fla_system_a_low" }
	self.parts.wpn_fps_fla_system_m_low.custom_stats = {}
	self.parts.wpn_fps_fla_system_m_low.has_description = true
	self.parts.wpn_fps_fla_system_m_low.desc_id = "bm_wp_fla_mk2_mag_rare_desc"

	self.parts.wpn_fps_fla_system_m_high.stats = { damage = 5 }
	self.parts.wpn_fps_fla_system_m_high.adds = { "wpn_fps_fla_system_a_high" }
	self.parts.wpn_fps_fla_system_m_high.custom_stats = {}
	self.parts.wpn_fps_fla_system_m_high.has_description = true
	self.parts.wpn_fps_fla_system_m_high.desc_id = "bm_wp_fla_mk2_mag_welldone_desc"

	-- misc

	-- let the Amcar use more CAR family mods
	table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_upg_ass_m4_upper_reciever_ballos")
	table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_upg_ass_m4_upper_reciever_core")
	table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_m4_upper_reciever_edge")
	--table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_upg_ass_m4_b_beowulf")
	table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_m4_uupg_b_long")
	table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_upg_m4_s_pts")
	table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_upg_ass_m4_lower_reciever_core")
	--table.insert(self.wpn_fps_ass_amcar.uses_parts, "wpn_fps_smg_olympic_s_short")

	self.parts.wpn_fps_m4_uupg_upper_radian.override.wpn_fps_amcar_uupg_body_upperreciever = {
		unit = "units/payday2/weapons/wpn_fps_ass_m16_pts/wpn_fps_ass_m16_o_handle_sight",
		third_unit = "units/payday2/weapons/wpn_third_ass_m16_pts/wpn_third_ass_m16_o_handle_sight",
		a_obj = "a_o",
	}
	self.parts.wpn_fps_upg_ass_m4_upper_reciever_ballos.override.wpn_fps_amcar_uupg_body_upperreciever = {
		adds = { "wpn_fps_m4_uupg_draghandle_ballos", "wpn_fps_ass_m16_os_frontsight" },
		unit = "units/payday2/weapons/wpn_fps_ass_m16_pts/wpn_fps_ass_m16_o_handle_sight",
		third_unit = "units/payday2/weapons/wpn_third_ass_m16_pts/wpn_third_ass_m16_o_handle_sight",
		a_obj = "a_o",
	}
	self.parts.wpn_fps_upg_ass_m4_upper_reciever_core.override.wpn_fps_amcar_uupg_body_upperreciever = {
		adds = { "wpn_fps_m4_uupg_draghandle_core", "wpn_fps_ass_m16_os_frontsight" },
		unit = "units/payday2/weapons/wpn_fps_ass_m16_pts/wpn_fps_ass_m16_o_handle_sight",
		third_unit = "units/payday2/weapons/wpn_third_ass_m16_pts/wpn_third_ass_m16_o_handle_sight",
		a_obj = "a_o",
	}
	self.parts.wpn_fps_m4_upper_reciever_edge.override.wpn_fps_amcar_uupg_body_upperreciever = {
		adds = { "wpn_fps_m4_uupg_draghandle", "wpn_fps_ass_m16_os_frontsight" },
		unit = "units/payday2/weapons/wpn_fps_ass_m16_pts/wpn_fps_ass_m16_o_handle_sight",
		third_unit = "units/payday2/weapons/wpn_third_ass_m16_pts/wpn_third_ass_m16_o_handle_sight",
		a_obj = "a_o",
	}

	table.delete(self.wpn_fps_pis_g26.uses_parts, "wpn_fps_pis_g18c_m_mag_33rnd")
	table.delete(self.wpn_fps_jowi.uses_parts, "wpn_fps_pis_g18c_m_mag_33rnd")
	table.insert(self.wpn_fps_pis_g26.uses_parts, "wpn_fps_pis_g26_m_mag_33rnd")
	table.insert(self.wpn_fps_jowi.uses_parts, "wpn_fps_pis_g26_m_mag_33rnd")	
	
	table.delete(self.wpn_fps_ass_contraband.uses_parts, "wpn_fps_sho_sko12_body_grip")
	table.delete(self.wpn_fps_ass_m16.uses_parts, "wpn_fps_uupg_fg_radian")

	table.delete(self.wpn_fps_sho_sko12.uses_parts, "wpn_fps_upg_i_singlefire")
	table.delete(self.wpn_fps_sho_sko12.uses_parts, "wpn_fps_upg_i_autofire")

	table.delete(self.wpn_fps_gre_ms3gl.uses_parts, "wpn_fps_gre_ms3gl_conversion")
	table.insert(self.parts.wpn_fps_smg_fmg9_conversion.forbids, "wpn_fps_lmg_hk51b_ns_jcomp")
end)

function WeaponFactoryTweakData:_balance_magazines(tweak_data)
	for id, data in pairs(tweak_data.upgrades.definitions) do
		local weapon_id = data.weapon_id
		local factory_id = data.factory_id

		local akimbo_mappings = tweak_data.weapon:get_akimbo_mappings()
		
		local weapon_tweak = tweak_data.weapon[weapon_id]
		local is_akimbo = weapon_tweak and table.contains(weapon_tweak.categories, "akimbo")
		
		local shotgun_reload = weapon_tweak and weapon_tweak.use_shotgun_reload or weapon_tweak and weapon_tweak.timers and weapon_tweak.timers.shotgun_reload_shell or nil
		local mag_capacity = weapon_tweak and weapon_tweak.CLIP_AMMO_MAX / (is_akimbo and 2 or 1)
		
		for id, part in pairs(self.parts) do
			if self[factory_id] and table.contains(self[factory_id].uses_parts, id) then
				if part.stats then
					local extra_ammo_stat = part.stats.extra_ammo
					local ammo_offset_stat = part.custom_stats and part.custom_stats.ammo_offset
					if extra_ammo_stat or ammo_offset_stat then
						if mag_capacity then
							local reload_speed_stat
							local concealment_stat
							local mod_mag_capacity = (2 * (extra_ammo_stat or 0)) + (ammo_offset_stat or 0)
							local capacity_increase = (mod_mag_capacity / mag_capacity) * 100
							reload_speed_stat = 1 - math.clamp(math.round((capacity_increase / 10) * 0.05, 0.01), -0.25, 0.25)
							concealment_stat = -math.clamp(math.round(capacity_increase / 25), -6, 6)
							
							part.stats.concealment = concealment_stat
							part.custom_stats.reload_speed_multiplier = shotgun_reload and 1 or reload_speed_stat
						end
					end
				end
			end
		end
	end
end

-- Kind of hacky, but it works
Hooks:PostHook(WeaponFactoryTweakData, "_add_charms_to_all_weapons", "eclipse_add_charms_to_all_weapons", function(self, tweak_data)
	self:_balance_magazines(tweak_data)
end)

-- Gun Perks replace stat boosts
function WeaponFactoryTweakData:create_bonuses(tweak_data, weapon_skins)
	self.parts.wpn_fps_upg_perk_template = {
		custom = true,
		exclude_from_challenge = true,
		texture_bundle_folder = "gunperk",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		has_description = true,
		a_obj = "a_body",
		type = "bonus",
		name_id = nil,
		desc_id = nil,
		sub_type = "bonus_stats",
		internal_part = true,
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		pcs = {
			10,
			20,
			30,
			40,
		},
		stats = {},
		custom_stats = {},
		perks = {
			"bonus",
		},
	}

	-- speedloader
	self.parts.wpn_fps_upg_perk_speedloader = deep_clone(self.parts.wpn_fps_upg_perk_template)
	self.parts.wpn_fps_upg_perk_speedloader.name_id = "bm_menu_perk_speedloader"
	self.parts.wpn_fps_upg_perk_speedloader.desc_id = "bm_menu_perk_speedloader_desc"
	self.parts.wpn_fps_upg_perk_speedloader.stats = { reload = 2, total_ammo_mod = -7 }

	-- haste
	self.parts.wpn_fps_upg_perk_haste = deep_clone(self.parts.wpn_fps_upg_perk_template)
	self.parts.wpn_fps_upg_perk_haste.name_id = "bm_menu_perk_haste"
	self.parts.wpn_fps_upg_perk_haste.desc_id = "bm_menu_perk_haste_desc"
	self.parts.wpn_fps_upg_perk_haste.stats = { total_ammo_mod = -3 }
	self.parts.wpn_fps_upg_perk_haste.custom_stats = { movement_speed = 1.1 }

	-- dead silence
	self.parts.wpn_fps_upg_perk_deadsilence = deep_clone(self.parts.wpn_fps_upg_perk_template)
	self.parts.wpn_fps_upg_perk_deadsilence.name_id = "bm_menu_perk_deadsilence"
	self.parts.wpn_fps_upg_perk_deadsilence.desc_id = "bm_menu_perk_deadsilence_desc"
	self.parts.wpn_fps_upg_perk_deadsilence.stats = { concealment = 3, total_ammo_mod = -3, recoil = -1, spread = -1 }

	-- jawbreaker
	self.parts.wpn_fps_upg_perk_jawbreaker = deep_clone(self.parts.wpn_fps_upg_perk_template)
	self.parts.wpn_fps_upg_perk_jawbreaker.name_id = "bm_menu_perk_jawbreaker"
	self.parts.wpn_fps_upg_perk_jawbreaker.desc_id = "bm_menu_perk_jawbreaker_desc"
	self.parts.wpn_fps_upg_perk_jawbreaker.stats = { damage = 15, fire_rate = 0.85 }
	self.parts.wpn_fps_upg_perk_jawbreaker.custom_stats = { ammo_pickup_max_mul = 0.625, fire_rate_multiplier = 0.85 }

	-- whirlwind
	self.parts.wpn_fps_upg_perk_whirlwind = deep_clone(self.parts.wpn_fps_upg_perk_template)
	self.parts.wpn_fps_upg_perk_whirlwind.name_id = "bm_menu_perk_whirlwind"
	self.parts.wpn_fps_upg_perk_whirlwind.desc_id = "bm_menu_perk_whirlwind_desc"
	self.parts.wpn_fps_upg_perk_whirlwind.stats = { recoil = -3, spread = -1, fire_rate = 1.15 }
	self.parts.wpn_fps_upg_perk_whirlwind.custom_stats = { fire_rate_multiplier = 1.15 }

	-- stockpile
	self.parts.wpn_fps_upg_perk_stockpile = deep_clone(self.parts.wpn_fps_upg_perk_template)
	self.parts.wpn_fps_upg_perk_stockpile.name_id = "bm_menu_perk_stockpile"
	self.parts.wpn_fps_upg_perk_stockpile.desc_id = "bm_menu_perk_stockpile_desc"
	self.parts.wpn_fps_upg_perk_stockpile.stats = { total_ammo_mod = 5, reload = -3 }

	local uses_parts = {
		wpn_fps_upg_perk_speedloader = { category = { "assault_rifle", "smg", "snp", "shotgun", "crossbow", "flamethrower", "pistol", "minigun", "akimbo", "lmg", "bow" } },
		wpn_fps_upg_perk_haste = { category = { "assault_rifle", "smg", "snp", "shotgun", "flamethrower", "pistol", "minigun", "akimbo", "lmg", "bow" } },
		wpn_fps_upg_perk_deadsilence = { category = { "assault_rifle", "smg", "snp", "shotgun", "crossbow", "flamethrower", "pistol", "minigun", "akimbo", "lmg" } },
		wpn_fps_upg_perk_jawbreaker = { category = { "assault_rifle", "smg", "snp", "pistol", "minigun", "akimbo", "lmg" } },
		wpn_fps_upg_perk_whirlwind = { category = { "assault_rifle", "smg", "snp", "shotgun", "pistol", "minigun", "akimbo", "lmg" } },
		wpn_fps_upg_perk_stockpile = { category = { "assault_rifle", "smg", "snp", "shotgun", "crossbow", "flamethrower", "pistol", "minigun", "akimbo", "lmg", "bow" } },
		wpn_fps_upg_perk_gunner = { category = { "lmg" } },
	}
	local all_pass, weapon_pass, exclude_weapon_pass, category_pass, exclude_category_pass = nil

	for id, data in pairs(tweak_data.upgrades.definitions) do
		local weapon_tweak = tweak_data.weapon[data.weapon_id]
		local primary_category = weapon_tweak and weapon_tweak.categories and weapon_tweak.categories[1]

		if data.weapon_id and weapon_tweak and data.factory_id and self[data.factory_id] then
			for part_id, params in pairs(uses_parts) do
				weapon_pass = not params.weapon or table.contains(params.weapon, data.weapon_id)
				exclude_weapon_pass = not params.exclude_weapon or not table.contains(params.exclude_weapon, data.weapon_id)
				category_pass = not params.category or table.contains(params.category, primary_category)
				exclude_category_pass = not params.exclude_category or not table.contains(params.exclude_category, primary_category)
				all_pass = weapon_pass and exclude_weapon_pass and category_pass and exclude_category_pass

				if all_pass then
					table.insert(self[data.factory_id].uses_parts, part_id)
					table.insert(self[data.factory_id .. "_npc"].uses_parts, part_id)
				end
			end
		end
	end
end

-- Amazing implementation of the Sting Grenade ammunition type by Starbreeze
function WeaponFactoryTweakData:_init_hornet_grenade()
	local hornet_unit_folder = "units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/"
	self.parts.wpn_fps_upg_a_grenade_launcher_hornet = {
		is_a_unlockable = true,
		texture_bundle_folder = "pxp3",
		type = "ammo",
		a_obj = "a_body",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		internal_part = true,
		muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
		sub_type = "ammo_hornet",
		name_id = "bm_wp_upg_a_grenade_launcher_hornet",
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		pcs = {},
		stats = {
			value = 4,
		},
		custom_stats = {
			ammo_pickup_min_mul = 2,
			ammo_pickup_max_mul = 2,
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
		},
		override = {
			wpn_fps_gre_m32_mag = {
				unit = "units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_m32_mag_hornet",
				material_config = Idstring("units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_m32_mag_hornet"),
			},
			wpn_fps_gre_m79_grenade = {
				unit = "units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_hornet",
				material_config = Idstring("units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_hornet"),
			},
			wpn_fps_gre_m79_grenade_whole = {
				unit = "units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_hornet",
				material_config = Idstring("units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_hornet"),
			},
			wpn_fps_gre_ms3gl_grenade = {
				unit = "units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_hornet",
				material_config = Idstring("units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_gre_hornet"),
			},
		},
	}
	self.parts.wpn_fps_upg_a_underbarrel_hornet = {
		is_a_unlockable = true,
		texture_bundle_folder = "pxp3",
		third_unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		a_obj = "a_body",
		type = "underbarrel_ammo",
		internal_part = true,
		muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
		sub_type = "ammo_hornet",
		name_id = "bm_wp_upg_a_grenade_launcher_hornet",
		unit = "units/payday2/weapons/wpn_upg_dummy/wpn_upg_dummy",
		pcs = {},
		stats = {
			value = 2,
		},
		custom_stats = {
			ammo_pickup_min_mul = 1.5,
			ammo_pickup_max_mul = 1.5,
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
		},
		override = {
			wpn_fps_ass_groza_gl_gp25 = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				model = Idstring("units/pd2_dlc_pxp3/weapons/wpn_fps_grenade_launcher_hornet/wpn_fps_ass_groza_gl_gp25_hornet"),
				unit = hornet_unit_folder .. "wpn_fps_ass_groza_gl_gp25_hornet",
			},
			wpn_fps_ass_contraband_gl_m203 = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				unit = hornet_unit_folder .. "wpn_fps_ass_contraband_gl_m203_hornet",
			},
		},
	}

	local sting_stats = {
		light = {
			damage = -90,
			spread = -12,
		},
		medium = {
			damage = -111,
			spread = -12,
		},
		heavy = {
			damage = -132,
			spread = -12,
		},
	}

	local shotgun_stance_muls = {
		spread = {
			standing = {
				hipfire = 1,
				crouching = 1,
				steelsight = 0.75,
			},
			moving = {
				hipfire = 1.25,
				crouching = 1,
				steelsight = 1,
			},
		},
		recoil = {
			standing = {
				hipfire = 1.25,
				crouching = 1,
				steelsight = 1,
			},
			moving = {
				hipfire = 1.5,
				crouching = 1,
				steelsight = 1,
			},
		},
	}

	local grenade_launchers = {
		wpn_fps_gre_arbiter = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.light,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
		wpn_fps_gre_ms3gl = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.light,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
		wpn_fps_gre_m32 = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.medium,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
		wpn_fps_gre_china = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.medium,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
		wpn_fps_gre_m79 = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.heavy,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
		wpn_fps_gre_slap = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.heavy,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
	}
	local grenade_underbarrels = {
		wpn_fps_ass_groza = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.heavy,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
		wpn_fps_ass_contraband = {
			muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
			stats = sting_stats.heavy,
			custom_stats = {
				muzzleflash = "effects/payday2/particles/weapons/shotgun/sho_muzzleflash_hornet",
				armor_piercing_add = 1,
				can_shoot_through_shield = true,
				can_shoot_through_enemy = true,
				ignore_damage_upgrades = false,
				stance_mul = shotgun_stance_muls,
				sounds = {
					fire_single = "hornet_fire",
				},
			},
		},
	}
	local launcher_value = self.parts.wpn_fps_upg_a_grenade_launcher_hornet.stats.value
	local launcher_pickup_min = self.parts.wpn_fps_upg_a_grenade_launcher_hornet.custom_stats.ammo_pickup_min_mul
	local launcher_pickup_max = self.parts.wpn_fps_upg_a_grenade_launcher_hornet.custom_stats.ammo_pickup_max_mul
	local fps_data, npc_data, hornet_override = nil

	for factory_id, override in pairs(grenade_launchers) do
		fps_data = self[factory_id]
		npc_data = self[factory_id .. "_npc"]

		if fps_data and npc_data and fps_data.uses_parts and npc_data.uses_parts then
			table.insert(fps_data.uses_parts, "wpn_fps_upg_a_grenade_launcher_hornet")
			table.insert(npc_data.uses_parts, "wpn_fps_upg_a_grenade_launcher_hornet")

			hornet_override = override
			hornet_override.stats.value = launcher_value
			hornet_override.custom_stats.weapon_unit = hornet_unit_folder .. factory_id
			hornet_override.custom_stats.ammo_pickup_min_mul = launcher_pickup_min
			hornet_override.custom_stats.ammo_pickup_max_mul = launcher_pickup_max
			fps_data.override = fps_data.override or {}
			fps_data.override.wpn_fps_upg_a_grenade_launcher_hornet = hornet_override
			npc_data.override = npc_data.override or {}
			npc_data.override.wpn_fps_upg_a_grenade_launcher_hornet = hornet_override
		end
	end

	local underbarrel_launcher_pickup_min = self.parts.wpn_fps_upg_a_underbarrel_hornet.custom_stats.ammo_pickup_min_mul
	local underbarrel_launcher_pickup_max = self.parts.wpn_fps_upg_a_underbarrel_hornet.custom_stats.ammo_pickup_max_mul

	for factory_id, override in pairs(grenade_underbarrels) do
		fps_data = self[factory_id]
		npc_data = self[factory_id .. "_npc"]

		if fps_data and npc_data and fps_data.uses_parts and npc_data.uses_parts then
			table.insert(fps_data.uses_parts, "wpn_fps_upg_a_underbarrel_hornet")
			table.insert(npc_data.uses_parts, "wpn_fps_upg_a_underbarrel_hornet")

			hornet_override = override
			hornet_override.custom_stats.base_stats_modifiers = hornet_override.stats
			hornet_override.custom_stats.ammo_pickup_min_mul = underbarrel_launcher_pickup_min
			hornet_override.custom_stats.ammo_pickup_max_mul = underbarrel_launcher_pickup_max
			hornet_override.stats = nil
			fps_data.override = fps_data.override or {}
			fps_data.override.wpn_fps_upg_a_underbarrel_hornet = hornet_override
			npc_data.override = npc_data.override or {}
			npc_data.override.wpn_fps_upg_a_underbarrel_hornet = hornet_override
		end
	end
end
