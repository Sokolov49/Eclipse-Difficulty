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

function BlackMarketTweakData:get_mask_icon(mask_id, character)
	if character and mask_id == "character_locked" then
		mask_id = "balaclava" or mask_id
	end

	local guis_catalog = "guis/"
	local bundle_folder = tweak_data.blackmarket.masks[mask_id] and tweak_data.blackmarket.masks[mask_id].texture_bundle_folder

	if bundle_folder then
		guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
	end

	return guis_catalog .. "textures/pd2/blackmarket/icons/masks/" .. tostring(mask_id)
end