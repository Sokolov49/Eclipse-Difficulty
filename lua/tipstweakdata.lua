--generic tips, will be expanded upon later
function TipsTweakData:init()
	self.tips = {
		{cat_index = 1,		image = "crimenet_heists",			consoles = true, category = "op_gameplay"},
		{cat_index = 2,		image = "enemy_flashbang",			consoles = true, category = "op_gameplay"},
		{cat_index = 3,		image = "enemy_guards",				consoles = true, category = "op_gameplay"},
		{cat_index = 4,		image = "general_pagers",			consoles = true, category = "op_gameplay"},
		{cat_index = 5,		image = "general_pagers",			consoles = true, category = "op_gameplay"},
		{cat_index = 6,		image = "tactics_stealth",			consoles = true, category = "op_gameplay"},
		{cat_index = 7,		image = "general_hostages",			consoles = true, category = "op_gameplay"},
		{cat_index = 8,		image = "weapon_tripmine",			consoles = true, category = "op_gameplay"},
		{cat_index = 9,		image = "enemy_bulldozer",			consoles = true, category = "op_gameplay"},
		{cat_index = 10,	image = "general_drill",			consoles = true, category = "op_gameplay"},
		{cat_index = 11,	image = "tactics_casingmode",		consoles = true, category = "op_gameplay"},
		{cat_index = 12,	image = "general_cameras",			consoles = true, category = "op_gameplay"},
		{cat_index = 13,	image = "tactics_revive",			consoles = true, category = "op_gameplay"},
		{cat_index = 14,	image = "tactics_cover",			consoles = true, category = "op_gameplay"},
		{cat_index = 15,	image = "general_perks",			consoles = true, category = "op_gameplay"},
		{cat_index = 16,	image = "weapon_sniper",			consoles = true, category = "op_gameplay"},
		{cat_index = 17,	image = "equipment_ammobag",		consoles = true, category = "op_gameplay"},
		{cat_index = 18,	image = "weapon_explosives",		consoles = true, category = "op_gameplay"},
		{cat_index = 19,	image = "general_escapes",			consoles = true, category = "op_gameplay"},
		{cat_index = 20,	image = "general_enforcer",			consoles = true, category = "op_gameplay"},
		{cat_index = 21,	image = "tactics_stealth",			consoles = true, category = "op_gameplay"},
		{cat_index = 22,	image = "general_civilians",		consoles = true, category = "op_gameplay"},
		{cat_index = 23,	image = "general_cameras",			consoles = true, category = "op_gameplay"},
		{cat_index = 24,	image = "tactics_shooting",			consoles = true, category = "op_gameplay"},
		{cat_index = 25,	image = "general_difficulty",		consoles = true, category = "op_gameplay"},
		{cat_index = 26,	image = "tactics_headshot",			consoles = true, category = "op_gameplay"},
		{cat_index = 27,	image = "crimenet_difficulty",		consoles = true, category = "op_gameplay"},
		{cat_index = 28,	image = "enemy_flashbang",			consoles = true, category = "op_gameplay"},
		{cat_index = 29,	image = "general_wanted_poster",	consoles = true, category = "op_gameplay"},
		{cat_index = 30,	image = "general_loadout",			consoles = true, category = "op_gameplay"},
		{cat_index = 31,	image = "tactics_marking_enemies",	consoles = true, category = "op_gameplay"},
		{cat_index = 32,	image = "general_technician",		consoles = true, category = "op_gameplay"},
		{cat_index = 33,	image = "general_drill",			consoles = true, category = "op_gameplay"},
		{cat_index = 34,	image = "general_mastermind",		consoles = true, category = "op_gameplay"},
		{cat_index = 35,	image = "general_interaction",		consoles = true, category = "op_gameplay"},
		{cat_index = 36,	image = "enemy_turret",				consoles = true, category = "op_gameplay"},
		{cat_index = 37,	image = "tactics_ecm",				consoles = true, category = "op_gameplay"},
		{cat_index = 38,	image = "general_fugitive",			consoles = true, category = "op_gameplay"},
		{cat_index = 39,	image = "general_ghost",			consoles = true, category = "op_gameplay"},
		{cat_index = 40,	image = "general_skills",			consoles = true, category = "op_gameplay"},
		{cat_index = 41,	image = "tactics_cover",			consoles = true, category = "op_gameplay"},
		{cat_index = 42,	image = "tactics_objectives",		consoles = true, category = "op_gameplay"},
		{cat_index = 43,	image = "weapon_primary_secondary",	consoles = true, category = "op_gameplay"},
		{cat_index = 44,	image = "tactics_cover",			consoles = true, category = "op_gameplay"},
		{cat_index = 45,	image = "weapon_explosives",		consoles = true, category = "op_gameplay"},
		{cat_index = 46,	image = "general_heisters",			consoles = true, category = "op_gameplay"},
		{cat_index = 47,	image = "general_preplanning",		consoles = true, category = "op_gameplay"},
		{cat_index = 48,	image = "tactics_helping_up",		consoles = true, category = "op_gameplay"},
		{cat_index = 49,	image = "tactics_ecm",				consoles = true, category = "op_gameplay"},
		{cat_index = 50,	image = "general_equipment",		consoles = true, category = "op_gameplay"},
		{cat_index = 51,	image = "general_equipment",		consoles = true, category = "op_gameplay"},
		{cat_index = 52,	image = "tactics_casingmode",		consoles = true, category = "op_gameplay"},
		{cat_index = 53,	image = "general_equipment",		consoles = true, category = "op_gameplay"},
		{cat_index = 54,	image = "tactics_shooting",			consoles = true, category = "op_gameplay"},
		{cat_index = 1,		image = "general_jules",			consoles = true, category = "op_trivia"}
	}
	self.category_totals = {}

	for _, tip in ipairs(self.tips) do
		if not self.category_totals[tip.category] or self.category_totals[tip.category] < tip.cat_index then
			self.category_totals[tip.category] = tip.cat_index
		end
	end
end