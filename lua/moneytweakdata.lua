Hooks:PostHook(MoneyTweakData, "init", "eclipse_init", function(self)
	-- increase weapon mod costs, just because
	self.modify_weapon_cost = self._create_value_table( 4340, 325000, 10, true, 1.2 )
	self.remove_weapon_mod_cost_multiplier = self._create_value_table( 1, 1, 10, true, 1 )
	
	--increase asset prices
	self.mission_asset_cost_multiplier_by_risk = { 1.5, 3, 6, 9, 12, 15, 18 }
	
	--fuck off with 800,000$ per weapon slot, please.
	self.unlock_new_weapon_slot_value = 125000
	--its just a mask
	self.unlock_new_mask_slot_value = 80000
end)