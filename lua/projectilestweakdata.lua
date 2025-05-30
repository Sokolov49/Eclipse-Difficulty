local initproj_orig = BlackMarketTweakData._init_projectiles
function BlackMarketTweakData:_init_projectiles(tweak_data)
	initproj_orig(self, tweak_data)

	-- 45s injector cooldown
	self.projectiles.chico_injector.base_cooldown = 45
	-- 16s flask cooldown
	self.projectiles.damage_control.base_cooldown = 16

	-- remove retarded anticheat
	self.projectiles.rocket_ray_frag.time_cheat = nil
	self.projectiles.launcher_frag_m32.time_cheat = nil

	self.projectiles.smoke_screen_grenade.unlocked = true
	self.projectiles.smoke_screen_grenade.base_cooldown = nil
	
	self.projectiles.damage_control = nil
	self.projectiles.copr_ability = nil
	self.projectiles.tag_team = nil

	-- grenade amounts
	self.projectiles.frag.max_amount = 3
	self.projectiles.smoke_screen_grenade.max_amount = 3
	self.projectiles.frag_com.max_amount = 3
	self.projectiles.dada_com.max_amount = 3
	self.projectiles.dynamite.max_amount = 3
	self.projectiles.concussion.max_amount = 3
	self.projectiles.fir_com.max_amount = 3
	self.projectiles.molotov.max_amount = 3
	self.projectiles.poison_gas_grenade.max_amount = 3
	self.projectiles.wpn_gre_electric.max_amount = 3
	
	self.projectiles.frag.no_cheat_count = true
	self.projectiles.concussion.no_cheat_count = true
	self.projectiles.dynamite.no_cheat_count = true
	self.projectiles.molotov.no_cheat_count = true
	self.projectiles.wpn_prj_four.no_cheat_count = true
	self.projectiles.wpn_prj_ace.no_cheat_count = true
	self.projectiles.wpn_prj_jav.no_cheat_count = true
	self.projectiles.wpn_prj_hur.no_cheat_count = true
	self.projectiles.wpn_prj_target.no_cheat_count = true
	self.projectiles.frag_com.no_cheat_count = true
	self.projectiles.fir_com.no_cheat_count = true
	self.projectiles.dada_com.no_cheat_count = true
	self.projectiles.wpn_gre_electric.no_cheat_count = true
	self.projectiles.poison_gas_grenade.no_cheat_count = true
	self.projectiles.sticky_grenade.no_cheat_count = true

	self.projectiles.launcher_incendiary_m79 = deep_clone(self.projectiles.launcher_incendiary)
	self.projectiles.launcher_incendiary_m79.weapon_id = "gre_m79"
	
	self.projectiles.launcher_electric_m79 = deep_clone(self.projectiles.launcher_electric)
	self.projectiles.launcher_electric_m79.unit = "units/pd2_dlc_sawp/weapons/wpn_launcher_electric/wpn_launcher_electric_m32"
	self.projectiles.launcher_electric_m79.weapon_id = "gre_m79"

	self.projectiles.launcher_poison_m79 = deep_clone(self.projectiles.launcher_poison)
	self.projectiles.launcher_poison_m79.weapon_id = "gre_m79"
end
