Hooks:PostHook(AchievementsTweakData, "init", "eclipse_init", function(self)
	-- self.weapon_part_tracker = nil
	
	local weapon_part_untracker = {
		wpn_fps_snp_m95_barrel_long,
		wpn_fps_snp_r93_b_suppressed,
		wpn_fps_upg_o_45iron,
		wpn_fps_snp_r93_b_short,
		wpn_fps_snp_m95_barrel_suppressed,
		wpn_fps_snp_m95_barrel_short,
		wpn_fps_upg_o_leupold,
		wpn_fps_snp_msr_body_msr,
		wpn_fps_snp_r93_body_wood,
		wpn_fps_snp_msr_ns_suppressor,
		wpn_fps_snp_msr_b_long,
		wpn_fps_ass_fal_fg_01,
		wpn_fps_ass_fal_fg_03,
		wpn_fps_ass_fal_fg_04,
		wpn_fps_ass_fal_fg_wood,
		wpn_fps_ass_fal_s_01,
		wpn_fps_ass_fal_s_03,
		wpn_fps_ass_fal_s_wood,
		wpn_fps_ass_fal_g_01,
		wpn_fps_ass_fal_m_01,
		wpn_fps_upg_o_mbus_rear,
		wpn_fps_sho_ben_b_short,
		wpn_fps_sho_ben_b_long,
		wpn_fps_sho_ben_s_collapsed,
		wpn_fps_sho_ksg_b_short,
		wpn_fps_sho_ksg_b_long,
		wpn_fps_sho_ben_s_solid,
		wpn_fps_sho_striker_b_long,
		wpn_fps_sho_striker_b_suppressed,
		wpn_fps_gre_m79_barrel_short,
		wpn_fps_gre_m79_stock_short,
		wpn_fps_ass_g3_b_sniper,
		wpn_fps_ass_g3_fg_psg,
		wpn_fps_ass_g3_g_sniper,
		wpn_fps_ass_g3_s_sniper,
		wpn_fps_ass_g3_b_short,
		wpn_fps_ass_g3_fg_retro_plastic,
		wpn_fps_ass_g3_fg_railed,
		wpn_fps_ass_g3_fg_retro,
		wpn_fps_ass_g3_g_retro,
		wpn_fps_ass_g3_s_wood,
		wpn_fps_ass_galil_s_sniper,
		wpn_fps_ass_galil_fg_sniper,
		wpn_fps_ass_galil_g_sniper,
		wpn_fps_ass_galil_fg_sar,
		wpn_fps_ass_galil_fg_mar,
		wpn_fps_ass_galil_s_plastic,
		wpn_fps_ass_galil_s_light,
		wpn_fps_ass_galil_s_wood,
		wpn_fps_ass_galil_fg_fab,
		wpn_fps_ass_galil_s_fab,
		wpn_fps_ass_galil_s_skeletal,
		wpn_fps_ass_famas_b_sniper,
		wpn_fps_ass_famas_b_short,
		wpn_fps_ass_famas_b_long,
		wpn_fps_ass_famas_g_retro,
		wpn_fps_ass_famas_b_suppressed,
		wpn_fps_smg_scorpion_g_ergo,
		wpn_fps_smg_scorpion_m_extended,
		wpn_fps_smg_scorpion_s_unfolded,
		wpn_fps_smg_uzi_fg_rail,
		wpn_fps_smg_uzi_s_leather,
		wpn_fps_smg_uzi_s_solid,
		wpn_fps_smg_scorpion_g_wood,
		wpn_fps_smg_tec9_ns_ext,
		wpn_fps_smg_tec9_m_extended,
		wpn_fps_smg_tec9_s_unfolded,
		wpn_fps_smg_uzi_b_suppressed,
		wpn_fps_smg_uzi_s_standard,
		wpn_fps_smg_scorpion_b_suppressed,
		wpn_fps_smg_scorpion_s_nostock,
		wpn_fps_smg_tec9_b_standard,
		wpn_fps_snp_mosin_b_sniper,
		wpn_fps_snp_mosin_b_standard,
		wpn_fps_smg_sterling_b_e11,
		wpn_fps_pis_c96_nozzle,
		wpn_fps_pis_c96_sight,
		wpn_fps_smg_sterling_b_short,
		wpn_fps_smg_sterling_b_suppressed,
		wpn_fps_smg_sterling_m_short,
		wpn_fps_smg_sterling_s_folded,
		wpn_fps_smg_sterling_s_nostock,
		wpn_fps_smg_sterling_s_solid,
		wpn_fps_snp_mosin_body_black,
		wpn_fps_pis_c96_b_long,
		wpn_fps_snp_mosin_b_short,
		wpn_fps_smg_sterling_m_long,
		wpn_fps_smg_sterling_b_long,
		wpn_fps_lmg_mg42_b_vg38,
		wpn_fps_pis_c96_m_extended,
		wpn_fps_pis_c96_s_solid,
		wpn_fps_lmg_mg42_b_mg34,
		wpn_fps_upg_ass_m4_upper_reciever_core,
		wpn_fps_upg_ass_m4_lower_reciever_core,
		wpn_fps_upg_ass_m16_fg_stag,
		wpn_fps_upg_ak_g_rk3,
		wpn_fps_upg_ak_fg_zenit,
		wpn_fps_upg_ass_m4_upper_reciever_ballos,
		wpn_fps_upg_o_ak_scopemount,
		wpn_fps_upg_ns_ass_pbs1,
		wpn_fps_upg_ass_ak_b_zastava,
		wpn_fps_upg_ak_m_uspalm,
		wpn_fps_upg_ass_m4_fg_moe,
		wpn_fps_upg_smg_olympic_fg_lr300,
		wpn_fps_upg_ass_m4_fg_lvoa,
		wpn_fps_upg_ak_s_solidstock,
		wpn_fps_upg_m4_s_ubr,
		wpn_fps_upg_ass_m4_b_beowulf,
		wpn_fps_upg_m4_m_l5,
		wpn_fps_upg_ak_fg_trax,
		wpn_fps_upg_ak_fg_krebs,
		wpn_fps_upg_ak_b_ak105,
		wpn_fps_upg_charm_cloaker,
	}
	
	for _, ach_part in ipairs (weapon_part_untracker) do
		self.weapon_part_tracker.ach_part = nil
	end
	
	local normal_and_above = {
		"hard",
		"overkill",
		"overkill_145",
		"easy_wish",
	}
	local hard_and_above = {
		"overkill",
		"overkill_145",
		"easy_wish",
	}
	local overkill_and_above = {
		"overkill_145",
		"easy_wish",
	}
	local deathwish_and_above = {
		"easy_wish",
	}

	-- story heist completion checks in order
	self.complete_heist_achievements.story_four_stores = {
		job = "four_stores",
		story = "story_four_stores",
	}
	self.complete_heist_achievements.story_mallcrasher = {
		job = "mallcrasher",
		story = "story_mallcrasher",
	}
	self.complete_heist_achievements.story_ukrainian_job = {
		job = "ukrainian_job_prof",
		story = "story_ukrainian_job",
		difficulty = normal_and_above,
	}
	self.complete_heist_achievements.story_nightclub = {
		job = "nightclub",
		story = "story_nightclub",
		difficulty = normal_and_above,
	}
	self.complete_heist_achievements.story_bank_heist = {
		job = "branchbank",
		story = "story_bank_heist",
		difficulty = normal_and_above,
	}
	self.complete_heist_achievements.story_diamond_store = {
		job = "family",
		story = "story_diamond_store",
		difficulty = normal_and_above,
	}
	self.complete_heist_achievements.story_transport_mult = {
		story = "story_transport_mult",
		jobs = {
			"arm_cro",
			"arm_hcm",
			"arm_fac",
			"arm_par",
			"arm_und",
			"arm_for",
		},
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_shadow_raid = {
		job = "kosugi",
		story = "story_shadow_raid",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_gobank = {
		story = "story_gobank",
		job = "roberts",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_car_shop = {
		job = "cage",
		story = "story_car_shop",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_white_xmas = {
		job = "pines",
		story = "story_white_xmas",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_stealing_xmas = {
		job = "moon",
		story = "story_stealing_xmas",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_watchdogs = {
		story = "story_watchdogs",
		jobs = {
			"watchdogs_wrapper",
			"watchdogs_night",
			"watchdogs",
		},
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_firestarter = {
		job = "firestarter",
		story = "story_firestarter",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_rats = {
		job = "alex",
		story = "story_rats",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_big_oil = {
		story = "story_big_oil",
		jobs = {
			"welcome_to_the_jungle_wrapper_prof",
			"welcome_to_the_jungle_night_prof",
			"welcome_to_the_jungle_prof",
		},
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_framing_frame = {
		job = "framing_frame",
		story = "story_framing_frame",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_election_day = {
		job = "election_day",
		story = "story_election_day",
		difficulty = hard_and_above,
	}

	-- ACT 2 START

	self.complete_heist_achievements.story_big_bank = {
		job = "big",
		story = "story_big_bank",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_hotline_miami = {
		job = "mia",
		story = "story_hotline_miami",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_hoxton_breakout = {
		job = "hox",
		story = "story_hoxton_breakout",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_hoxton_revenge = {
		job = "hox_3",
		story = "story_hoxton_revenge",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_diamond = {
		job = "mus",
		story = "story_diamond",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_nmh = {
		job = "nmh",
		story = "story_nmh",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_alesso = {
		job = "arena",
		story = "story_alesso",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_golden_grin = {
		job = "kenaz",
		story = "story_golden_grin",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_bombheists_mult_2 = {
		story = "story_bombheists_mult_2",
		difficulty = hard_and_above,
		jobs = {
			"crojob1",
			"crojob_wrapper",
			"crojob2",
			"crojob2_night",
		},
	}

	-- ACT 3 START

	self.complete_heist_achievements.story_aftershock = {
		job = "jolly",
		story = "story_aftershock",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_goat_sim = {
		job = "peta",
		story = "story_goat_sim",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_santas_workshop = {
		job = "cane",
		story = "story_mayhem_santas_workshop",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_meltdown = {
		job = "shoutout_raid",
		story = "story_meltdown",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_slaughterhouse = {
		job = "dinner",
		story = "story_slaughterhouse",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_murky_station = {
		job = "dark",
		story = "story_murky_station",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_boiling_point = {
		job = "mad",
		story = "story_boiling_point",
		difficulty = hard_and_above,
	}

	-- ACT 4 START

	self.complete_heist_achievements.story_beneath_the_mountain = {
		job = "pbr",
		story = "story_beneath_the_mountain",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_birth_of_sky = {
		job = "pbr2",
		story = "story_birth_of_sky",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_heat_street = {
		job = "run",
		story = "story_heat_street",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_biker_heist = {
		job = "born",
		story = "story_biker_heist",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_scarface = {
		job = "friend",
		story = "story_scarface",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_green_bridge = {
		job = "glace",
		story = "story_green_bridge",
		difficulty = hard_and_above,
	}

	-- ACT 5 BEGIN

	self.complete_heist_achievements.story_first_world_bank = {
		job = "red2",
		story = "story_first_world_bank",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_undercover = {
		job = "man",
		story = "story_undercover",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_panic_room = {
		job = "flat",
		story = "story_panic_room",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_counterfeit = {
		job = "pal",
		story = "story_counterfeit",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_brooklyn_10_10 = {
		job = "spa",
		story = "story_brooklyn_10_10",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_yacht = {
		job = "fish",
		story = "story_yacht",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_alaskan_deal = {
		job = "wwh",
		story = "story_alaskan_deal",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_diamond_heist = {
		job = "dah",
		story = "story_diamond_heist",
		difficulty = overkill_and_above,
	}

	-- ACT 6 BEGIN

	self.complete_heist_achievements.story_reservoir_dogs = {
		job = "rvd",
		story = "story_reservoir_dogs",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_brooklyn_bank = {
		job = "brb",
		story = "story_brooklyn_bank",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_breakin_feds = {
		job = "tag",
		story = "story_breakin_feds",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_henrys_rock = {
		job = "des",
		story = "story_henrys_rock",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_shacklethorne = {
		job = "sah",
		story = "story_shacklethorne",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_hells_island = {
		job = "bph",
		story = "story_hells_island",
		difficulty = overkill_and_above,
	}

	self.complete_heist_achievements.story_white_house = {
		job = "vit",
		story = "story_white_house",
		difficulty = deathwish_and_above,
	}

	-- EXTRA

	self.complete_heist_achievements.story_mex = {
		story = "story_mex",
		job = "mex",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_bex = {
		story = "story_bex",
		job = "bex",
		difficulty = hard_and_above,
	}

	self.complete_heist_achievements.story_pex = {
		story = "story_pex",
		job = "pex",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_fex = {
		story = "story_fex",
		job = "fex",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_chas = {
		story = "story_chas",
		job = "chas",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_sand = {
		story = "story_sand",
		job = "sand",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_chca = {
		story = "story_chca",
		job = "chca",
		difficulty = normal_and_above,
	}

	self.complete_heist_achievements.story_pent = {
		story = "story_pent",
		job = "pent",
		difficulty = normal_and_above,
	}
end)
