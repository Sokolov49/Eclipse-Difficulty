Hooks:PostHook(MoneyTweakData, "init", "eclipse_init", function(self)
-- WEAPON TABLES
	self.modify_weapon_cost = self._create_value_table( 4340, 325000, 10, true, 1.2 )
	self.remove_weapon_mod_cost_multiplier = self._create_value_table( 1, 1, 10, true, 1 )
	
	--fuck off with 800,000$ per weapon slot, please.
	self.unlock_new_weapon_slot_value = 125000
end)