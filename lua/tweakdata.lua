tweak_data.hate_multipler = 1.5
tweak_data.bullet_hit_alert_radius = 300
tweak_data.footstep_alert_radius = 450
tweak_data.whisper_alert_radius = 450
tweak_data.neighbours_alert_radius_trigger = 2500
tweak_data.neighbours_trigger_delay = math.random(3, 7)
tweak_data.drill_investigate_zone_multipler = 1.25 							-- чем больше радиус проверки, тем меньше радиус шума

    -- outline/contour colors for human players and TeamAI.
	-- PDTH colors to be exact.
    local orange = Vector3( 0.2, 0.9, 0.5 )
    local green = Vector3( 0.2, 0.9, 0.5 )
    local brown = Vector3( 0.2, 0.9, 0.5 )
    local blue = Vector3( 0.2, 0.9, 0.5 )
    local team_ai = Vector3( 0.2, 0.9, 0.5 )
    tweak_data.peer_vector_colors = { blue, orange, green, brown, team_ai }
    tweak_data.peer_colors = { "mrblue", "mrorange", "mrgreen", "mrbrown", "mrai" }    

	-- these are used for name labels and the dot beside the player's name on the teammate panel in the vanilla HUD.
    tweak_data.chat_colors = {     
    Color(0.6, 0.6, 1), -- Blue/Purple/Peer1/Host.
    Color(1, 0.6, 0.6), -- Orange/Red/Peer2.
    Color(0.6, 1, 0.6), -- Green/Peer3.
    Color(1, 1, 0.6), -- Brown/Peer4.
    Color(0.2, 0.8, 1) -- Team AI.
    }
    -- preplanning colors.
    tweak_data.preplanning_peer_colors = {
        Color("ff6885A1"),
        Color("ffE06D51"),
        Color("ff66CC36"),
        Color("ff62462B")
    }

-- lock dw / ds
tweak_data.difficulty_level_locks = {
	0,
	0,
	0,
	0,
	0,
	80,
	69420,
	69420,
}

-- lower difficulty xp muls
tweak_data.experience_manager.difficulty_multiplier = {
	1.5,
	3,
	6,
	12,
	12,
	12,
}

-- remove alive player multipliers
tweak_data.experience_manager.alive_humans_multiplier = {
	[0] = 1,
	1,
	1,
	1,
	1,
}

local function create_explosive_arrow(base_arrow)
	local explosive_arrow = deep_clone(base_arrow)
	local damage = explosive_arrow.damage
	explosive_arrow.bullet_class = "InstantExplosiveBulletBase"
	explosive_arrow.damage = damage * 1.5
	explosive_arrow.remove_on_impact = true
	
	return explosive_arrow
end

local function create_poison_arrow(base_arrow)
	local poison_arrow = deep_clone(base_arrow)
	local damage = poison_arrow.damage
	poison_arrow.bullet_class = "PoisonBulletBase"
	poison_arrow.damage = damage * 0.25
	
	return poison_arrow
end

local function create_incendiary_grenade(base_grenade, class)
	local incendiary_grenade = deep_clone(base_grenade)
	local damage = incendiary_grenade.damage
	incendiary_grenade.dot_data_name = "proj_launcher_incendiary_" .. class
	incendiary_grenade.burn_duration = math.max(1, damage / 12)
	incendiary_grenade.damage = 0
	incendiary_grenade.burn_tick_period = 0.25
	incendiary_grenade.effect_name = "effects/payday2/particles/explosions/grenade_incendiary_explosion"
	
	return incendiary_grenade
end

local function create_electric_grenade(base_grenade)
	local electric_grenade = deep_clone(base_grenade)
	local damage = electric_grenade.damage
	electric_grenade.damage = 2 * damage * 0.5
	electric_grenade.range = 4 * (electric_grenade.range / 3)
	electric_grenade.projectile_trail = true
	electric_grenade.sound_event = "gl_electric_explode"

	return electric_grenade
end

local function create_poison_grenade(base_grenade, class)
	local poison_grenade = deep_clone(base_grenade)
	local damage = poison_grenade.damage
	poison_grenade.poison_gas_dot_data_name = "proj_launcher_poison_" .. class
	poison_grenade.poison_gas_range = (damage / 24) * 150
	poison_grenade.poison_gas_duration = math.max(1, damage / 8)
	poison_grenade.damage = 2 * damage * 0.25
	poison_grenade.poison_gas_fade_time = poison_grenade.poison_gas_duration * 0.2
	poison_grenade.poison_gas_tick_time = 0.5
	poison_grenade.projectile_trail = true
	
	return poison_grenade
end

-- Arrows
tweak_data.projectiles.bow_arrow = {
	damage = 48,
	launch_speed = 2500,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	push_at_body_index = 0,
}

tweak_data.projectiles.west_arrow = deep_clone(tweak_data.projectiles.bow_arrow)
tweak_data.projectiles.west_arrow.damage = 48
tweak_data.projectiles.west_arrow.name_id = "bm_west_arrow"

tweak_data.projectiles.long_arrow = deep_clone(tweak_data.projectiles.bow_arrow)
tweak_data.projectiles.long_arrow.damage = 72
tweak_data.projectiles.long_arrow.launch_speed = 3500
tweak_data.projectiles.long_arrow.adjust_z = -30

tweak_data.projectiles.elastic_arrow = deep_clone(tweak_data.projectiles.bow_arrow)
tweak_data.projectiles.elastic_arrow.damage = 72
tweak_data.projectiles.elastic_arrow.launch_speed = 3500
tweak_data.projectiles.elastic_arrow.adjust_z = -130

tweak_data.projectiles.bow_arrow_exp = create_explosive_arrow(tweak_data.projectiles.bow_arrow)
tweak_data.projectiles.west_arrow_exp = create_explosive_arrow(tweak_data.projectiles.west_arrow)
tweak_data.projectiles.long_arrow_exp = create_explosive_arrow(tweak_data.projectiles.long_arrow)
tweak_data.projectiles.elastic_arrow_exp = create_explosive_arrow(tweak_data.projectiles.elastic_arrow)

tweak_data.projectiles.bow_arrow_poison = create_poison_arrow(tweak_data.projectiles.bow_arrow)
tweak_data.projectiles.west_arrow_poison = create_poison_arrow(tweak_data.projectiles.west_arrow)
tweak_data.projectiles.long_arrow_poison = create_poison_arrow(tweak_data.projectiles.long_arrow)
tweak_data.projectiles.elastic_arrow_poison = create_poison_arrow(tweak_data.projectiles.elastic_arrow)

tweak_data.projectiles.crossbow_arrow = {
	damage = 36,
	launch_speed = 2500,
	adjust_z = 0,
	mass_look_up_modifier = 1,
	push_at_body_index = 0,
}

tweak_data.projectiles.hunter_arrow = deep_clone(tweak_data.projectiles.crossbow_arrow)
tweak_data.projectiles.hunter_arrow.damage = 24
tweak_data.projectiles.hunter_arrow.launch_speed = 2000

tweak_data.projectiles.ecp_arrow = deep_clone(tweak_data.projectiles.crossbow_arrow)
tweak_data.projectiles.ecp_arrow.damage = 24

tweak_data.projectiles.frankish_arrow = deep_clone(tweak_data.projectiles.crossbow_arrow)
tweak_data.projectiles.frankish_arrow.damage = 36

tweak_data.projectiles.arblast_arrow = deep_clone(tweak_data.projectiles.crossbow_arrow)
tweak_data.projectiles.arblast_arrow.damage = 72
tweak_data.projectiles.arblast_arrow.launch_speed = 3500

tweak_data.projectiles.crossbow_arrow_exp = create_explosive_arrow(tweak_data.projectiles.crossbow_arrow)
tweak_data.projectiles.hunter_arrow_exp = create_explosive_arrow(tweak_data.projectiles.hunter_arrow)
tweak_data.projectiles.ecp_arrow_exp = create_explosive_arrow(tweak_data.projectiles.ecp_arrow)
tweak_data.projectiles.frankish_arrow_exp = create_explosive_arrow(tweak_data.projectiles.frankish_arrow)
tweak_data.projectiles.arblast_arrow_exp = create_explosive_arrow(tweak_data.projectiles.arblast_arrow)

tweak_data.projectiles.crossbow_arrow_poison = create_poison_arrow(tweak_data.projectiles.crossbow_arrow)
tweak_data.projectiles.hunter_arrow_poison = create_poison_arrow(tweak_data.projectiles.hunter_arrow)
tweak_data.projectiles.ecp_arrow_poison = create_poison_arrow(tweak_data.projectiles.ecp_arrow)
tweak_data.projectiles.frankish_arrow_poison = create_poison_arrow(tweak_data.projectiles.frankish_arrow)
tweak_data.projectiles.arblast_arrow_poison = create_poison_arrow(tweak_data.projectiles.arblast_arrow)

tweak_data.projectiles.frag = {
	damage = 30, --96
	curve_pow = 1.6, --2
	player_damage = 4, --1
	--player_dmg_mul = 1 / 4,
	range = 650, --450
	name_id = "bm_grenade_frag",
}

tweak_data.projectiles.dada_com = {
	damage = 42,
	curve_pow = 1.2,
	player_damage = 6,
	range = 725,
	name_id = "bm_grenade_dada_com",
	sound_event = "mtl_explosion"
}

tweak_data.projectiles.dynamite = {
	damage = 50,
	curve_pow = 2,
	player_damage = 10,
	range = 850,
	name_id = "bm_grenade_frag",
	effect_name = "effects/payday2/particles/explosions/dynamite_explosion"
}

tweak_data.projectiles.fir_com = {
	damage = 3,
	curve_pow = 0.1,
	player_damage = 3,
	fire_dot_data = {
		dot_trigger_chance = 65,
		dot_damage = 25,
		dot_length = 2.1,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	},
	range = 500,
	name_id = "bm_grenade_fir_com",
	sound_event = "white_explosion",
	effect_name = "effects/payday2/particles/explosions/grenade_incendiary_explosion"
}

tweak_data.projectiles.frag_com = deep_clone(tweak_data.projectiles.frag)
tweak_data.projectiles.frag_com.name_id = "bm_grenade_frag_com"

tweak_data.projectiles.launcher_frag = {
	damage = 34, --72
	launch_speed = 1500,
	curve_pow = 1.2,
	player_damage = 8,
	player_dmg_mul = 1 / 6,
	range = 450,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "gl_explode",
	name_id = "bm_launcher_frag",
}

tweak_data.projectiles.molotov = {
	damage = 3,
	player_damage = 2,
	fire_dot_data = {
		dot_trigger_chance = 35,
		dot_damage = 2,
		dot_length = 3,
		dot_trigger_max_distance = 3000,
		dot_tick_period = 0.5
	},
	range = 75,
	burn_duration = 20,
	burn_tick_period = 0.5,
	sound_event = "molotov_impact",
	sound_event_impact_duration = 4,
	name_id = "bm_grenade_molotov",
	alert_radius = 1500,
	fire_alert_radius = 1500
}

tweak_data.projectiles.sticky_grenade = {
		damage = 42,
		curve_pow = 0.1,
		player_damage = 10,
		range = 750,
		launch_speed = 500,
		in_air_timer = 10,
		detonate_timer = 2.5,
		sweep_radius = 25,
		name_id = "bm_sticky_grenade",
		sounds = {}
}

tweak_data.projectiles.launcher_incendiary = create_incendiary_grenade(tweak_data.projectiles.launcher_frag, "heavy")
tweak_data.projectiles.launcher_electric = create_electric_grenade(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_poison = create_poison_grenade(tweak_data.projectiles.launcher_frag, "heavy")

-- GL40
tweak_data.projectiles.launcher_incendiary_m79 = create_incendiary_grenade(tweak_data.projectiles.launcher_frag, "heavy")
tweak_data.projectiles.launcher_electric_m79 = create_electric_grenade(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_poison_m79 = create_poison_grenade(tweak_data.projectiles.launcher_frag, "heavy")

-- Compact-40
tweak_data.projectiles.launcher_frag_slap = deep_clone(tweak_data.projectiles.launcher_frag)

tweak_data.projectiles.launcher_incendiary_slap = create_incendiary_grenade(tweak_data.projectiles.launcher_frag_slap, "heavy")
tweak_data.projectiles.launcher_electric_slap = create_electric_grenade(tweak_data.projectiles.launcher_frag_slap)
tweak_data.projectiles.launcher_poison_slap = create_poison_grenade(tweak_data.projectiles.launcher_frag_slap, "heavy")

-- Little Friend Underbarrel
tweak_data.projectiles.launcher_m203 = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_m203.projectile_trail = true

-- Groza Underbarrel
tweak_data.projectiles.underbarrel_m203_groza = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.underbarrel_m203_groza.projectile_trail = true

-- Piglet
tweak_data.projectiles.launcher_frag_m32 = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_m32.damage = 60

tweak_data.projectiles.launcher_incendiary_m32 = create_incendiary_grenade(tweak_data.projectiles.launcher_frag_m32, "medium")
tweak_data.projectiles.launcher_electric_m32 = create_electric_grenade(tweak_data.projectiles.launcher_frag_m32)
tweak_data.projectiles.launcher_poison_m32 = create_poison_grenade(tweak_data.projectiles.launcher_frag_m32, "medium")

-- China Puff
tweak_data.projectiles.launcher_frag_china = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_china.damage = 60

tweak_data.weapon_disable_crit_for_damage.launcher_frag_china = { explosion = false, fire = false } -- why is china puff allowed to crit lmao

tweak_data.projectiles.launcher_incendiary_china = create_incendiary_grenade(tweak_data.projectiles.launcher_frag_china, "medium")
tweak_data.projectiles.launcher_electric_china = create_electric_grenade(tweak_data.projectiles.launcher_frag_china)
tweak_data.projectiles.launcher_poison_china = create_poison_grenade(tweak_data.projectiles.launcher_frag_china, "medium")

-- Arbiter
tweak_data.projectiles.launcher_frag_arbiter = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_arbiter.damage = 48
tweak_data.projectiles.launcher_frag_arbiter.range = 300
tweak_data.projectiles.launcher_frag_arbiter.launch_speed = 6000

tweak_data.projectiles.launcher_incendiary_arbiter = create_incendiary_grenade(tweak_data.projectiles.launcher_frag_arbiter, "light")
tweak_data.projectiles.launcher_electric_arbiter = create_electric_grenade(tweak_data.projectiles.launcher_frag_arbiter)
tweak_data.projectiles.launcher_poison_arbiter = create_poison_grenade(tweak_data.projectiles.launcher_frag_arbiter, "light")

-- Basilisk
tweak_data.projectiles.launcher_frag_ms3gl = deep_clone(tweak_data.projectiles.launcher_frag)
tweak_data.projectiles.launcher_frag_ms3gl.damage = 48

tweak_data.projectiles.launcher_incendiary_ms3gl = create_incendiary_grenade(tweak_data.projectiles.launcher_frag_ms3gl, "light")
tweak_data.projectiles.launcher_electric_ms3gl = create_electric_grenade(tweak_data.projectiles.launcher_frag_ms3gl)
tweak_data.projectiles.launcher_poison_ms3gl = create_poison_grenade(tweak_data.projectiles.launcher_frag_ms3gl, "light")

tweak_data.projectiles.launcher_rocket = {
	damage = 1600,
	launch_speed = 3000,
	curve_pow = 2,
	player_damage = 1,
	player_dmg_mul = 1 / 20,
	range = 600,
	init_timer = 2.5,
	mass_look_up_modifier = 1,
	sound_event = "rpg_explode",
	name_id = "bm_launcher_rocket",
}

-- Commando 101
tweak_data.projectiles.rocket_ray_frag = deep_clone(tweak_data.projectiles.launcher_rocket)
tweak_data.projectiles.rocket_ray_frag.damage = 180
tweak_data.projectiles.rocket_ray_frag.player_dmg_mul = 1 / 4

-- cop tear gas
tweak_data.projectiles.cs_grenade_quick.damage_per_tick = 1.5
tweak_data.projectiles.cs_grenade_quick.damage_tick_period = 0.25
tweak_data.projectiles.cs_grenade_quick.radius = 385

-- FFO ponr
tweak_data.point_of_no_returns.ffo = {
	texture = "guis/textures/pd2/hud_icon_noreturnbox",
	texture_rect = {
		0,
		0,
		32,
		32,
	},
	color = Color(1, 1, 0, 0),
	timer_flash_color = Color(1, 1, 0.8, 0.2),
	attention_color = Color(1, 1, 1, 1),
	scale_box = true,
}

if _G.IS_VR then
	tweak_data.point_of_no_returns.ffo.text_id = "hud_assault_full_force_onslaught"
else
	tweak_data.point_of_no_returns.ffo.text_id = "hud_assault_full_force_onslaught_in"
end

for _, projectile in pairs(tweak_data.projectiles) do
	--[[ More noticeable explosive damage dropoff to encourage accurate shooting
	if projectile.curve_pow then
		projectile.curve_pow = 2
	end ]]--

	if projectile.player_damage and projectile.damage then
		projectile.player_damage = projectile.damage * (projectile.player_dmg_mul or 0.25)
	end
	
	--[[
	if projectile.range then
		if projectile.range >= 50 then
			projectile.range = projectile.range * 2
		end
	end ]]--
end
