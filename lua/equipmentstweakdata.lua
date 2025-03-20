Hooks:PostHook(EquipmentsTweakData, "init", "eclipse_init", function(self)
	--self.first_aid_kit.quantity = { 8 }
	self.trip_mine.quantity = {2}
	self.trip_mine.upgrade_name = {"trip_mine"}
	self.doctor_bag.upgrade_deploy_time_multiplier = {
		category = "doctor_bag",
		upgrade = "deploy_time_multiplier"
	}
end)
