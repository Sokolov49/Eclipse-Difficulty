--original tweakdata had to go, for now

local data = UpgradesTweakData.init
function UpgradesTweakData:init(tweak_data)
	data(self, tweak_data)
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	
	--moved all special weapons to be unlocked at level 80
	--players will have to utilize other methods of taking out cops
	--instead of being attached to an easily-replenishable grenade source
	self.level_tree = {
		[0] = {
			upgrades = {
				"frag_com",
				"frag",
				"wpn_dallas_mask",
				"msr",
				"corgi",
				"clean",
				"aziz"
			}
		},
		{
			name_id = "body_armor",
			upgrades = {
				"body_armor2",
				"ak74",
				"nin"
			}
		},
		{
			name_id = "weapons",
			upgrades = {
				"colt_1911",
				"mac10",
				"hajk",
				"spoon",
				"x_hajk",
				"x_mac10"
			}
		},
		{
			name_id = "weapons",
			upgrades = {
				"spatula",
				"fork",
				"boot"
			}
		},
		{
			name_id = "weapons",
			upgrades = {
				"new_m4",
				"shovel"
			}
		},
		[6] = {
			name_id = "weapons",
			upgrades = {
				"new_raging_bull",
				"b92fs",
				"x_rage",
				"m1911",
				"vityaz"
			}
		},
		[7] = {
			name_id = "body_armor",
			upgrades = {
				"body_armor1",
				"moneybundle"
			}
		},
		[8] = {
			name_id = "weapons",
			upgrades = {
				"r870",
				"aug",
				"fight"
			}
		},
		[10] = {
			name_id = "lvl_10",
			upgrades = {
				"rep_upgrade1",
				"cutters",
				"shawn"
			}
		},
		[12] = {
			name_id = "body_armor3",
			upgrades = {
				"body_armor1", 
				"body_armor2",
				"cobray",
				"boxcutter",
				"x_cobray",
				"m590",
				"maxim9",
				"groza"
			}
		},
		[13] = {
			name_id = "weapons",
			upgrades = {
				"new_mp5",
				"serbu",
				"microphone",
				"selfie",
				"sko12"
			}
		},
		[14] = {
			name_id = "weapons",
			upgrades = {
				"bayonet",
				"m1928",
				"sparrow",
				"gator",
				"pl14",
				"x_m1928",
				"x_sparrow",
				"x_pl14"
			}
		},
		[15] = {
			name_id = "weapons",
			upgrades = {
				"benelli",
				"sub2000",
				"road",
				"legacy",
				"x_legacy",
				"fmg9"
			}
		},
		[16] = {
			name_id = "weapons",
			upgrades = {
				"akm",
				"g36",
				"iceaxe",
				"zeus",
				"flint",
				"oxide",
				"sword"
			}
		},
		[17] = {
			name_id = "weapons",
			upgrades = {
				"akm_gold",
				"baton",
				"slot_lever",
				"chac",
				"pm9",
				"x_pm9"
			}
		},
		[18] = {
			name_id = "weapons",
			upgrades = {
				"baseballbat",
				"scorpion",
				"oldbaton",
				"hockey",
				"meter",
				"hauteur",
				"shock",
				"fear",
				"x_scorpion"
			}
		},
		[19] = {
			name_id = "weapons",
			upgrades = {
				"olympic",
				"mp9",
				"baka",
				"pugio",
				"ballistic",
				"x_baka",
				"x_olympic",
				"x_mp9",
				"maxim9",
				"scout",
				"korth"
			}
		},
		[20] = {
			name_id = "lvl_20",
			upgrades = {
				"rep_upgrade2",
				"schakal",
				"agave",
				"happy",
				"shepheard",
				"x_shepheard",
				"x_schakal"
			}
		},
		[21] = {
			name_id = "body_armor4",
			upgrades = {
				"body_armor3",
				"kampfmesser",
				"buck",
				"tecci",
				"wing"
			}
		},
		[22] = {
			name_id = "community_item",
			upgrades = {
				"smoke_screen_grenade",
				"g22c",
				"ksg",
				"branding_iron",
				"detector",
				"croupier_rake"
			}
		},
		[23] = {
			name_id = "weapons",
			upgrades = {
				"bullseye",
				"c96",
				"par",
				"m37",
				"rota",
				"x_rota",
				"x_c96",
				"cs",
				"brick",
				"ostry",
				"r700"
			}
		},
		[24] = {
			name_id = "weapons",
			upgrades = {
				"model24",
				"l85a2",
				"scalper",
				"switchblade",
				"x_m1911",
				"x_vityaz",
				"x_maxim9",
				"type54",
				"x_type54",
				"x_sko12"
			}
		},
		[25] = {
			name_id = "weapons",
			upgrades = {
				"boxing_gloves",
				"meat_cleaver",
				"wpn_prj_four",
				"sr2",
				"grip",
				"push",
				"breech",
				"ching",
				"erma",
				"x_breech",
				"x_erma",
				"concussion",
				"fir_com",
				"dada_com",
				"dynamite",
				"molotov",
				"sap"
			}
		},
		[26] = {
			name_id = "weapons",
			upgrades = {
				"new_m14",
				"saiga",
				"sandsteel",
				"packrat",
				"lemming",
				"rsh12",
				"chinchilla",
				"x_chinchilla",
				"model3",
				"sbl",
				"m1897",
				"x_model3"
			}
		},
		[27] = {
			name_id = "weapons",
			upgrades = {
				"famas",
				"g26",
				"twins",
				"pitchfork",
				"shrew",
				"x_shrew",
				"basset",
				"x_basset"
			}
		},
		[28] = {
			name_id = "weapons",
			upgrades = {
				"hs2000",
				"vhs",
				"bowie",
				"micstand",
				"x_hs2000",
				"qbu88",
				"contender",
				"awp"
			}
		},
		[29] = {
			name_id = "weapons",
			upgrades = {
				"akmsu",
				"glock_18c",
				"asval",
				"x_g18c",
				"x_beer",
				"beer",
				"x_czech",
				"czech",
				"x_stech",
				"stech",
				"supernova"
			}
		},
		[30] = {
			name_id = "lvl_30",
			upgrades = {
				"rep_upgrade3",
				"holt",
				"x_holt",
				"x_korth"
			}
		},
		[31] = {
			name_id = "body_armor5",
			upgrades = {
				"body_armor4",
				"chef",
				"peacemaker",
				"wpn_prj_ace"
			}
		},
		[32] = {
			name_id = "weapons",
			upgrades = {
				"x46",
				"tec9",
				"tiger",
				"model70",
				"x_tec9"
			}
		},
		[33] = {
			name_id = "weapons",
			upgrades = {
				"ak5",
				"striker",
				"wa2000",
				"beardy",
				"catch",
				"elastic",
				"m60"
			}
		},
		[34] = {
			name_id = "weapons",
			upgrades = {
				"galil",
				"cleaver",
				"mateba",
				"taser",
				"desertfox",
				"wpn_prj_target",
				"tti",
				"victor",
				"ultima",
				"x_2006m"
			}
		},
		[35] = {
			name_id = "weapons",
			upgrades = {
				"r93",
				"judge",
				"mining_pick",
				"wing",
				"x_judge"
			}
		},
		[36] = {
			name_id = "weapons",
			upgrades = {
				"p90",
				"deagle",
				"winchester1874",
				"x_p90"
			}
		},
		[37] = {
			name_id = "weapons",
			upgrades = {
				"shillelagh",
				"hammer",
				"stick"
			}
		},
		[38] = {
			name_id = "weapons",
			upgrades = {
				"scoutknife",
				"komodo",
				"hk51b"
			}
		},
		[39] = {
			name_id = "weapons",
			upgrades = {
				"m16",
				"huntsman",
				"polymer",
				"x_polymer"
			}
		},
		[40] = {
			name_id = "lvl_40",
			upgrades = {
				"rep_upgrade4",
				"shak12"
			}
		},
		[41] = {
			name_id = "weapons",
			upgrades = {
				"body_armor5",
				"gerber",
				"fairbair",
				"wpn_prj_jav",
				"wpn_prj_hur",
				"contraband"
			}
		},
		[42] = {
			name_id = "weapons",
			upgrades = {
				"fal",
				"tomahawk",
				"coal",
				"x_coal",
				"kacchainsaw"
			}
		},
		[43] = {
			name_id = "weapons",
			upgrades = {
				"b682",
				"morning",
				"coach"
			}
		},
		[44] = {
			name_id = "weapons",
			upgrades = {
				"poker"
			}
		},
		[45] = {
			name_id = "weapons",
			upgrades = {
				"m249",
				"barbedwire"
			}
		},
		[46] = {
			name_id = "weapons",
			upgrades = {
				"great",
				"siltstone"
			}
		},
		[47] = {
			name_id = "weapons",
			upgrades = {
				"freedom",
				"whiskey"
			}
		},
		[48] = {
			name_id = "weapons",
			upgrades = {
				"dingdong",
				"tenderizer",
				"hcar"
			}
		},
		[50] = {
			name_id = "lvl_50",
			upgrades = {
				"rep_upgrade5",
				"tkb"
			}
		},
		[51] = {
			name_id = "weapons",
			upgrades = {
				"machete",
				"sterling",
				"x_sterling"
			}
		},
		[52] = {
			name_id = "weapons",
			upgrades = {
				"g3",
				"aa12"
			}
		},
		[54] = {
			name_id = "weapons",
			upgrades = {
				"becker",
				"mosin",
				"cqc"
			}
		},
		[55] = {
			name_id = "weapons",
			upgrades = {
				"uzi",
				"x_uzi"
			}
		},
		[60] = {
			name_id = "lvl_60",
			upgrades = {
				"rep_upgrade6"
			}
		},
		[61] = {
			name_id = "weapons",
			upgrades = {
				"rambo"
			}
		},
		[65] = {
			name_id = "weapons",
			upgrades = {
				"m95"
			}
		},
		[70] = {
			name_id = "lvl_70",
			upgrades = {
				"rep_upgrade7"
			}
		},
		[71] = {
			name_id = "weapons",
			upgrades = {
				"fireaxe",
				"mg42"
			}
		},
		[75] = {
			name_id = "weapons",
			upgrades = {
				"hk21"
			}
		},
		[80] = {
			name_id = "lvl_80",
			upgrades = {
				"rep_upgrade8",
				"long",
				"flamethrower_mk2",
				"ecp",
				"gre_m79",
				"system",
				"m134",
				"rpg7",
				"frankish",
				"m32",
				"shuno",
				"plainsrider",
				"hailstorm",
				"arblast",
				"arbiter",
				"china",
				"ray",
				"slap",
				"hunter",
				"ms3gl"
			}
		},
		[90] = {
			name_id = "lvl_90",
			upgrades = {
				"rep_upgrade9"
			}
		},
		[100] = {
			name_id = "lvl_100",
			upgrades = {
				"rep_upgrade10"
			}
		}
	}
	
	

	self.values.player.unlock_unlock_op_weapons = {true}
	self.definitions.player_unlock_op_weapons = {
		category = "feature",
		name_id = "menu_player_unlock_op_weapons",
		upgrade = {
			category = "player",
			upgrade = "unlock_op_weapons",
			value = 1
		}
	}
	self.values.player.unlock_akimbo_pistols = {true}
	self.definitions.player_unlock_akimbo_pistols = {
		category = "feature",
		name_id = "menu_player_unlock_akimbo_pistols",
		upgrade = {
			category = "player",
			upgrade = "unlock_akimbo_pistols",
			value = 1
		}
	}
	self.values.player.unlock_akimbo_shotguns = {true}
	self.definitions.player_unlock_akimbo_shotguns = {
		category = "feature",
		name_id = "menu_player_unlock_akimbo_shotguns",
		upgrade = {
			category = "player",
			upgrade = "unlock_akimbo_shotguns",
			value = 1
		}
	}
	self.values.player.unlock_akimbo_smg = {true}
	self.definitions.player_unlock_akimbo_smg = {
		category = "feature",
		name_id = "menu_player_unlock_akimbo_smg",
		upgrade = {
			category = "player",
			upgrade = "unlock_akimbo_smg",
			value = 1
		}
	}
	
	self.values.weapon.automatic_head_shot_add = {0.15, 0.3}
	self.values.player.reduce_loose_money_exp_convertation_amount_mul = {0.35}
	self.values.team.xp.multiplier = {1.4}
	self.values.player.walking_bleedout_doctor_bag_self_revive = {true}
	self.values.player.walking_bleedout_ticks_to_ressurection = {90, 60}
	self.walking_bleedout_time_to_fatal_state = 5
	self.walking_bleedout_interaction_time_penalty = 0.4
	self.walking_bleedout_walk_speed_penalty = 0.4
	self.walking_bleedout_reload_speed_penalty = 1.45
	self.walking_bleedout_post_reload_speed_penalty = 0.25
	self.values.player.walking_bleedout_time_to_bleed = {20, 15}
	self.values.player.walking_bleedout_chance = {0.45, 0.75}
	self.values.player.walking_bleedout_temporary_health_mul = {0.4, 0.6, 0.8}
	self.values.player.walking_bleedout_fak_self_revive = {0.15}
	self.values.player.walking_bleedout_fak_self_revive_additional = {0.15}

	self.values.temporary.dmg_dampener_outnumbered_strong = {{0.85, 7}}
	self.values.player.revived_health_regain_solid_amount = {0.4, 0.7}
	self.values.player.revived_health_regain_solid_wolverine = {0.15}
	self.values.player.damage_shake_addend = {1.5}
	self.values.player.camouflage_bonus = {0.65}
	self.values.player.fugitive_tier_health_multiplier = {1.2}
	self.values.player.guards_cant_spot_you_in_casing = {10}
	self.values.player.secondary_silencer_damage_addend = {0.5}
	
	self.values.player.passive_always_regen_armor = {2.25}
	
	self.values.player.single_shot_fire_rate_mul = {0.25}
	self.values.player.recoil_not_moving_mul = {0.8}
	self.values.player.recoil_not_moving_aim_mul = {0.85}

	self.values.player.passive_crafting_weapon_multiplier = {0.75, 0.5, 0.25}
	self.values.player.passive_crafting_mask_multiplier = {0.75, 0.5, 0.25}
	self.values.saw.enemy_slicer = {2}
	self.values.saw.consume_no_ammo_chance = {0.35}
	self.values.player.shotgun_steelsight_shield_knock = {0.85}
	self.values.player.shotgun_shield_knock = {0.45}
	self.values.shotgun.hip_rate_of_fire = {1.5}
	self.values.shotgun.enter_steelsight_speed_multiplier = {1.75}
	self.values.ammo_bag.interaction_speed_multiplier = {0.9, 0.8}
	self.values.doctor_bag.deploy_time_multiplier = {0.65}
	self.values.doctor_bag.interaction_speed_multiplier = {0.8, 0.7}
	self.values.doctor_bag.deploy_time_multiplier = {0.65}
	self.values.player.cable_tie_pickup = {true}
	
	if difficulty_index <= 3 then
		self.values.player.convert_enemies_health_multiplier = {0.3}
		self.values.team.damage = {
			hostage_absorption = {0.05},
			hostage_absorption_limit = 8
		}
	elseif difficulty_index <= 5 then
		self.values.player.convert_enemies_health_multiplier = {0.2}
		self.values.team.damage = {
			hostage_absorption = {0.1},
			hostage_absorption_limit = 8
		}
	else
		self.values.player.convert_enemies_health_multiplier = {0.05}
		self.values.team.damage = {
			hostage_absorption = {0.2},
			hostage_absorption_limit = 8
		}
	end
	
	self.values.player.convert_enemies_damage_multiplier = {1.45}

	self.values.player.pocket_ecm_jammer_base.cooldown_drain = 8
	self.values.player.pocket_ecm_jammer_base.duration = 8
	self.values.temporary.chico_injector = {{0.8, 8}}

	self.values.team.health.passive_multiplier = {1.15}
	self.values.player.passive_xp_multiplier = {1.10}	
	self.values.team.stamina.multiplier = {2.5}
	self.values.player.uncover_multiplier = {1.35}
	self.values.weapon.clip_ammo_increase = {10}
	
	self.values.weapon.silencer_damage_multiplier = {1.15, 1.35}
	self.values.player.melee_kill_snatch_pager_chance = {0.07}
	self.values.player.armor_regen_timer_stand_still_multiplier = {0.85}
	self.values.saw.reload_speed_multiplier = {1.15}
	
	self.values.player.mask_off_pick_lock = {true}
	self.values.player.mask_off_keycard_insert = {true}
	self.values.player.mask_off_desktop_interaction = {true}
	self.values.player.hostage_interaction_speed_multiplier = {0.25}
	self.values.player.alarm_pager_speed_multiplier = {0.80}

	self.values.player.intimidate_guards_pager = {true}
	self.values.player.instant_intimidation = {true}
	self.values.player.civs_show_markers = {true}

	-- LMG / Minigun movement penalties revert
	self.weapon_movement_penalty.lmg = 0.8
	self.weapon_movement_penalty.minigun = 0.75
	self.weapon_movement_penalty.heavy = 0.75
	
	self.values.player.body_armor.dodge = {0.1, 0.05, 0.03, -0.03, -0.1, -0.3, -0.5}
	self.values.player.body_armor.armor = {0, 1, 2, 3, 5, 7, 16}
	
	-- Movement speed nerfs
	self.values.player.body_armor.movement = {
		0.85,
		0.825,
		0.75,
		0.7,
		0.625,
		0.575,
		0.5,
	}
	self.values.player.body_armor.stamina = {
		0.85,
		0.825,
		0.8,
		0.75,
		0.7,
		0.6,
		0.5,
	}

	-- steadiness
	self.values.player.body_armor.damage_shake = {
		1,
		0.96,
		0.92,
		0.85,
		0.8,
		0.7,
		0.5
	}
	
	-- movement tagging
	self.values.player.body_armor.damage_tagged = {
		0.8,
		0.85,
		0.9,
		0.95,
		1,
		1.05,
		1.1,
	}

	-- regen timer
	self.values.player.body_armor.regen_timer = {
		3,
		3.33,
		3.66,
		4,
		4.5,
		5,
		5.5,
	}

	self.values.player.passive_dodge_chance = {0.05, 0.15}
	self.values.player.passive_concealment_modifier = {5}
	self.values.weapon.passive_swap_speed_multiplier = {1.2, 2}
	self.values.weapon.armor_piercing_chance = {0.15}
	self.values.player.tier_armor_multiplier = {
		1.1,
		1.25,
		1.5
	}
	self.values.player.passive_health_multiplier = {
		1.1,
		1.2,
		1.5
	}

	self.values.temporary.combat_medic_damage_multiplier = {
		{1.25, 10},
		{1.25, 15}
	}
	self.values.assault_rifle.reload_speed_multiplier = {1.25}
	self.values.assault_rifle.move_spread_multiplier = {0.5}
	self.values.snp.reload_speed_multiplier = {1.25}
	self.values.snp.move_spread_multiplier = {0.5}
	self.values.pistol.damage_addend = {1.5}
	self.values.akimbo.damage_addend = {0.75}
	self.values.player.minion_master_health_multiplier = {1.2}
	self.values.player.messiah_revive_from_bleed_out = {1, 3}
	self.values.cooldown.long_dis_revive = {{0.75, 1}}
	self.values.team.weapon.recoil_multiplier = {0.95}
	self.values.team.pistol.recoil_multiplier= {0.9}
	self.values.team.akimbo.recoil_multiplier= {0.9}
	
	self.values.player.suppression_multiplier = {1.25, 1.75}
	self.values.temporary.dmg_dampener_outnumbered = {{0.85, 7}}
	self.values.player.non_special_melee_multiplier = {1.5}
	self.values.player.melee_damage_multiplier = {1.5}
	self.values.player.increased_pickup_area = {1.30}
	self.values.shotgun.damage_multiplier = {1.35}
	self.values.player.flashbang_multiplier = {0.75, 0.25}
	self.values.player.damage_shake_multiplier = {0.5}
	self.values.player.bleed_out_health_multiplier = {2}
	self.values.shotgun.reload_speed_multiplier = {1.5}
	self.player_damage_health_ratio_threshold = 0.25
	self.values.shotgun.hip_fire_spread_index_addend = {0.6}
	self.values.temporary.overkill_damage_multiplier = {
		{1.75, 5},
		{1.75, 10}
	}
	
	-- Fire Control
	self.definitions.minigun_spray_recoil_multiplier = {
		name_id = "menu_minigun_spray_recoil_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "spray_recoil_multiplier",
			category = "minigun",
		},
	}
	self.values.minigun.spray_recoil_multiplier = {
		0.005,
	}
	self.definitions.lmg_spray_recoil_multiplier = {
		name_id = "menu_lmg_spray_recoil_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "spray_recoil_multiplier",
			category = "lmg",
		},
	}
	self.values.lmg.spray_recoil_multiplier = {
		0.01,
	}
	self.definitions.smg_spray_recoil_multiplier = {
		name_id = "menu_smg_spray_recoil_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "spray_recoil_multiplier",
			category = "smg",
		},
	}
	self.values.smg.spray_recoil_multiplier = {
		0.015,
	}
	self.max_spray_recoil_reduction = 0.5
	self.values.player.drill_autorepair_1 = {0.3}
	self.values.sentry_gun.extra_ammo_multiplier = {1.5, 2.5}
	self.values.sentry_gun.rot_speed_multiplier = {2.5}
	self.values.trip_mine.fire_trap = {{ 0, 1 }, { 25, 1.5 }} --duration, range
	self.values.trip_mine.quantity = {1, 4} --check this later
	self.values.player.deploy_interact_faster = {0.85}
	self.values.shape_charge.quantity = {0, 0}
	self.values.sentry_gun.spread_multiplier = {0.5}
	self.values.sentry_gun.damage_multiplier = {4}
	self.values.temporary.single_shot_fast_reload = {{1.2, 4}}
	self.values.player.critical_hit_chance = {0.30}
	self.values.player.armor_multiplier = {1.5}

	self.values.player.run_speed_multiplier = {1.1}
	self.values.player.run_dodge_chance = {0.25}
	self.values.player.walk_speed_multiplier = {1.1}
	self.values.player.crouch_speed_multiplier = {1.1}
	self.values.smg.reload_speed_multiplier = {1.35}
	self.values.player.cheat_death_chance = {0.45}
	self.values.weapon.silencer_damage_multiplier = {1.15, 1.35}

	self.values.temporary.first_aid_damage_reduction = {{0.8, 10}}
	self.values.temporary.swap_weapon_faster = {{1.2, 5}}
	self.values.temporary.reload_weapon_faster = {{1.2, 5}}
	self.values.temporary.increased_movement_speed = {{1.1, 5}}
	self.values.temporary.damage_speed_multiplier = {{1.1, 5}}
	self.values.first_aid_kit.quantity = {4, 8}
	self.values.pistol.stacking_hit_expire_t = {2, 8}
	self.values.pistol.stacking_hit_damage_multiplier = {
		{
			max_stacks = 4,
			max_time = 2,
			damage_bonus = 1.1
		}
	}
	self.values.player.headshot_regen_armor_bonus = {0.8, 2.4}
	self.values.akimbo.extra_ammo_multiplier = {1.25, 1.5}
	self.values.player.melee_damage_stacking = {{max_multiplier = 4, melee_multiplier = 1}}
	self.values.player.melee_kill_increase_reload_speed = {{1.15, 10}}
	self.values.player.pick_lock_easy_speed_multiplier = {0.75, 0.5}
	self.values.player.gangster_damage_dampener = {0.9, 0.65}
	self.values.player.regain_throwable_from_ammo[1].chance = 0.02
	self.values.player.regain_throwable_from_ammo[1].chance_inc = 0.001
	
	-- Heavy Gun Expert
	self.values.player.no_movement_penalty = { true }
	self.definitions.player_no_movement_penalty = {
		name_id = "menu_player_no_movement_penalty",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "no_movement_penalty",
			category = "player",
		},
	}

	self.definitions.player_reduce_loose_money_exp_convertation_amount_mul = {
		name_id = "menu_player_reduce_loose_money_exp_convertation_amount_mul",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "reduce_loose_money_exp_convertation_amount_mul",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_doctor_bag_self_revive = {
		name_id = "menu_player_walking_bleedout_doctor_bag_self_revive",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_doctor_bag_self_revive",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_ticks_to_ressurection_1 = {
		name_id = "menu_player_walking_bleedout_ticks_to_ressurection",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_ticks_to_ressurection",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_ticks_to_ressurection_2 = {
		name_id = "menu_player_walking_bleedout_ticks_to_ressurection",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "walking_bleedout_ticks_to_ressurection",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_fak_self_revive = {
		name_id = "menu_player_walking_bleedout_fak_self_revive",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_fak_self_revive",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_fak_self_revive_additional = {
		name_id = "menu_player_walking_bleedout_fak_self_revive_additional",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_fak_self_revive_additional",
			category = "player"
		}
	}
	
	self.definitions.player_walking_bleedout_temporary_health_mul_1 = {
		name_id = "menu_player_walking_bleedout_temporary_health_mul",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_temporary_health_mul",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_temporary_health_mul_2 = {
		name_id = "menu_player_walking_bleedout_temporary_health_mul",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "walking_bleedout_temporary_health_mul",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_temporary_health_mul_3 = {
		name_id = "menu_player_walking_bleedout_temporary_health_mul",
		category = "feature",
		upgrade = {
			value = 3,
			upgrade = "walking_bleedout_temporary_health_mul",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_time_to_bleed_1 = {
		name_id = "menu_player_walking_bleedout_time_to_bleed",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_time_to_bleed",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_time_to_bleed_2 = {
		name_id = "menu_player_walking_bleedout_time_to_bleed",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "walking_bleedout_time_to_bleed",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_chance_1 = {
		name_id = "menu_player_walking_bleedout_chance",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "walking_bleedout_chance",
			category = "player"
		}
	}
	self.definitions.player_walking_bleedout_chance_2 = {
		name_id = "menu_player_walking_bleedout_chance",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "walking_bleedout_chance",
			category = "player"
		}
	}
	
	self.definitions.player_revived_health_regain_solid_wolverine = {
		name_id = "menu_player_revived_health_regain_solid_wolverine",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "revived_health_regain_solid_wolverine",
			category = "player"
		}
	}
	self.definitions.player_revived_health_regain_solid_amount_1 = {
		name_id = "menu_player_revived_health_regain_solid_amount",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "revived_health_regain_solid_amount",
			category = "player"
		}
	}
	self.definitions.player_revived_health_regain_solid_amount_2 = {
		name_id = "menu_player_revived_health_regain_solid_amount",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "revived_health_regain_solid_amount",
			category = "player"
		}
	}
	self.definitions.player_fugitive_tier_health_multiplier = {
		name_id = "menu_player_fugitive_tier_health_multiplier",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "fugitive_tier_health_multiplier",
			category = "player"
		}
	}
	self.definitions.player_guards_cant_spot_you_in_casing = {
		category = "feature",
		name_id = "menu_player_guards_cant_spot_you_in_casing",
		upgrade = {
			category = "player",
			upgrade = "guards_cant_spot_you_in_casing",
			value = 1
		}
	}
	self.definitions.player_secondary_silencer_damage_addend = {
		category = "feature",
		name_id = "menu_player_secondary_silencer_damage_addend",
		upgrade = {
			category = "player",
			upgrade = "secondary_silencer_damage_addend",
			value = 1
		}
	}
	self.definitions.player_single_shot_fire_rate_mul = {
		name_id = "menu_player_single_shot_fire_rate_mul",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "single_shot_fire_rate_mul",
			category = "player"
		}
	}
	self.definitions.player_recoil_not_moving_mul = {
		name_id = "menu_player_recoil_not_moving_mul",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "recoil_not_moving_mul",
			category = "player"
		}
	}
	self.definitions.player_recoil_not_moving_aim_mul = {
		name_id = "menu_player_recoil_not_moving_aim_mul",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "recoil_not_moving_aim_mul",
			category = "player"
		}
	}
	self.definitions.player_overkill_damage_multiplier_2 = {
		name_id = "menu_player_overkill_damage_multiplier",
		category = "temporary",
		upgrade = {
			value = 2,
			upgrade = "overkill_damage_multiplier",
			category = "temporary"
		}
	}
	self.definitions.saw_consume_no_ammo_chance = {
		name_id = "menu_saw_consume_no_ammo_chance",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "consume_no_ammo_chance",
			category = "saw"
		}
	}
	self.definitions.player_shotgun_steelsight_shield_knock = {
		name_id = "menu_player_shotgun_steelsight_shield_knock",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "shotgun_steelsight_shield_knock",
			category = "player"
		}
	}
	self.definitions.player_shotgun_shield_knock = {
		name_id = "menu_player_shotgun_shield_knock",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "shotgun_shield_knock",
			category = "player"
		}
	}
	self.definitions.passive_ammo_bag_interaction_speed_multiplier_1 = {
		name_id = "menu_passive_ammo_bag_interaction_speed_multiplier_1",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "interaction_speed_multiplier",
			category = "ammo_bag"
		}
	}
	self.definitions.passive_ammo_bag_interaction_speed_multiplier_2 = {
		name_id = "menu_passive_ammo_bag_interaction_speed_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "interaction_speed_multiplier",
			category = "ammo_bag"
		}
	}
	self.definitions.passive_doctor_bag_interaction_speed_multiplier_2 = {
		name_id = "menu_passive_doctor_bag_interaction_speed_multiplier_2",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "interaction_speed_multiplier",
			category = "doctor_bag"
		}
	}
	self.definitions.doctor_bag_deploy_time_multiplier = {
		incremental = true,
		name_id = "menu_doctor_bag_deploy_time_multiplier",
		category = "equipment_upgrade",
		upgrade = {
			value = 1,
			upgrade = "deploy_time_multiplier",
			category = "doctor_bag"
		}
	}
	self.definitions.player_cable_tie_pickup = {
		category = "feature",
		name_id = "menu_player_cable_tie_pickup",
		upgrade = {
			category = "player",
			upgrade = "cable_tie_pickup",
			value = 1
		}
	}
	self.definitions.player_civs_show_markers = {
		category = "feature",
		name_id = "menu_player_civs_show_markers",
		upgrade = {
			category = "player",
			upgrade = "civs_show_markers",
			value = 1
		}
	}
	self.definitions.player_instant_intimidation = {
		category = "feature",
		name_id = "menu_player_instant_intimidation",
		upgrade = {
			category = "player",
			upgrade = "instant_intimidation",
			value = 1
		}
	}
	self.definitions.player_intimidate_guards_pager = {
		category = "feature",
		name_id = "menu_player_intimidate_guards_pager",
		upgrade = {
			category = "player",
			upgrade = "intimidate_guards_pager",
			value = 1
		}
	}
	self.definitions.player_hostage_interaction_speed_multiplier = {
		category = "feature",
		name_id = "menu_player_hostage_interaction_speed_multiplier",
		upgrade = {
			category = "player",
			upgrade = "hostage_interaction_speed_multiplier",
			value = 1
		}
	}
	self.definitions.player_mask_off_keycard_insert = {
		category = "feature",
		name_id = "menu_player_mask_off_keycard_insert",
		upgrade = {
			category = "player",
			upgrade = "mask_off_keycard_insert",
			value = 1
		}
	}
	self.definitions.player_mask_off_pick_lock = {
		category = "feature",
		name_id = "menu_player_mask_off_pick_lock",
		upgrade = {
			category = "player",
			upgrade = "mask_off_pick_lock",
			value = 1
		}
	}
	self.definitions.player_mask_off_desktop_interaction = {
		category = "feature",
		name_id = "menu_player_mask_off_desktop_interaction",
		upgrade = {
			category = "player",
			upgrade = "mask_off_desktop_interaction",
			value = 1
		}
	}
	self.definitions.weapon_silencer_damage_multiplier_1 = {
		category = "feature",
		name_id = "silencer_damage_multiplier",
		upgrade = {
			category = "weapon",
			upgrade = "silencer_damage_multiplier",
			value = 1
		}
	}
	self.definitions.weapon_silencer_damage_multiplier_2 = {
		category = "feature",
		name_id = "silencer_damage_multiplier",
		upgrade = {
			category = "weapon",
			upgrade = "silencer_damage_multiplier",
			value = 2
		}
	}
	self.definitions.player_pick_lock_easy_speed_multiplier_1 = {
		category = "feature",
		name_id = "menu_player_pick_lock_easy_speed_multiplier",
		upgrade = {
			category = "player",
			upgrade = "pick_lock_easy_speed_multiplier",
			value = 1
		}
	}
	self.definitions.player_pick_lock_easy_speed_multiplier_2 = {
		category = "feature",
		name_id = "menu_player_pick_lock_easy_speed_multiplier",
		upgrade = {
			category = "player",
			upgrade = "pick_lock_easy_speed_multiplier",
			value = 2
		}
	}
	self.definitions.player_gangster_damage_dampener_1 = {
		category = "feature",
		name_id = "menu_player_gangster_damage_dampener",
		upgrade = {
			category = "player",
			upgrade = "gangster_damage_dampener",
			value = 1
		}
	}
	self.definitions.player_gangster_damage_dampener_2 = {
		category = "feature",
		name_id = "menu_player_gangster_damage_dampener",
		upgrade = {
			category = "player",
			upgrade = "gangster_damage_dampener",
			value = 2
		}
	}
	self.definitions.player_messiah_revive_from_bleed_out_2 = {
		name_id = "menu_player_pistol_revive_from_bleed_out",
		category = "feature",
		upgrade = {
			value = 2,
			upgrade = "messiah_revive_from_bleed_out",
			category = "player"
		}
	}
	self.definitions.player_small_loot_multiplier1 = {
		category = "feature",
		name_id = "menu_player_small_loot_multiplier",
		upgrade = {
			category = "player",
			upgrade = "small_loot_multiplier",
			value = 1
		}
	}
	self.definitions.player_small_loot_multiplier2 = {
		category = "feature",
		name_id = "menu_player_small_loot_multiplier",
		upgrade = {
			category = "player",
			upgrade = "small_loot_multiplier",
			value = 2
		}
	}
	-- FFriendship
	self.definitions.player_extra_hostages = {
		category = "feature",
		name_id = "menu_shotgun_extra_hostages",
		upgrade = {
			category = "player",
			upgrade = "extra_hostages",
			value = 1,
		},
	}
	self.values.player.extra_hostages = { 2 }
	-- Hostage Situation
	self.definitions.team_hostage_situation = {
		category = "feature",
		name_id = "hostage_situation",
		upgrade = {
			category = "team",
			upgrade = "hostage_situation",
			value = 1,
		},
	}
	self.values.team.hostage_situation = { 4 }


	local function form(var, value, mul)
		mul = mul or 100
		if var == "a" then
			return (value[1] - 1) * mul
		elseif var == "a2" then
			return ((value[2] - 1) - (value[1] - 1)) * mul
		elseif var == "b" then
			return (1 - value[1]) * mul
		elseif var == "b2" then
			return ((1 - value[2]) - (1 - value[1])) * mul
		elseif var == "c" then
			return value[1] * mul
		elseif var == "c2" then
			return (value[2] - value[1]) * mul
		elseif var == "d" then
			return math.floor(100 - (100 / mul * value[1]))
		elseif var == "e" then
			return 100 / 8 * value[1]
		else
			return 0
		end
	end

	self.editable_skill_descs = {
		mastermind_tier1 = {
			{self.values.team.stamina.passive_multiplier[1] * 10 .. "%"}
		},
		mastermind_tier2 = {
			{(1 - self.values.doctor_bag.interaction_speed_multiplier[1]) * 100 .. "%"}
		},
		mastermind_tier3 = {
			{(self.values.player.passive_intimidate_range_mul[1] - 1) * 100 .. "%"}
		},
		mastermind_tier4 = {
			{(self.values.team.health.passive_multiplier[1] - 1) * 100 .. "%"}
		},		
		enforcer_tier1 = {
			{(self.values.player.passive_suppression_multiplier[1] - 1) * 100 .. "%"}
		},
		enforcer_tier2 = {
			{(self.values.player.passive_health_multiplier[1] - 1) * 100 .. "%"}
		},
		enforcer_tier4 = {
			{((self.values.player.passive_health_multiplier[2] - 1) - (self.values.player.passive_health_multiplier[1] - 1)) * 100 .. "%"}
		},
		enforcer_tier6 = {
			{((self.values.player.passive_health_multiplier[3] - 1) - (self.values.player.passive_health_multiplier[2] - 1)) * 100 .. "%"}
		},
		technician_tier1 = {
			{(1 - self.values.player.passive_crafting_weapon_multiplier[1]) * 100 .. "%"}
		},
		technician_tier2 = {
			{(1 - self.values.weapon.passive_recoil_multiplier[1]) * 100 .. "%"}
		},
		technician_tier3 = {
			{((1 - self.values.player.passive_crafting_weapon_multiplier[2]) - (1 - self.values.player.passive_crafting_weapon_multiplier[1])) * 100 .. "%"}
		},
		technician_tier5 = {
			{((1 - self.values.player.passive_crafting_weapon_multiplier[3]) - ((1 - self.values.player.passive_crafting_weapon_multiplier[2]) - (1 - self.values.player.passive_crafting_weapon_multiplier[1])) - (1 - self.values.player.passive_crafting_weapon_multiplier[1])) * 100 .. "%"}
		},
		technician_tier6 = {
			{
				((1 - self.values.weapon.passive_recoil_multiplier[2]) - (1 - self.values.weapon.passive_recoil_multiplier[1])) * 100 .. "%", 		
				(self.values.player.passive_armor_multiplier[1] - 1) * 100 .. "%", 
				(1 - self.values.team.armor.passive_regen_time_multiplier[1]) * 100 .. "%" 
			}
		},
		ghost_tier1 = {
			{self.values.player.passive_dodge_chance[1] * 100 .. "%"}
		},
		ghost_tier2 = {
			{(self.values.weapon.passive_swap_speed_multiplier[1] - 1) * 100 .. "%"}
		},
		ghost_tier3 = {
			{(self.values.player.passive_dodge_chance[2] - self.values.player.passive_dodge_chance[1]) * 100 .. "%"}
		},
		ghost_tier4 = {
			{
				"+" .. self.values.player.passive_concealment_modifier[1],
				(1 - self.values.player.passive_armor_movement_penalty_multiplier[1]) * 100 .. "%"
			}
		},
		ghost_tier5 = {
			{((self.values.weapon.passive_swap_speed_multiplier[2] - 1) - (self.values.weapon.passive_swap_speed_multiplier[1] - 1)) * 100 .. "%"}
		},
		ghost_tier6 = {
			{
				(self.values.player.passive_loot_drop_multiplier[1] - 1) * 100 .. "%",
				self.values.weapon.armor_piercing_chance[1] * 100 .. "%"
			}
		},	
		
		mastermind = {
			{"2"}
		},		
		cable_guy = {
			{"75%"},
			{"4"}
		},
		combat_medic = {
			{"25%", "10"},
			{"30%"}
		},
		leadership = {
			{"10%"},
			{"5%"}
		},
		painkillers = {
			{"10%", "5"},
			{"20%"}
		},
		equilibrium = {
			{"10%", "50%"},
			{"100%"}
		},
		medic_2x = {
			{"2"},
			{"2"}
		},
		dominator = {
			{},
			{"50%"}
		},
		gunslinger = {
			{"50%"},
			{"15"}
		},
		kilmer = {
			{"25%"},
			{"50%"}
		},
		trigger_happy = {
			{
				"10%",
				"2",
				"4"
			},
			{"8"}
		},
		messiah = {
			{"1"},
			{"2"}
		},
		inspire = {
			{"50%", "20%", "10"},
			{"75%", "9"}
		},
		
		show_of_force = {
			{},
			{"15%"}
		},
		underdog = {
			{"15%"},
			{"15%"}
		},
		steroids = {
			{"50%"},
			{"50%"}
		},
		oppressor = {
			{"25%"},
			{"50%"}
		},
		tough_guy = {
			{"50%"},
			{"100%"}
		},
		pack_mule = {
			{"50"},
			{"50"}
		},
		shotgun_impact = {
			{"25%"},
			{"35%"}
		},
		shades = {
			{"25%"},
			{"50%"}
		},
		from_the_hip = {
			{"75"}
		},
		shotgun_cqb = {
			{"50"},
			{"40", "50"}
		},
		ammo_2x = {
			{"2"},
			{"200%"}
		},
		wolverine = {
			{"", "250%", "25%"},
			{"", "100%", "25%"}
		},
		bandoliers = {
			{"25%"},
			{"175%"}
		},
		portable_saw = {
			{},
			{"1"}
		},
		overkill = {
			{"75", "5"}
		},

		technician = {
			{"2"}
		},
		rifleman = {
			{"100%"},
			{"25%"}
		},
		trip_miner = {
			{"20%"},
			{"1"} --swapped places
		},
		discipline = {
			{"50"}
		},
		sharpshooter = {
			{"20%"},
			{"25%"}
		},
		hardware_expert = {
			{"25%", "20%"},
			{"30%", "50%"}
		},
		marksman = {
			{"4", "25%"},
			{"8", "20%"}
		},
		combat_engineering = {
			{"30%"},
			{"15%"}
		},
		drill_expert = {
			{"15%"},
			{"15%"}
		},
		jack_of_all_trades = {
			{"15%"},
			{"50%"}
		},
		silent_drilling = {
			{"65%"}
		},
		sentry_2_0 = {
			{"5%"}
		},
		shaped_charge = {
			{"3"} --3
		},
		insulation = {
			{},
			{"50%"}
		},
		tower_defense = {
			{"2"},
			{"300%"}
		},
		iron_man = {
			{"50%"},
			{"25%"}
		},

		ghost = {
			{"1", "20"}
		},
		martial_arts = {
			{"50%"},
			{"50%"}
		},
		sprinter = {
			{"25%", "25%"},
			{"10%", "25%"}
		},
		transporter = {
			{"25%"},
			{"50%"}
		},
		chameleon = {
			{"25%"},
			{"15%"}
		},
		assassin = {
			{"10%", "10%"},
			{"95%"}
		},
		smg_master = {
			{"35%"},
			{"20%"}
		},
		magic_touch = {
			{"25%"},
			{"25%"}
		},
		ecm_2x = {
			{"2"},
			{"25%", "25%"}
		},
		nine_lives = {
			{self.values.player.additional_lives[1]},
			{self.values.player.cheat_death_chance[1] * 100 .. "%"}
		},
		good_luck_charm = {
			{"10", "1"},
			{"10"}
		},
		ecm_booster = {
			{"25%"}
		},
		silence_expert = {
			{"50%", "100%"},
			{"50%", "15%"}
		},
		low_blow = {
			{"3%", "3", "35", "30%"},
			{"3%", "1", "35", "30%"}
		},
		ecm_feedback = {
			{"50%-100%", "25", "1.5", "15-20"},
			{"25%", "100%", "4"}
		},
		hitman = {
			{
				"15%"
			},
			{
				"20%",
				"20%"
			}
		},
		
		hoxton = {
			{"4"}
		},	
		cell_mates = {
			{"10%"},
			{"25%"}
		},
		freedom_call = {
			{"20%"},
			{"15%"}
		},
		awareness = {
			{"10%"}
		},
		alpha_dog = {
			{"5%"},
			{"10%"}
		},
		up_you_go = {
			{"30%", "10"},
			{"40%"}
		},
		thick_skin = {
			{"10", "2"},
			{"20", "4"}
		},
		tea_time = {
			{"50%"},
			{"10%", "120"}
		},
		hidden_blade = {
			{"10", "2"},
			{"20", "4"}
		},
		running_from_death = {
			{form("a", self.values.temporary.swap_weapon_faster[1]).."%", self.values.temporary.swap_weapon_faster[1][2]},
			{form("a", self.values.temporary.increased_movement_speed[1]).."%", self.values.temporary.increased_movement_speed[1][2]}
		},
		second_chances = {
			{},
			{"2"}
		},
		tea_cookies = {
			{self.values.first_aid_kit.quantity[1]},
			{self.values.first_aid_kit.quantity[2] - self.values.first_aid_kit.quantity[1]}
		},
		bloodthirst = {
			{"100%", "400%"},
			{"15%", "10"}
		}
	}
	self.skill_descs = {}
	for skill_id, skill_desc in pairs(self.editable_skill_descs) do
		self.skill_descs[skill_id] = {}
		for index, skill_version in ipairs(skill_desc) do
			local version = index == 1 and "multibasic" or "multipro"
			self.skill_descs[skill_id][index] = #skill_version

			for i, desc in ipairs(skill_version) do
				self.skill_descs[skill_id][version .. (i == 1 and "" or tostring(i))] = desc
			end
		end
	end
end