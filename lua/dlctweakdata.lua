Hooks:PostHook(DLCTweakData, "init", "eclipse_init", function(self)
	self.eclipse = {
		free = true,
		content = {},
	}
	self.eclipse.content.loot_global_value = "normal"
	self.eclipse.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_eclipse",
		},
	}
	
	-- prevent 'dlc' from this table from giving you anything on a new save, you can still get them from drops
	local unlock_table = { 
		self.preorder,
		self.starvr_free,
		self.starter_kit,
		self.starter_kit_mask,
		self.dlc_achievement,
		self.pd2_clan,
		self.pd2_clan2,
		self.pd2_clan3,
		self.pd2_clan4,
		self.pd2_clan5,
		self.pd2_clan6,
		self.pd2_clan_crimefest_oct19,
		self.pd2_clan_crimefest_oct23,
		self.pd2_clan_johnwick,
		self.pd2_clan_lgl,
		self.crimefest2_u2,
		self.crimefest2_par,
		self.crimefest2_rave,
		self.crimefest2_u8,
		self.crimefest2_u9,
		self.crimefest2_u2,
		self.crimefest2_par,
		self.crimefest2_rave,
		self.crimefest2_u8,
		self.crimefest2_u9,
		self.free_halloween_textures,
		self.poetry_soundtrack,
		self.armored_transport,
		self.gage_pack,
		self.gage_pack_shotgun,
		self.gage_pack_lmg,
		self.charliesierra,
		self.xmas_soundtrack,
		self.sweettooth,
		self.gage_pack_historical,
		self.alienware_alpha,
		self.goty_weapon_bundle_2014,
		self.goty_heist_bundle_2014,
		self.goty_dlc_bundle_2014,
		self.character_pack_clover,
		self.butch_pack_free,
		self.character_pack_dragan,
		self.overkill_pack,
		self.bbq,
		self.west,
		self.arena,
		self.kenaz,
		self.turtles,
		self.turtles_mods_fix,
		self.turtles_free,
		self.dragon,
		self.dragon_maskfix,
		self.steel_free,
		self.tormentor_mask,
		self.coco,
		self.mad,
		self.pim,
		self.opera,
		self.jigg,
		self.dbd_clan,
		self.dbd_clan_award,
		self.free_jwshades,
		self.john_wick_character,
		self.dbd_boo_0_award,
		self.dbd_boo_1_award,
		self.dbd_boo_4_award,
		self.wild,
		self.solus_clan_award,
		self.pd2_clan_migg,
		self.pd2_clan_fibb,
		self.gotti_bundle,
		self.nyck_bundle,
		self.urf_bundle,
		self.howl,
		self.tango,
		self.win_bundle,
		self.chico_bundle,
		self.friend_bundle,
		self.sha_bundle,
		self.yor_bundle,
		self.spa_bundle,
		self.ach_grv_1,
		self.bny_bundle,
		self.mp2_bundle,
		self.amp_bundle,
		self.flip_bundle,
		self.mdm_bundle,
		self.ant_free,
		self.ant,
		self.dgm_bundle,
		self.gcm_bundle,
		self.ztm_bundle,
		self.wmp_bundle,
		self.cmo_bundle,
		self.pbm_bundle,
		self.fdm_bundle,
		self.kwm_bundle,
		self.mmj_bundle,
		self.ecp_bundle,
		self.gwm_bundle,
		self.rvd_bundle,
		self.bodhi_bundle,
		self.pmp_bundle,
		self.joy_bundle,
		self.ghm_bundle,
		self.khp_bundle,
		self.sdb_bundle,
		self.ram_bundle,
		self.sms_bundle_1,
		self.sms_bundle_2,
		self.scm_bundle,
		self.pd2_clan_trd,
		self.wcs_pd2_clan,
		self.xm20_free,
		self.faco_free,
		self.sawp_starter_pack,
		self.lawp_starter_pack,
		self.pxp1_bbq,
		self.pxp1_sawp,
		self.pxp3_starter_pack,
		self.ach_brooklyn_1,
		self.ach_brooklyn_2,
		self.ach_brooklyn_3,
		self.ach_brooklyn_4,
		self.ach_bulldog_1,
		self.pd2_clan_bonnie,
		self.ach_lab_1,
		self.ach_lab_2,
		self.character_pack_sokol,
		self.sbzac_elegantteeth,
		self.pxp3_starter_pack,
		self.a10mask_bundle,
		self.ghx_bundle,
		self.sdm_bundle,
		self.toon_bundle,
		self.flm_bundle,
		self.tar_bundle,
		self.ja21_bundle,
		self.xm20_free,
		self.mxm_bundle,
		self.mxw_bundle,
	}
	
	local ach_hell = { 
		self.halloween_nightmare_1,
		self.halloween_nightmare_2,
		self.halloween_nightmare_3,
		self.halloween_nightmare_4,
		self.ach_gage4_2,
		self.ach_gage4_4,
		self.ach_gage4_5,
		self.ach_gage4_6,
		self.ach_gage4_7,
		self.ach_gage4_8,
		self.ach_gage4_9,
		self.ach_gage4_10,
		self.ach_gage4_11,
		self.ach_gage5_1,
		self.ach_gage5_2,
		self.ach_gage5_3,
		self.ach_gage5_4,
		self.ach_gage5_5,
		self.ach_gage5_6,
		self.ach_gage5_7,
		self.ach_gage5_8,
		self.ach_gage5_9,
		self.ach_gage5_10,
		self.ach_gage3_3,
		self.ach_gage3_4,
		self.ach_gage3_5,
		self.ach_gage3_6,
		self.ach_gage3_7,
		self.ach_gage3_8,
		self.ach_gage3_9,
		self.ach_gage3_10,
		self.ach_gage3_11,
		self.ach_gage3_12,
		self.ach_gage3_13,
		self.ach_gage3_14,
		self.ach_gage3_15,
		self.ach_gage3_16,
		self.ach_gage3_17,
		self.ach_bigbank_1,
		self.ach_bigbank_2,
		self.ach_bigbank_3,
		self.ach_bigbank_4,
		self.ach_bigbank_5,
		self.ach_bigbank_6,
		self.ach_bigbank_7,
		self.ach_bigbank_8,
		self.ach_bigbank_9,
		self.ach_bigbank_10,
		self.ach_miami_2,
		self.ach_miami_3,
		self.ach_miami_4,
		self.ach_miami_5,
		self.ach_miami_7,
		self.ach_eagle_1,
		self.ach_eagle_2,
		self.ach_eagle_3,
		self.ach_eagle_4,
		self.ach_eagle_5,
		self.ach_bat_2,
		self.ach_bat_3,
		self.ach_bat_4,
		self.ach_bat_6,
		self.ach_cow_3,
		self.ach_cow_4,
		self.ach_cow_5,
		self.ach_cow_8,
		self.ach_cow_9,
		self.ach_cow_10,
		self.ach_cow_11,
		self.ach_ameno_1,
		self.ach_ameno_2,
		self.ach_ameno_3,
		self.ach_ameno_4,
		self.ach_ameno_5,
		self.ach_ameno_6,
		self.ach_ameno_7,
		self.ach_ameno_8,
		self.ach_bbq_1,
		self.ach_bbq_2,
		self.ach_bbq_3,
		self.ach_bbq_4,
		self.ach_west_1,
		self.ach_west_2,
		self.ach_west_3,
		self.ach_west_4,
		self.ach_melt_3,
		self.ach_arena_2,
		self.ach_arena_3,
		self.ach_arena_4,
		self.ach_arena_5,
		self.ach_kenaz_2,
		self.ach_kenaz_3,
		self.ach_kenaz_4,
		self.ach_kenaz_5,
		self.ach_turtles_1,
		self.ach_turtles_2,
		self.ach_turtles_3,
		self.ach_turtles_4,
		self.ach_steel_1,
		self.ach_steel_2,
		self.ach_steel_3,
		self.ach_steel_4,
		self.ach_berry_2,
		self.ach_berry_5,
		self.ach_jerry_3,
		self.ach_jerry_4,
		self.ach_cane_3,
		self.ach_cane_4,
		self.ach_peta_2,
		self.ach_peta_3,
		self.ach_peta_4,
		self.ach_peta_5,
		self.ach_pal_2,
		self.ach_pal_3,
		self.ach_pal_4,
		self.ach_pim_1,
		self.ach_pim_2,
		self.ach_pim_3,
		self.ach_pim_4,
		self.ach_born_3,
		self.ach_born_4,
		self.ach_born_5,
		self.ach_born_6,
		self.ach_friend_4,
		self.ach_friend_5,
		self.ach_friend_6,
		self.ach_spa_5,
		self.ach_spa_6,
		self.ach_fish_5,
		self.ach_fish_6,
		self.ach_grv_1,
		self.ach_grv_2,
		self.ach_grv_3,
		self.ach_grv_4,
		self.ach_grv_5,
		self.pxp1_sawp,
		self.ach_pxp2_1,
		self.ach_mask_pent_9,
		self.ach_trd_pent_11,
		self.ach_deep_10,
	}
	
	local non_dlc_ach = {
		self.ach_deer_1,
		self.ach_deer_2,
		self.ach_deer_3,
		self.ach_deer_4,
		self.ach_deer_6,
		self.ach_gorilla_1,
		self.ach_fort_4,
		self.ach_payback_3,
		self.ach_mad_2,
		self.ach_mad_3,
		self.ach_dark_2,
		self.ach_dark_3,
		self.howl,
		self.ach_help_4,
		self.ach_help_5,
		self.ach_help_6,
		self.ach_moon_4,
		self.ach_ja22_01,
		self.ach_pxp2_3,
		self.ach_mask_xm20_1,
	}

	for _, id in ipairs (unlock_table) do
		id.content.loot_drops = nil
	end
	
	for _, id2 in ipairs (ach_hell) do
		id2.achievement_id = nil
		id2.content.loot_drops = nil
		id2.dlc = id2.content.loot_global_value
	end
	
	for _, id3 in ipairs (non_dlc_ach) do
		id3.content.loot_drops = nil
		id3.achievement_id = nil
	end
	
	-- stupid stream drop program to be re-integrated as career mode drops i guess ..
	-- halloween 2022
	-- masks; h22_devilhorn , h22_banshee , h22_bloodysnarl , h22_deadman
	-- player_styles; h22_nightwalker , h22_tasslefringe , h22_ghostly , h22_tornrags , h22_darkprince , h22_devilclaws
	
	-- 11th anniversary
	-- masks; a11th_homburg_grey , a11th_homburg
	-- player_styles; a11th_corl
	
	-- nebula prime
	-- masks; prim_primtime
	-- player_styles; prim_newhorizon , prim_darkmat
	
	-- oil baron
	-- masks; rat_oilbaron
	-- player_styles; rat_ranchdiesel , rat_mocow
	
	-- too lazy to sort these last ones sorry
	-- cot_smilecigar , cot_sleekygent , cot_beigedriver , trt_railhat , trt_railwork , trt_railroad
	
	-- edge cases because these dlc's also give other items that can't be received via drops
	self.snow_bundle.content.loot_drops = {
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_choco",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_flake",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_igloo",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_snow",
			amount = 1
		},
		{
			type_items = "weapon_skins",
			item_entry = "color_snow_01",
			amount = 1
		},
		{
			type_items = "weapon_skins",
			item_entry = "color_snow_02",
			amount = 1
		},
		{
			type_items = "weapon_skins",
			item_entry = "color_snow_03",
			amount = 1
		},
		{
			type_items = "weapon_skins",
			item_entry = "color_snow_04",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "rusbear",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "lonorwa",
			amount = 1
		}
	}
	
	self.tma1_bundle.content.loot_drops = {
		{
			type_items = "gloves",
			item_entry = "dodskull",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "dodsuit",
			amount = 1
		},
		{
			type_items = "weapon_skins",
			item_entry = "color_tma1_01",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_rooster",
			amount = 1
		},
		{
			type_items = "weapon_mods",
			item_entry = "wpn_fps_upg_charm_skull",
			amount = 1
		}
	}
	
	self.cctp_bundle.content.loot_drops = {
		{
			type_items = "gloves",
			item_entry = "mnk",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "mnt",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "tgr",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "vpr",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "cybertrench",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "cyberhoodie",
			amount = 1
		}
	}
	
	self.tstp_bundle.content.loot_drops = {
		{
			type_items = "player_styles",
			item_entry = "hitman",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "traditional",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "redstripe",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "flame",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "reddragon",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "blackdragon",
			amount = 1
		}
	}
	
	self.txt1_bundle.content.loot_drops = {
		{
			type_items = "gloves",
			item_entry = "hardwork",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "texriding",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "blackstar",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "workranch",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "bullranch",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "texvest",
			amount = 1
		}
	}

	self.txt2_bundle.content.loot_drops = {
		{
			type_items = "gloves",
			item_entry = "chromecross",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "redhand",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "bikervest",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "bikerjacket",
			amount = 1
		}
	}

	self.txt3_bundle.content.loot_drops = {
		{
			type_items = "player_styles",
			item_entry = "cargocasual",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "leatherfluff",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "puffervest",
			amount = 1
		}
	}

	self.txt4_bundle.content.loot_drops = {
		{
			type_items = "player_styles",
			item_entry = "bthekid",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "cassidy",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "jessjames",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "sambass",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "txbull",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "txrider",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "txrivet",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "txsuede",
			amount = 1
		}
	}
	
	self.sdtp_bundle.content.loot_drops = {
		{
			type_items = "player_styles",
			item_entry = "highinttech",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "lowinttech",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techhigh_tortoise",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techhigh_bird",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techhigh_tiger",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techhigh_dragon",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techlow_tortoise",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techlow_bird",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techlow_tiger",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "techlow_dragon",
			amount = 1
		}
	}
	
	self.gdtp_bundle.content.loot_drops = {
		{
			type_items = "gloves",
			item_entry = "biker_yellow_led",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "biker_red_led",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "dragonscale",
			amount = 1
		},
		{
			type_items = "gloves",
			item_entry = "spikeknuckle",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "enforcer",
			amount = 1
		},
		{
			type_items = "masks",
			item_entry = "boss_gold",
			amount = 1
		},
		{
			type_items = "masks",
			item_entry = "boss_silver",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "boss_gdtp",
			amount = 1
		}
	}
	
	self.xm20_bundle.content.loot_drops = {
		{
			type_items = "weapon_skins",
			item_entry = "color_xm20_01",
			amount = 1
		},
		{
			type_items = "player_styles",
			item_entry = "candycane",
			amount = 1
		}
	}
	
	self.ach_deep_10.content.loot_drops = {
		{
			type_items = "player_styles",
			item_entry = "bossflag"
		},
	}
	
	self.ach_trd_pent_11.content.loot_drops = {
		{
			type_items = "player_styles",
			item_entry = "kungfumaster"
		}
	}

	-- remove viper gas achievement unlock
	self.ach_pxp1_01.content.upgrades = nil

	-- don't give a bunch of stuff by default at level 0
	self.armored_transport.content.upgrades = nil
	self.pd2_clan_lgl.content.upgrades = nil
	self.pd2_clan2.content.upgrades = nil
	self.gage_pack.content.upgrades = nil
	self.cce.content.upgrades = nil
	self.preorder.content.upgrades = nil
	self.cce.content.upgrades = nil
	self.gage_pack_lmg.content.upgrades = nil
	self.starter_kit.content.upgrades = nil
	self.mxm_upgrades.content.upgrades = { "grenade_crate" }
	self.sawp_grenade.content.upgrades = nil
end)
