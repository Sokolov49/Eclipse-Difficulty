local scripted_enemy = Eclipse.scripted_enemy
local preferred = Eclipse.preferred
local hard_and_above, overkill_and_above = Eclipse.utils.diff_threshold()

local cop_1 = scripted_enemy.cop_1
local cop_2 = scripted_enemy.cop_2
local cop_3 = scripted_enemy.cop_3

local enabled = {
	values = {
		enabled = true,
	},
}
local disabled = {
	values = {
		enabled = false,
	},
}
local vault_spawn = {
	values = {
		interval = 45,
	},
	groups = preferred.no_cops_agents_shields_bulldozers,
}
local roof_spawn_1 = {
	values = {
		interval = 45,
	},
	groups = preferred.no_cops_agents,
}
local roof_spawn_2 = {
	values = {
		interval = 25,
	},
	groups = preferred.no_cops_agents,
}
return {
	[103969] = {
		reinforce = {
			{
				name = "atrium1",
				force = 2,
				position = Vector3(-4000, -2200, 750),
			},
			{
				name = "atrium2",
				force = 2,
				position = Vector3(-2750, -2200, 750),
			},
			{
				name = "atrium3",
				force = 2,
				position = Vector3(-2750, -1000, 750),
			},
			{
				name = "atrium4",
				force = 2,
				position = Vector3(-4000, -1000, 750),
			},
		},
	},
	[101342] = {
		reinforce = {
			{
				name = "vault_entrance",
				force = 3,
				position = Vector3(-3250, -2850, 0),
			},
			{
				name = "atrium_lower1",
				force = 3,
				position = Vector3(-3800, -800, 400),
			},
			{
				name = "atrium_lower2",
				force = 3,
				position = Vector3(-2700, -800, 400),
			},
		},
	},
	-- enable pretty much all of the spawnpoints on the map from the very beginning, except those in the vault
	-- should be impossible to spawncamp the heist that way
	[104385] = enabled,
	[104386] = enabled,
	[104387] = enabled,
	[104388] = enabled,
	[104389] = enabled,
	[103084] = enabled,
	[104207] = enabled,
	[104210] = enabled,
	[104211] = enabled,
	[104354] = enabled,
	[104355] = enabled,
	[104356] = enabled,
	[104357] = enabled,
	[104358] = enabled,
	[104372] = enabled,
	[104373] = enabled,
	[104374] = enabled,
	[104823] = enabled,
	[104887] = enabled,
	-- disable the enemy_prefered_remove's so that all spawnpoints stay enabled throughout the heist
	[100875] = disabled,
	[102386] = disabled,
	[104361] = disabled,
	[104375] = disabled,
	[102191] = disabled,
	[104390] = disabled,
	[104886] = disabled,
	-- disable endless
	[101967] = disabled,
	[102061] = disabled,
	-- disable atrium snipers on startup
	[100000] = {
		on_executed = {
			{ id = 400077, delay = 3 },
		},
	},
	-- delay the elevator spawn
	-- trigger the 3 cloakers event
	-- enable autrium snipers
	[100429] = {
		on_executed = {
			{ id = 102128, delay = 45 },
			{ id = 102196, delay = 10 },
			{ id = 400076, delay = 0 },
		},
	},
	-- replace guards in elevator with beat cops
	[100104] = {
		values = {
			enemy = cop_1,
			participate_to_group_ai = true,
		},
	},
	[101787] = {
		values = {
			enemy = cop_1,
			participate_to_group_ai = true,
		},
	},
	[102812] = {
		values = {
			enemy = cop_2,
			participate_to_group_ai = true,
		},
	},
	[102813] = {
		values = {
			enemy = cop_2,
			participate_to_group_ai = true,
		},
	},
	[102814] = {
		values = {
			enemy = cop_3,
			participate_to_group_ai = true,
		},
	},
	-- spawn dozer and 2 tasers on overkill above (comes a bit later after beat cops)
	[102128] = {
		on_executed = {
			{ id = 400061, delay = 40 },
			{ id = 400062, delay = 40 },
			{ id = 400063, delay = 40 },
		},
	},
	[102167] = {
		values = {
			elements = {
				102813,
				102812,
				102814,
				101787,
				100104,
				400061,
				400062,
				400063,
			},
		},
	},
	-- Restore 3 cloakers event from PDTH
	-- remove 2 diff checkers, trigger it on hard and above
	[102196] = {
		values = {
			enabled = hard_and_above,
		},
		on_executed = {
			{ id = 102256, remove = true },
			{ id = 102257, remove = true },
			{ id = 102198, delay = 0 },
		},
	},
	-- add cloakers to mission scripts
	[102199] = {
		on_executed = {
			{ id = 102203, remove = true },
			{ id = 102204, remove = true },
			{ id = 102205, remove = true },
			{ id = 400007, delay = 0 },
			{ id = 400008, delay = 0.8 },
			{ id = 400009, delay = 1.3 },
		},
	},
	[102200] = {
		on_executed = {
			{ id = 102206, remove = true },
			{ id = 102207, remove = true },
			{ id = 102208, remove = true },
			{ id = 400004, delay = 0 },
			{ id = 400005, delay = 0.8 },
			{ id = 400006, delay = 1.3 },
		},
	},
	[102201] = {
		on_executed = {
			{ id = 102211, remove = true },
			{ id = 400001, delay = 0 },
			{ id = 400002, delay = 0.8 },
			{ id = 400003, delay = 1.3 },
		},
	},
	--spawn roof access blockades when CFO has been found (that respawn after 70 seconds of getting killed)
	--spawn dozer and 2 shields near helipad
	[100061] = {
		on_executed = {
			{ id = 400048, delay = 0 },
			{ id = 400049, delay = 1.4 },
			{ id = 400047, delay = 1.7 },
			{ id = 400055, delay = 0 },
			{ id = 400054, delay = 1.4 },
			{ id = 400053, delay = 1.7 },
			{ id = 400066, delay = 0 },
			{ id = 400067, delay = 0 },
			{ id = 400068, delay = 0 },
		},
	},
	--Spawn escape sniper when the heli escape gets triggered (also toggle ponr)
	[104949] = {
		set_ponr_state = true,
		on_executed = {
			{ id = 400059, delay = 3 },
		},
	},
	--Spawn atrium snipers when you pick up diamonds on loud
	[105129] = {
		on_executed = {
			{ id = 400072, delay = 0 },
			{ id = 400073, delay = 3 },
		},
	},
	--Get rid of cringe turret, replace with proper ambush from PDTH
	[104103] = {
		on_executed = {
			--be gone
			{ id = 102751, remove = true },
			--spawn snipers first
			{ id = 400010, delay = 3 },
			{ id = 400011, delay = 3 },
			{ id = 400012, delay = 3 },
			{ id = 400013, delay = 3 },
			--smoke bombs
			{ id = 400079, delay = 9 },
			{ id = 400080, delay = 9.5 },
			{ id = 400081, delay = 10 },
			--spawn SWAT squads with specials
			--1st squad
			{ id = 400023, delay = 11 },
			{ id = 400024, delay = 11 },
			{ id = 400025, delay = 11 },
			{ id = 400026, delay = 11 },
			{ id = 400027, delay = 11 },
			{ id = 400028, delay = 11 },
			{ id = 400018, delay = 11 },
			--2nd squad
			{ id = 400029, delay = 18 },
			{ id = 400030, delay = 18 },
			{ id = 400031, delay = 18 },
			{ id = 400032, delay = 18 },
			{ id = 400033, delay = 18 },
			{ id = 400034, delay = 18 },
			{ id = 400019, delay = 18 },
			{ id = 400022, delay = 18 },
			--3rd squad
			{ id = 400035, delay = 30 },
			{ id = 400036, delay = 30 },
			{ id = 400037, delay = 30 },
			{ id = 400038, delay = 30 },
			{ id = 400039, delay = 30 },
			{ id = 400040, delay = 30 },
			{ id = 400020, delay = 30 },
			--4th squad
			{ id = 400041, delay = 38 },
			{ id = 400042, delay = 38 },
			{ id = 400043, delay = 38 },
			{ id = 400044, delay = 38 },
			{ id = 400045, delay = 38 },
			{ id = 400046, delay = 38 },
			{ id = 400021, delay = 38 },
		},
	},
	-- slow down vault spawnpoints
	[104822] = vault_spawn,
	[104821] = vault_spawn,
	[100723] = vault_spawn,
	[100722] = vault_spawn,
	-- slow down roof spawnpoints
	[104896] = roof_spawn_1,
	[102778] = roof_spawn_1,
	[104846] = roof_spawn_1,
	[104764] = roof_spawn_1,
	[102772] = roof_spawn_1,
	[102784] = roof_spawn_2, -- intentionally slightly lower delay for the groups that are on the other side of the roof
	[104852] = roof_spawn_2,
}
