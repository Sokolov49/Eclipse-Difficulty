Hooks:PostHook(BlackMarketTweakData, "_init_masks", "eclipse_init", function(self, tweak_data)
	self.masks.character_locked.name_id = "bm_msk_balaclava"
	self.masks.character_locked.type = "helmet"
	
	self.masks.character_locked.dallas = "balaclava_dallas"
	self.masks.character_locked.wolf = "balaclava_wolf"
	self.masks.character_locked.hoxton = "balaclava_hoxton"
	self.masks.character_locked.chains = "balaclava_chains"
	self.masks.character_locked.jowi = "balaclava_john_wick"
	self.masks.character_locked.old_hoxton = "balaclava_hoxton"
	self.masks.character_locked.female_1 = "balaclava_clover"
	self.masks.character_locked.dragan = "balaclava_dragan"
	self.masks.character_locked.jacket = "balaclava_wolf"
	self.masks.character_locked.bonnie = "balaclava_dallas"
	self.masks.character_locked.sokol = "balaclava_sokol"
	self.masks.character_locked.dragon = "balaclava_dallas"
	self.masks.character_locked.bodhi = "balaclava_dallas"
	self.masks.character_locked.jimmy = "balaclava_dallas"
	self.masks.character_locked.sydney = "balaclava_sokol"
	self.masks.character_locked.wild = "balaclava_wild"
	self.masks.character_locked.chico = "balaclava_chico"
	self.masks.character_locked.max = "balaclava_dallas"
	self.masks.character_locked.joy = "balaclava_joy"
	self.masks.character_locked.myh = "balaclava_dallas"
	self.masks.character_locked.ecp_male = "balaclava_ecp_male"
	self.masks.character_locked.ecp_female = "balaclava_dallas"
	
	self.masks.balaclava_chains = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_chains/msk_balaclava_chains",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_wolf = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_wolf/msk_balaclava_wolf",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_clover = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_clover/msk_balaclava_clover",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_dallas = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_dallas/msk_balaclava_dallas",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true,
		offsets = {
			myh = {
				Vector3(0, -0.16098, -0.399472),
				Rotation(-0.30048, 2.27524, -0.30048)
			},
			ecp_female = {
				Vector3(0, -0.399472, 0),
				Rotation(-0, -0, -0)
			}
		}
	}
	self.masks.balaclava_dragan = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_dragan/msk_balaclava_dragan",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_hoxton = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_hoxton/msk_balaclava_hoxton",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_john_wick = {
		unit = "units/pd2_dlc_infamy/masks/msk_balaclava_john_wick/msk_balaclava_john_wick",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_sokol = {
		unit = "units/pd2_dlc_character_sokol/masks/msk_balaclava_sokol/msk_balaclava_sokol",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_wild = {
		unit = "units/pd2_dlc_wild/masks/msk_balaclava_wild/msk_balaclava_wild",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_chico = {
		unit = "units/pd2_dlc_chico/masks/msk_balaclava_chico/msk_balaclava_chico",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_max = {
		unit = "units/pd2_dlc_max/masks/msk_balaclava_max/msk_balaclava_max",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true
	}
	self.masks.balaclava_ecp_male = {
		unit = "units/pd2_dlc_ecp/masks/msk_balaclava_ecp_male/msk_balaclava_ecp_male",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true,
		offsets = {}
	}
	self.masks.balaclava_joy = {
		unit = "units/pd2_dlc_joy/masks/msk_balaclava_joy/msk_balaclava_joy",
		name_id = "bm_msk_balaclava",
		texture_bundle_folder = "infamous",
		type = "helmet",
		inaccessible = true,
		offsets = {
			joy = {
				Vector3(-0.16098, -0.280226, 0.316006),
				Rotation(-0, -0, 3.13382)
			}
		}
	}
end)