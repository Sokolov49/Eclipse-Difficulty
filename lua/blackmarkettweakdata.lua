Hooks:PostHook(BlackMarketTweakData, "init", "eclipse_init", function(self)
	-- nuke silent sentry gun
	self.deployables.sentry_gun_silent = nil
	
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
end)
