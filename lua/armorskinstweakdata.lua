--removes horrible stickers off of the armor skins as well as makes the crime spree ones free
Hooks:PostHook(EconomyTweakData, "_init_armor_skins_crime_spree", "free_armor", function(self)
	self.armor_skins.cvc_green = {
		name_id = "bm_askn_cvc_green",
		desc_id = "bm_askn_cvc_green_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/cvc",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_004_df")
		},
		uv_scale = {
			[3] = Vector3(12.086, 12.086, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(-0.320689, 1.38638, 0)
		},
		pattern_tweak = {
			[3] = Vector3(2.82853, 0, 1)
		},
		uv_scale = {
			[3] = Vector3(9.32087, 11.1325, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(-0.320768, 1.37938, 0)
		},
		
	}
	self.armor_skins.cvc_black = {
		name_id = "bm_askn_black",
		desc_id = "bm_askn_black_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/cvc",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_001_df")
		},
		pattern_tweak = {
			[3] = Vector3(2.82853, 0, 1)
		},
		uv_scale = {
			[3] = Vector3(9.32087, 11.1325, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(-0.320768, 1.37938, 0)
		},
		
	}
	self.armor_skins.cvc_tan = {
		name_id = "bm_askn_cvc_tan",
		desc_id = "bm_askn_cvc_tan_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/cvc",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_007_df")
		},
		pattern_tweak = {
			[3] = Vector3(2.82853, 0, 1)
		},
		uv_scale = {
			[3] = Vector3(9.32087, 11.1325, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(-0.320768, 1.37938, 0)
		},
		
	}
	self.armor_skins.cvc_grey = {
		name_id = "bm_askn_cvc_grey",
		desc_id = "bm_askn_cvc_grey_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/cvc",
		base_gradient = {
			[2] = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_002_c_df"),
			[3] = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_002_df")
		},
		pattern_tweak = {
			[3] = Vector3(2.82853, 0, 1)
		},
		uv_scale = {
			[3] = Vector3(9.32087, 11.1325, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(-0.320768, 1.37938, 0)
		},
		
	}
	self.armor_skins.cvc_navy_blue = {
		name_id = "bm_askn_navy_blue",
		desc_id = "bm_askn_navy_blue_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/cvc",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cvc/base_gradient/base_cvc_008_df")
		},
		pattern_tweak = {
			[3] = Vector3(2.82853, 0, 1)
		},
		uv_scale = {
			[3] = Vector3(9.32087, 11.1325, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(-0.320768, 1.37938, 0)
		},
		
	}
	self.armor_skins.drm_tree_stump = {
		name_id = "bm_askn_drm_tree_stump",
		desc_id = "bm_askn_drm_tree_stump_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_001_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_001_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
		},
		pattern_tweak = {
			[3] = Vector3(3.11472, 0, 1)
		},
		pattern_pos = {
			[3] = Vector3(0, 0.37825, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_gray_raider = {
		name_id = "bm_askn_drm_gray_raider",
		desc_id = "bm_askn_drm_gray_raider_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_004_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_002_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_003_df")
		},
		pattern_tweak = {
			[2] = Vector3(1.87455, 0, 1),
			[3] = Vector3(3.49631, 0, 1)
		},
		pattern_pos = {
			[2] = Vector3(-0.0796563, 0.111138, 0),
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_desert_twilight = {
		name_id = "bm_askn_drm_desert_twilight",
		desc_id = "bm_askn_drm_desert_twilight_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_002_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/bah/pattern_gradient/gradient_bah_002_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_pixel_camo_df")
		},
		pattern_tweak = {
			[3] = Vector3(4.25948, 0, 1)
		},
		pattern_pos = {
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_navy_breeze = {
		name_id = "bm_askn_drm_navy_breeze",
		desc_id = "bm_askn_drm_navy_breeze_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_004_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_crime_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_007_df")
		},
		pattern_tweak = {
			[2] = Vector3(1.87455, 0, 1),
			[3] = Vector3(3.16242, 0, 1)
		},
		pattern_pos = {
			[2] = Vector3(-0.0796563, 0.111138, 0),
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[2] = Vector3(15.5653, 15.5663, 1),
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[2] = Vector3(0.222614, 0.924553, 0.049451),
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_woodland_tech = {
		name_id = "bm_askn_drm_woodland_tech",
		desc_id = "bm_askn_drm_woodland_tech_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_003_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/pattern_gradient/gradient_drm_002_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_pixel_camo_df")
		},
		pattern_tweak = {
			[2] = Vector3(1.87455, 0, 1),
			[3] = Vector3(3.49631, 0, 1)
		},
		pattern_pos = {
			[2] = Vector3(-0.0796563, 0.111138, 0),
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_khaki_eclipse = {
		name_id = "bm_askn_drm_khaki_eclipse",
		desc_id = "bm_askn_drm_khaki_eclipse_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_006_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_001_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_001_df")
		},
		pattern_tweak = {
			[3] = Vector3(3.11472, 0, 1)
		},
		pattern_pos = {
			[3] = Vector3(0, 0.37825, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_desert_tech = {
		name_id = "bm_askn_drm_desert_tech",
		desc_id = "bm_askn_drm_desert_tech_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[2] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_004_df"),
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_007_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/pattern_gradient/gradient_drm_001_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_006_df")
		},
		pattern_tweak = {
			[2] = Vector3(1.87455, 0, 1),
			[3] = Vector3(3.49631, 0, 1)
		},
		pattern_pos = {
			[2] = Vector3(-0.0796563, 0.111138, 0),
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_misted_grey = {
		name_id = "bm_askn_drm_misted_grey",
		desc_id = "bm_askn_drm_misted_grey_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_008_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/pattern_gradient/gradient_drm_002_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/sputnik/pattern/pattern_pixel_camo_df")
		},
		pattern_tweak = {
			[3] = Vector3(3.49631, 0, 1)
		},
		pattern_pos = {
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_khaki_regular = {
		name_id = "bm_askn_drm_khaki_regular",
		desc_id = "bm_askn_drm_khaki_regular_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_009_df")
		},
		pattern_gradient = {
			[3] = Idstring("units/payday2_cash/safes/cf15/pattern_gradient/gradient_cf15_005_df")
		},
		pattern_tweak = {
			[3] = Vector3(3.49631, 0, 1)
		},
		pattern_pos = {
			[3] = Vector3(0.607203, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
	self.armor_skins.drm_somber_woodland = {
		name_id = "bm_askn_drm_somber_woodland",
		desc_id = "bm_askn_drm_somber_woodland_desc",
		free = true,
		unlocked = true,
		ignore_cc = true,
		rarity = "uncommon",
		reserve_quality = false,
		steam_economy = false,
		texture_bundle_folder = "cash/safes/drm",
		base_gradient = {
			[2] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_004_df"),
			[3] = Idstring("units/payday2_cash/safes/drm/base_gradient/base_drm_010_df")
		},
		pattern_gradient = {
			[2] = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df"),
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern_gradient/gradient_grunt_010_df")
		},
		pattern = {
			[3] = Idstring("units/payday2_cash/safes/grunt/pattern/grunt_pattern_007_df")
		},
		pattern_tweak = {
			[2] = Vector3(1.87455, 0, 1),
			[3] = Vector3(3.49631, 0, 1)
		},
		pattern_pos = {
			[2] = Vector3(-0.0796563, 0.111138, 0),
			[3] = Vector3(0.721679, 0.988791, 0)
		},
		uv_scale = {
			[3] = Vector3(15.5653, 15.5663, 1)
		},
		uv_offset_rot = {
			[3] = Vector3(0.222614, 0.924553, 0.049451)
		},
		
	}
end)