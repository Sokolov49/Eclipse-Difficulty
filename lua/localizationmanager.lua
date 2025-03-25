Hooks:AddHook("LocalizationManagerPostInit", "OPSkillDesc", function()
	local self = tweak_data.upgrades
	
	local function form(var, value, mul)
		mul = mul or 100
		if var == "a" then
			return (value[1] - 1) * mul
		elseif var == "a2" then
			return ((value[2] - 1) - (value[1] - 1)) * mul
		elseif var == "b" then
			return (1 - value[1]) * mul
		elseif var == "b2" then
			return ((1 - value[2]) - (1 - value[1])) * mul
		elseif var == "c" then
			return value[1] * mul
		elseif var == "c2" then
			return (value[2] - value[1]) * mul
		elseif var == "c3" then
			return (value[3] - value[2]) * mul
		elseif var == "d" then
			return math.floor(100 - (100 / mul * value[1]))
		elseif var == "e" then
			return 100 / 8 * value[1]
		elseif var == "f" then
			return value * mul
		elseif var == "g" then
			return (1 - value) * mul
		else
			return 0
		end
	end

	local mastermind_tier5_1 = form("b2", self.values.doctor_bag.interaction_speed_multiplier)
	local mastermind_tier5_2 = form("b", self.values.doctor_bag.deploy_time_multiplier)
	local mastermind_tier6_1 = form("a", self.values.player.empowered_intimidation_mul)
	local mastermind_tier6_2 = form("c", self.values.player.passive_assets_cost_multiplier)
	local enforcer_tier3_1 = form("a2", self.values.player.passive_suppression_multiplier)
	local enforcer_tier3_2 = form("b", self.values.ammo_bag.interaction_speed_multiplier)
	local enforcer_tier5_1 = form("a", self.values.weapon.passive_damage_multiplier)
	local enforcer_tier5_2 = form("b2", self.values.ammo_bag.interaction_speed_multiplier)
	local technician_tier4_1 = form("a", self.values.weapon.passive_headshot_damage_multiplier)
	local hoxton_tier2_1 = form("c", self.values.player.damage_shake_addend, 10)
	local hoxton_tier4_1 = form("a", self.values.weapon.special_damage_taken_multiplier)
	local hoxton_tier5_1 = form("a", self.values.player.fugitive_tier_health_multiplier)
	local hoxton_tier6_1 = form("b", self.values.player.camouflage_bonus)
	
	local hostage_taker_1_a = form("a", self.values.player.civ_intimidation_mul)
	local hostage_taker_1_b = form("b", self.values.player.hostage_interaction_speed_multiplier)
	local smooth_talker_1_b = form("b", self.values.player.alarm_pager_speed_multiplier)
	local inside_man_1_a = form("b", self.values.player.assets_cost_multiplier)
	local black_marketeer_1_a = form("b", self.values.player.buy_cost_multiplier)
	local black_marketeer_1_b = form("b2", self.values.player.buy_cost_multiplier)
	local black_marketeer_2_b = form("a", self.values.player.sell_cost_multiplier)
	local dominator_1_b = form("c", self.values.player.intimidate_aura, 0.05)
	local kilmer_1_a = form("a", self.values.assault_rifle.reload_speed_multiplier)
	local kilmer_1_b = form("c", self.values.assault_rifle.move_spread_multiplier)
	local stockholm_syndrome_1_b = form("c", self.values.player.super_syndrome, 1)
	local messiah_1_a = form("c", self.values.player.messiah_revive_from_bleed_out, 1)
	local messiah_1_b = form("c", self.values.player.messiah_revive_from_bleed_out, 1)

	local pack_mule_1_a = form("a", self.values.carry.movement_speed_multiplier)
	local pack_mule_1_b = form("a", self.values.carry.throw_distance_multiplier)
	local scavenger_1_a = form("a", self.values.player.increased_pickup_area)
	local scavenger_1_b = self.loose_ammo_give_team_ratio * 100
	local scavenger_2_b = self.values.temporary.loose_ammo_give_team[1][2]
	local shades_1_a = form("b", self.values.player.flashbang_multiplier)
	local shades_1_b = 3
	local shades_2_b = form("b2", self.values.player.flashbang_multiplier)
	local shotgun_cqb_1_a = form("a", self.values.shotgun.reload_speed_multiplier)
	local shotgun_cqb_1_b = form("b", self.values.shotgun.hip_fire_spread_index_addend)
	local shotgun_cqb_2_b = form("a", self.values.shotgun.hip_rate_of_fire)
	local from_the_hip_1_a = form("a", self.values.shotgun.enter_steelsight_speed_multiplier)
	local from_the_hip_1_b = form("c", self.values.player.shotgun_shield_knock)
	local from_the_hip_2_b = form("c", self.values.player.shotgun_steelsight_shield_knock)
	local overkill_1_a = form("a", self.values.temporary.overkill_damage_multiplier[1])
	local overkill_2_a = self.values.temporary.overkill_damage_multiplier[1][2]
	local overkill_1_b = self.values.temporary.overkill_damage_multiplier[2][2] - self.values.temporary.overkill_damage_multiplier[1][2]
	local overkill_2_b = form("d", self.values.saw.enemy_slicer, 14)
	local carbon_blade_1_a = form("a", self.values.saw.lock_damage_multiplier)
	local carbon_blade_1_b = form("c", self.values.saw.consume_no_ammo_chance)
	local carbon_blade_2_b = form("a2", self.values.saw.lock_damage_multiplier)
	local carbon_blade_3_b = form("a", self.values.saw.reload_speed_multiplier)
	
	local discipline_1_b = form("c", self.values.player.interacting_damage_multiplier)
	local master_craftsman_1_a = form("a", self.values.trip_mine.explosion_size_multiplier_1)
	local master_craftsman_1_b = form("a", self.values.trip_mine.explosion_size_multiplier_2)
	local master_craftsman_2_b = form("f", self.values.player.marked_enemy_damage_mul - 1)
	local marksman_1_a = form("e", self.values.weapon.single_spread_index_addend)
	local marksman_2_a = form("b", self.values.player.recoil_not_moving_mul)
	local marksman_3_a = form("b", self.values.player.recoil_not_moving_aim_mul)
	local marksman_1_b = form("c",  self.values.player.single_shot_fire_rate_mul)
	local marksman_2_b = form("b", self.values.player.single_shot_accuracy_inc)
	local sentry_gun_1_b = form("a", self.values.sentry_gun.armor_multiplier)
	local sentry_gun_2x_1_a = form("c", self.values.sentry_gun.quantity, 2)
	local sentry_gun_2x_1_b = form("a", self.values.sentry_gun.damage_multiplier)
	local body_expertise_1_a = form("c2", self.values.weapon.automatic_head_shot_add)
	local body_expertise_2_a = form("a", self.values.temporary.single_shot_fast_reload[1])
	local body_expertise_3_a = self.values.temporary.single_shot_fast_reload[1][2]
	local body_expertise_1_b = form("c2", self.values.weapon.automatic_head_shot_add)
	local body_expertise_2_b = form("a", self.values.snp.reload_speed_multiplier)
	local iron_man_1_a = form("a", self.values.player.armor_multiplier)
	local iron_man_1_b = form("b", self.values.team.armor.regen_time_multiplier)
	local iron_man_2_b = form("c", self.values.player.passive_always_regen_armor, 1)
	
	local cat_burglar_1_a = form("b", self.values.player.fall_damage_multiplier)
	local chameleon_1_a = form("b", self.values.player.suspicion_multiplier)
	local chameleon_1_b = form("c", self.values.player.guards_cant_spot_you_in_casing, 1)
	local cleaner_1_a = form("c", self.values.player.corpse_dispose_amount, 1)
	local cleaner_2_a = self.bodybag_crate_base
	local cleaner_1_b = form("c2", self.values.player.corpse_dispose_amount, 1)
	local cleaner_2_b = form("b", self.values.player.corpse_dispose_speed_multiplier)
	local spotter_1_a = form("a", self.values.player.mark_enemy_time_multiplier)
	local silence_expert_1_a = form("b", self.values.weapon.silencer_recoil_multiplier)
	local silence_expert_2_a = form("a", self.values.weapon.silencer_enter_steelsight_speed_multiplier)
	local silence_expert_1_b = form("c", self.values.player.secondary_silencer_damage_addend, 10)
	local ecm_feedback_1_a = "50%-100%"
	local ecm_feedback_2_a = 25
	local ecm_feedback_3_a = 1.5
	local ecm_feedback_4_a = "15-20"
	local ecm_feedback_1_b = 3
	local ecm_feedback_2_b = 8
	local ecm_feedback_3_b = 25
	local ecm_feedback_4_b = 100
	local ecm_feedback_5_b = 4
	local hitman_1_a = form("a", self.values.weapon.silencer_damage_multiplier)
	local hitman_2_a = form("c", self.values.weapon.armor_piercing_chance_silencer)
	local hitman_1_b = form("a2", self.values.weapon.silencer_damage_multiplier)
	local hitman_2_b = form("c2", self.values.weapon.armor_piercing_chance_silencer)
	
	local jail_workout_1_a = (self.values.player.marked_enemy_damage_mul - 1) * 100

	local mastercraftsman_1_a = form("b", self.values.player.crafting_weapon_multiplier)
	local mastercraftsman_1_b = form("a", self.values.player.passive_xp_multiplier)
	local awareness_1_b = form("b", self.values.temporary.dmg_dampener_outnumbered_strong[1])
	
	local mr_wise_guy_1 = form("a", self.values.team.xp.multiplier)
	local mr_wise_guy_2 = form("f", self.values.player.loot_drop_multiplier[2] - 1)
	local dead_presidents_1 = form("a", self.values.player.small_loot_multiplier)
	local dead_presidents_2 = form("b", self.values.player.reduce_loose_money_exp_convertation_amount_mul)
	local good_luck_charm_1 = form("f", self.values.player.tape_loop_duration[2], 1)
	local triathlete_1 = form("a", self.values.team.stamina.multiplier)
	local triathlete_2 = form("a", self.values.player.movement_speed_multiplier)
	local joker_1 = form("a", self.values.player.convert_enemies_damage_multiplier)
	local joker_2 = 70 .."-".. 95
	local ammo_reservoir_1 = self.values.weapon.clip_ammo_increase[1]
	local ammo_reservoir_2 = 10
	local keys_under_the_carpet_1 = form("b", self.values.player.pick_lock_speed_multiplier)
	local kick_starter_1 = 50
	local fire_trap_1 = 35
	local fire_trap_2 = 6
	local hostage_situation_1 = 0.5 .."-".. 2
	local hostage_situation_2 = 8

	LocalizationManager:add_localized_strings({
		menu_awareness_desc =			"BASIC: ##$basic##\nYour movement speed is unhindered while using steel sight.\n\nACE: ##$pro##\nWhen you are surrounded by three enemies or more, you receive ##"..awareness_1_b.."%## less damage from enemies.",		
		menu_mastercraftsman_desc =		"BASIC: ##$basic##\nYour cost of weapon and mask crafting is reduced by ##"..mastercraftsman_1_a.."%##.\n\nACE: ##$pro##\nYou gain ##"..mastercraftsman_1_b.."%## more experience for completing days and jobs.",
		menu_leadership =				"Teamwork",
		menu_leadership_desc =			"BASIC: ##$basic##\nYou and your crew's weapon stability with pistols and akimbo is increased by ##10%##.\n\nACE: ##$pro##\nYou and your crew's stability with all weapons is increased by ##5%##.\n\nNOTE: Both ##BASIC## and ##ACED## versions of the skill ##will stack## with every player that has it, up to a ##maximum of 40% and 25%##.",

		menu_ecm_feedback_desc =		"BASIC: ##$basic##\nYou can interact with ECM jammers to cause a feedback loop. When interacted, the ECM jammer has a ##"..ecm_feedback_1_a.."## chance to incapacitate enemies within ##"..ecm_feedback_2_a.."## meters radius every ##"..ecm_feedback_3_a.."## seconds.\n\nECM feedback lasts ##"..ecm_feedback_4_a.."## seconds.\n\nACE: ##$pro##\nUnlocks ##"..ecm_feedback_1_b.."## Pocket ECM Device with ##"..ecm_feedback_2_b.."## second duration each.\n\nYou will instantly interact with a ECM jammer and the ECM feedback duration is increased by ##"..ecm_feedback_3_b.."%##.\n\nYour ECM jammer has a ##"..ecm_feedback_4_b.."%## chance every ##"..ecm_feedback_5_b.."## minutes to recharge its feedback ability.",
		menu_hitman_desc =				"BASIC: ##$basic##\nYou deal ##"..hitman_1_a.."%## more damage and have a ##"..hitman_2_a.."%## chance to pierce enemy armor with silenced weapons.\n\nACE: ##$pro##\nYou deal ##"..hitman_1_b.."%## more damage and have an additional ##"..hitman_2_b.."%## chance to pierce enemy armor with silenced weapons.",
		menu_silence_expert_desc =		"BASIC: ##$basic##\nYour weapon accuracy and stability with silenced weapons is increased by ##"..silence_expert_1_a.."%##. Your snap to zoom is ##"..silence_expert_2_a.."%## faster with silenced weapons.\n\nACE: ##$pro##\nAll silenced secondary weapon gain an additional ##"..silence_expert_1_b.."## damage.",
		menu_spotter_desc =				"BASIC: ##$basic##\nIncreases the duration of marked enemies by ##"..spotter_1_a.."%##.\n\nACE: ##$pro##\nUnlocks the Spotter asset in the Job Overview menu.\n\nDuring stealth, the Spotter will highlight guards for you and your crew. If stealth is not an option, the Spotter will highlight special enemies for you and your crew.",
		menu_cleaner_desc =				"BASIC: ##$basic##\n##"..cleaner_1_a.."## body bag is added to your inventory.\n\nYou can now buy a body bag asset which contains ##"..cleaner_2_a.."## body bags that can be shared with your crew.\n\nACE: ##$pro##\n##"..cleaner_1_b.."## additional body bag is added to your inventory.\n\nYou bag corpses ##"..cleaner_2_b.."%## faster.",
		menu_chameleon_desc =			"BASIC: ##$basic##\nIn casing mode, you can mark guards, cameras and your concealment is increased by ##"..chameleon_1_a.."%##.\n\nACE: ##$pro##\nIf your detection risk is ##"..chameleon_1_b.."## or below, you cannot be spotted by guards in casing mode.",
		menu_cat_burglar_desc =			"BASIC: ##$basic##\nYou take ##"..cat_burglar_1_a.."%## less damage from falling from non-lethal heights.\n\nACE: ##$pro##\nNow you can land silently when you fall from a non-lethal heights, and also you do not lose health.",

		menu_iron_man_desc =			"BASIC: ##$basic##\nYour armor is increased by ##"..iron_man_1_a.."%##.\n\nACE: ##$pro##\nThe armor recovery rate of you and your crew is increased by ##"..iron_man_1_b.."%##.\n\nYour armor will recover ##"..iron_man_2_b.."## seconds after being broken no matter what the situation.",
		menu_aggressive_shots_desc =	"BASIC: ##$basic##\nYour SMGs and Assault Rifles in single fire mode deal ##"..body_expertise_1_a.."%## headshot damage to the body.\n\nAny killing headshot will increase your reload speed by additional ##"..body_expertise_2_a.."%## for ##"..body_expertise_3_a.."## seconds. Can only be triggered by SMGs, Assault Rifles and Sniper Rifles fired in single shot fire mode.\n\nACE: ##$pro##\nYour SMGs and Assault Rifles in single fire mode deal additional ##"..body_expertise_1_b.."%## headshot damage to the body.\n\nIncreases your reload speed with sniper rifles by ##"..body_expertise_2_b.."%##.",
		menu_sentry_gun_2x_desc =		"BASIC: ##$basic##\nYou can place ##"..sentry_gun_2x_1_a.."## sentry guns instead of just one.\n\nACE: ##$pro##\nYour sentry gun damage is increased by ##"..sentry_gun_2x_1_b.."%##.\n\nUnlocks a special modified less noticeable turret with armor-piercing rounds, reduced rate of fire, and significantly increased damage.",
		menu_sentry_gun_desc =			"BASIC: ##$basic##\nUnlocks the sentry gun for you to use.\n\nACE: ##$pro##\nYour sentry gun gains ##"..sentry_gun_1_b.."%## more health and rotational speed.",
		menu_master_craftsman_desc =	"BASIC: ##$basic##\nThe radius of trip mine explosions are increased by ##"..master_craftsman_1_a.."%##.\n\nACE: ##$pro##\nThe radius of trip mine explosions are increased by additional ##"..master_craftsman_1_b.."%##.\n\nSpecial enemies marked by your trip mines take ##"..master_craftsman_2_b.."%## more damage.",
		menu_sharpshooter_beta_desc =	"BASIC: ##$basic##\nYou gain ##"..marksman_1_a.."%## weapon accuracy with all SMGs, Assault Rifles and Sniper Rifles fired in single shot fire mode.\n\nYou gain ##"..marksman_2_a.."%## stability boost when not moving and ##"..marksman_3_a.."%## when aiming for all weapons with single shot fire.\n\nACE: ##$pro##\nIncreased fire rate up to ##"..marksman_1_b.."%## and you gain a ##"..marksman_2_b.."%## accuracy bonus while aiming down sights with all SMGs, Assault Rifles and Sniper Rifles fired in single shot fire mode.",
		menu_discipline_desc =			"BASIC: ##$basic##\nYou can use steel sight while in bleedout.\n\nACE: ##$pro##\nYou take ##"..discipline_1_b.."%## less damage while interacting with things.",

		menu_carbon_blade_desc =		"BASIC: ##$basic##\nYou replace your saw blades with carbon blades, increasing your saw efficiency by ##"..carbon_blade_1_a.."%##.\n\nACE: ##$pro##\nChance to avoid wearing down the saw's blade while using it is now ##"..carbon_blade_1_b.."%##. Saws are ##"..carbon_blade_2_b.."%## more effective.\n\nReload speed of OVE9000 poratable saw increased by ##"..carbon_blade_3_b.."%##.",
		menu_overkill_desc =			"BASIC: ##$basic##\nWhenever you kill an enemy using a shotgun or the OVE9000 portable saw, you receive a ##"..overkill_1_a.."%## damage bonus that lasts ##"..overkill_2_a.."## seconds.\n\nACE: ##$pro##\nDamage boost duration is increased by additional ##"..overkill_1_b.."## seconds.\nThe damage boost now applies to all weapons. Skill must still be activated using a shotgun or the OVE9000 portable saw.\n\nYou can now saw through shields, also attacking enemies with the OVE9000 portable saw wears down the blades ##"..overkill_2_b.."%## less than before.\n\nNote: Does not apply to melee damage, throwables, grenade launchers, bows, crossbows or rocket launchers.",
		menu_from_the_hip_desc =		"BASIC: ##$basic##\nIncreases your shotgun steel sight speed by ##"..from_the_hip_1_a.."%##.\n\nACE: ##$pro##\nGives your shotgun shots a ##"..from_the_hip_1_b.."%## chance to knock down Shields when shooting them from the hip, and ##"..from_the_hip_2_b.."%## while aiming.",
		menu_shotgun_cqb_desc =			"BASIC: ##$basic##\nIncreases your shotgun reload speed by ##"..shotgun_cqb_1_a.."%##.\n\nACE: ##$pro##\nIncreases your shotgun weapon accuracy by ##"..shotgun_cqb_1_b.."%## when firing from the hip.\n\nYour rate of fire is increased by ##"..shotgun_cqb_2_b.."%## while firing from the hip with single shot Shotguns.",
		menu_scavenger_desc =			"BASIC: ##$basic##\nYour ammo box pick up range is increased by ##"..scavenger_1_a.."%##.\n\nACE: ##$pro##\nWhen you pick up ammo, you trigger an ammo pickup for ##"..scavenger_1_b.."%## of normal pickup to other players in your team. Cannot occur more than once every ##"..scavenger_2_b.."## seconds.",
		menu_pack_mule_desc =			"BASIC: ##$basic##\nYou move ##"..pack_mule_1_b.."%## faster when carrying bags.\n\nACE: ##$pro##\nYou can throw bags ##"..pack_mule_1_a.."%## further.",

		menu_pistol_beta_messiah_desc =	"BASIC: ##$basic##\nWhile in bleedout, you can revive yourself by killing an enemy. You only have ##"..messiah_1_a.."## charge.\n\nACE: ##$pro##\nYour Messiah charges are replenished whenever you use a doctor bag, one for each medic bag use.\n\nYou now have ##"..messiah_1_b.."## additional charges.",
		menu_stockholm_syndrome_desc =	"BASIC: ##$basic##\nNearby civilians have a chance of reviving you if you interact with them. Civilians reviving you have a chance of giving you ammo.\n\nACE: ##$pro##\nYour hostages will not flee when they have been rescued by law enforcers. Whenever you get into custody, your hostages will trade themselves for your safe return. This effect can occur during assaults, but only ##"..stockholm_syndrome_1_b.."## time during a heist.",
		menu_kilmer_desc =				"BASIC: ##$basic##\nIncreases your reload speed with assault rifles by ##"..kilmer_1_a.."%##.\n\nACE: ##$pro##\nYour weapon accuracy while moving with assault rifles is increased by ##"..kilmer_1_b.."%##.\n\nRun and reload - you can now reload your weapons while sprinting.",
		menu_dominator_desc =			"BASIC: ##$basic##\nNow you can intimidate an enemy during the stealth and assault. Doing so won't require you to answer their pager.\n\nACE: ##$pro##\nYou can now intimidate ##2## enemies.\n\nThe power and range of your intimidation is increased by ##"..dominator_1_b.."%##.",
		menu_control_freak_desc =		"BASIC: ##$basic##\nDistressed civilians who trying to escape or call the police are marked by a blue question mark. It gives you more time to intimidate them.\n\nACE: ##$pro##\nNoise created by you intimidates civilians.",
		menu_black_marketeer_desc =		"BASIC: ##$basic##\nReduces the cost of all your purchases by ##"..black_marketeer_1_a.."%##.\n\nACE: ##$pro##\nFurther reduces the cost of all your purchases by ##"..black_marketeer_1_b.."%## and selling items is now ##"..black_marketeer_2_b.."%## more lucrative.",
		menu_inside_man_desc =			"BASIC: ##$basic##\nReduces the asset costs in the Job Overview menu by ##"..inside_man_1_a.."%##.\n\nACE: ##$pro##\nUnlocks special Inside Man assets in the Job Overview menu.",
		menu_smooth_talker_desc =		"BASIC: ##$basic##\nYou can successfully answer ##2## additional pagers.\n\nACE: ##$pro##\nYou answer pagers ##"..smooth_talker_1_b.."%## faster.",
		menu_hostage_taker_desc =		"BASIC: ##$basic##\nCivilians remain intimidated ##"..hostage_taker_1_a.."%## longer.\n\nACE: ##$pro##\nInteraction with hostages to move them is reduced by ##"..hostage_taker_1_b.."%##.",
		
		menu_shaped_charge_desc =		"BASIC: ##$basic##\nAdds ##5## more trip mines to your inventory.\n\nACE: ##$pro##\nTrip mines can be converted to shaped charges, used to breach certain safes and doors.",
		menu_trip_miner_desc =			"BASIC: ##$basic##\nDecreases your trip mine deploy time by ##20%##.\n\nACE: ##$pro##\nAdds ##3## more trip mines to your inventory.",
		
		menu_jail_workout_desc =		"BASIC: ##$basic##\nSpecial enemies marked by you take ##"..jail_workout_1_a.."%## additional damage.\n\nACE: ##$pro##\nWhen you stand still for ##3.5## seconds in stealth, you start highlighting people around you within a ##10## meter radius.",
		
		menu_jail_workout_desc =		"BASIC: ##$basic##\nIncreases the concealment of melee weapons by ##2##.\n\nACE: ##$pro##\nIncreases the concealment of all ballistic vests by ##4##.",
		
		menu_marcus_dlc =				"Lucky Charm",
		menu_marcus_dlc_desc =			"BASIC: ##$basic##\nYour odds of getting a higher quality item during a PAYDAY loot drop are increased by ##300%##.\n\nACE: ##$pro##\nEvery second you gain a small chance to regenerate ##1%## of your total health.",

		menu_gunzerker =				"Gunzerker",
		menu_time_heals =				"Rehab",
		menu_more_blood_to_bleed =		"More Blood to Bleed",
		menu_walking_bleedout =			"Fatal Injury",
		menu_second_wind =				"Second Wind",
		menu_mastercraftsman =			"Fast Learner",
		menu_spotter =					"Spotter",
		menu_aggressive_shots =			"Body Expertise",
		menu_sentry_gun =				"Sentry Gun",
		menu_scavenger =				"Scavenger",
		menu_control_freak =			"Control Freak",
		menu_black_marketeer =			"Black Marketeer",
		menu_inside_man =				"Inside Man",
		menu_smooth_talker =			"Smooth Talker",
		menu_hostage_taker =			"Hostage Taker",
		menu_awareness =				"Shoot 'n Scoot",
		
		bm_concussion =					"Flashbang",
		bm_concussion_desc =			"If the cops can throw infinite amounts of these to burn your retinas out, so should you! \nThey may not like the taste of their own medicine, but it is their opinion and your choice.",
		
		menu_mastermind_tier_5 =		"Increases your doctor bag interaction speed by additional ##10%##.\nDecreases your doctor bag deploy time by ##20%##.",
		menu_mastermind_tier_6 =		"The power of your intimidation is increased by ##25%##. Reduces the asset costs in the Job Overview by ##"..mastermind_tier6_2.."%##.\n\nYou now a chance of finding cable ties in ammo boxes, ##20%## in loud and a guaranteed pickup during stealth.",
		menu_menu_enforcer_tier_3 =		"Enemies are ##"..enforcer_tier3_1.."%## more easily threatened by you.\nIncreases your ammo bag interaction speed by ##"..enforcer_tier3_2.."%##.",
		menu_menu_enforcer_tier_5 =		"You do ##"..enforcer_tier5_1.."%## more damage.\nIncreases your ammo bag interaction speed by ##"..enforcer_tier5_2.."%##.",
		menu_technician_tier_4 =		"Increases your headshot damage by ##"..technician_tier4_1.."%##.",
		menu_hoxton_tier_1 =			"The damage thugs deal to you is reduced by ##10%##",
		menu_hoxton_tier_2 =			"Your steadiness is increased by ##"..hoxton_tier2_1.."##.",
		menu_hoxton_tier_3 =			"The damage thugs deal to you is reduced by ##35%##",
		menu_hoxton_tier_4 =			"You deal ##"..hoxton_tier4_1.."%## more damage against special enemies.",
		menu_hoxton_tier_5 =			"You gain ##"..hoxton_tier5_1.."%## more health.",
		menu_hoxton_tier_6 =			"You are ##"..hoxton_tier6_1.."%## less likely to be targeted by enemies.",

		menu_bonus_exp =		 					"Mr. Wise Guy",
		menu_bonus_exp_desc =		 				"Increasing experience to you and your crew.",
		menu_bonus_exp_detailed_desc =				"You gain ##"..mr_wise_guy_1.."%## more experience to you and your crew for completing days and job.",
		menu_bonus_small_money =	 				"Dead Presidents",
		menu_bonus_small_money_desc =				"Increasing value of loose items that you grab.",
		menu_bonus_small_money_detailed_desc =		"Adds ##"..dead_presidents_1.."%## more value to loose items that you pick up.",
		menu_good_luck_charm_desc =					"Interacting with a camera will cause the camera to temporarily see a pre-recording.",
		menu_good_luck_charm_detailed_desc =		"Interacting with a camera at close range will cause the camera to temporarily see a pre-recording for the next ##"..good_luck_charm_1.."## seconds so you can sneak past it.",
		menu_triathlete_desc =		 				"Increases stamina for you and your crew.",
		menu_triathlete_detailed_desc =		 		"Increases stamina for you and your crew by ##"..triathlete_1.."%##.\n\nYou gain ##"..triathlete_2.."%## additional movement speed.\n\nYou gain the ability to sprint in any direction.",
		menu_joker_desc =		 					"You can convert a non-special enemy to fight on your side.",
		menu_joker_detailed_desc =					"You can convert a non-special enemy to fight on your side. The converted enemy deals ##"..joker_1.."%## more damage and takes ##"..joker_2.."%## less damage depends of difficulty.",
		menu_ammo_reservoir_desc =		 			"Ammo bags placed by you grant the ability to shoot without depleting ammunition.",
		menu_ammo_reservoir_detailed_desc =			"Your weapon magazine capacity is increased by ##"..ammo_reservoir_1.."## rounds.\n\nAmmo bags placed by you grant players the ability to shoot without depleting their ammunition for up to ##"..ammo_reservoir_1.."## seconds after interacting with it. The more ammo players replenish, the longer duration of the effect.",
		menu_keys_under_the_carpet =				"Keys under the Carpet",
		menu_keys_under_the_carpet_desc =			"Improves lockpicking.",
		menu_keys_under_the_carpet_detailed_desc =	"You pick locks ##"..keys_under_the_carpet_1.."%## faster.\n\nYou can pick locks while in casing mode.",
		menu_infiltrator =							"Infiltrator",
		menu_infiltrator_desc =						"Improves casing mode",
		menu_infiltrator_detailed_desc =			"You can pick up items, use desktop, keycards to doors and timelocks, also answer the phone while in casing mode.",
		menu_kick_starter_desc =					"Fix a broken drill with melee hit.",
		menu_kick_starter_detailed_desc =			"Gives you the ability to fixing a broken drill or saw with a melee attack. The odd for a success is ##"..kick_starter_1.."%##. The ability can only be used once per jam.",
		menu_fire_trap_desc =						"Modifies your trip mines into incendiary.",
		menu_fire_trap_detailed_desc =				"Your trip mines now spread fire around the area of detonation for ##"..fire_trap_1.."## seconds in a ##"..fire_trap_2.."## meter diameter.",
		menu_hostage_situation =					"Hostage Situation",
		menu_hostage_situation_desc =				"Cover-up by hostages.",
		menu_hostage_situation_detailed_desc =		"You and your crew gain ##"..hostage_situation_1.."## depends on difficulty damage absorption for each hostage you have. This effect stacks with up to a maximum of ##"..hostage_situation_2.."##.\n\nNote: This skill does not stack if multiple players equip it.",
		menu_master_negotiator =					"Master Negotiator",
		menu_master_negotiator_desc =				"Slightly longer assault breaks.",
		menu_master_negotiator_detailed_desc =		"Each hostage you have will extend the Assault Break time by additional ##4 seconds## up to a max of ##16 seconds## (4 hostages).\n\nNote: This skill does not stack if multiple players equip it.",
		menu_grenadier =							"Grenadier",
		menu_grenadier_desc =						"Regain grenades from ammo pickups.",
		menu_grenadier_detailed_desc =				"You gain a ##2%## base chance to get a throwable from an ammo box.\n\nThe base chance is increased by ##0.1%## for each ammo box you pick up that does not contain a throwable.\n\nWhen a throwable has been found, the chance is reset to its base value.",	
		menu_heavyweapons =							"Muscleman",
		menu_heavyweapons_desc =					"Used to handling big guns.",
		menu_heavyweapons_detailed_desc =			"You become ##unaffected## by the speed penalty from holding special weapons.\n\n\n\n\n\n\n\n##You know who else is unaffected by special weapon movement penalty?##",	
		menu_lootmule =								"Loot Mule",
		menu_lootmule_desc =						"Sprint while carrying a bag.",
		menu_lootmule_detailed_desc =				"You can now ##sprint## while carrying a bag. The movement penalties of the bag's weight still apply.",	
	})
end)

Hooks:Add("LocalizationManagerPostInit", "OrPack_loc", function(...)				
	LocalizationManager:add_localized_strings({
		menu_crimenet =								"Crime.NET",
		menu_crimenet_offline =						"Crime.NET Offline",
		menu_specialization =						"Perk",
		menu_silencer_radius_silent =				"Noise suppression: Silent",
		menu_silencer_radius_very_small =			"Noise suppression: Very High",
		menu_silencer_radius_small =				"Noise suppression: High",
		menu_silencer_radius_medium =				"Noise suppression: Medium",
		menu_silencer_radius_high =					"Noise suppression: Low",
		menu_silencer_radius_very_high =			"Noise suppression: Very Low",
		menu_asset_lock_additional_assets =			"Requires the ''Inside Man'' Skill to unlock",
		menu_asset_lock_buy_bodybags_asset =		"Requires the ''Cleaner'' Skill to unlock",
		menu_asset_lock_buy_spotter_asset =			"Requires the ''Spotter'' Skill to unlock",
		menu_offshore_remains =						"Offshore Remains",
		bm_wp_upg_bonus_team_exp_money_p3_desc =	"+5% Experience & money reward for you and your crew.",
		bm_menu_skill_locked_chico_injector =		"Requires the Uppers skill",
		bm_menu_skill_locked_pocket_ecm_jammer =	"Requires the ECM Feedback skill",
		loading_op_gameplay_title =					"Original Pack: Eclipsed Tips",
		loading_op_trivia_title =					"Original Pack: Eclipsed Trivia",
		loading_op_gameplay_1 =						"Eclipse difficulty is unlocked at level 80.",
		loading_op_gameplay_2 =						"Flashbangs don't flicker and beep before exploding, but you still can destroy them before they detonate.",
		loading_op_gameplay_3 =						"Intimidated guards don't have to answer their pagers.",
		loading_op_gameplay_4 =						"The maximum amount of pagers you can respond to is 2, but it can be increased to 4 with a skill from the Mastermind tree.",
		loading_op_gameplay_5 =						"On Hard difficulty and below, you can respond to 4 pager calls without the pager skill.",
		loading_op_gameplay_6 =						"Sprinting in stealth causes noise in a small radius around you, which can alert nearby guards and civilians. The noise can be heard through walls and some ceilings.",
		loading_op_gameplay_7 =						"In stealth, intimidated civilians' markers disappear over time so you have to stay aware and stay in control. There are skills in the Mastermind tree to help you with hostage control.",
		loading_op_gameplay_8 =						"You need a skill in the Technician tree in order to use your Trip Mines as Shaped Charges to open doors & safes.",
		loading_op_gameplay_9 =						"Bulldozers are very resilient enemies towards fire and explosives, you have to aim for their weak faceplate to take them down.",
		loading_op_gameplay_10 =					"Drills make noise which alert nearby bystanders in a 10m radius. The Technician has a skill to reduce it or make it silent completely.",
		loading_op_gameplay_11 =					"Certain Perks can improve gameplay during stealth, like allowing you to lockpick or interact with some objects while in Casing Mode.",
		loading_op_gameplay_12 =					"You can unlock Pocket ECM Jammers by getting a skill ECM Feddback ACED.",
		loading_op_gameplay_13 =					"Avoid fighting alone or in open areas, otherwise no one will be able to help you up.",
		loading_op_gameplay_14 =					"Use cover as often and as long as you can, the cops are commencing an assault against you, not the other way around.",
		loading_op_gameplay_15 =					"Perk point rate has been changed to 10,000:1. Meaning that if a contract gives less than 10,000 XP, no points will be granted.",
		loading_op_gameplay_16 =					"Sniper Rifle & Special Ammo penetration damage is reduced by 80% when shot through walls or Shields.",
		loading_op_gameplay_17 =					"You have a higher chance of surviving an assault wave if a teammate brings extra ammo.",
		loading_op_gameplay_18 =					"Weapons with Special Ammo Types like Explosive or Incendiary are more useful than Stock Ammo Type, but it makes Ammo Bags the only reliable way to replenish them.",
		loading_op_gameplay_19 =					"Before moving to a distant objective or an escape through an exposed area, make sure that your teammates have healed up and restocked on ammo.",
		loading_op_gameplay_20 =					"Enforcers can easily suppress the enemy to protect their teammates from enemy fire. Suppressed enemies cancel their current objective, have their accuracy worsened or might consider avoiding you entirely.",
		loading_op_gameplay_21 =					"Consider doing Stealth, even partially. It can help you gain a head start even if it ends up having to finish the heist loud.",
		loading_op_gameplay_22 =					"Taking hostages will cause the police to delay their next assault.",
		loading_op_gameplay_23 =					"Breaking regular cameras may cause guards to investigate.",
		loading_op_gameplay_24 =					"Return fire towards the enemy when moving across open areas, you may not hit or kill them but they will be much less accurate and allow you to safely get to your destination.",
		loading_op_gameplay_25 =					"Taking too much damage or getting downed during an assault break might cause the police to start an assault early or make them increase their efforts to take you down during an assault.",
		loading_op_gameplay_26 =					"Accuracy is rewarding.",
		loading_op_gameplay_27 =					"Undertaking a high Pay Grade contract with low Player Reputation may not grant a lot of Experience.",
		loading_op_gameplay_28 =					"Flashbangs can be heard when thrown by cops. Face away or try to destroy it before it detonates.",
		loading_op_gameplay_29 =					"Perks are reset when gaining Infamy.",
		loading_op_gameplay_30 =					"Special Weapons are unlocked by gaining 85 Reputation Level.",
		loading_op_gameplay_31 =					"A Spotter and Spycams can highlight Special Enemies during loud approach.",
		loading_op_gameplay_32 =					"Technicians can greatly improve Drills, but they can also perform area denial, long-range support and help against Special Enemies with their Sensor Mines.",
		loading_op_gameplay_33 =					"A Drill with the appropriate upgrade will attempt to restart itself shortly after being broken, but not always. If it doesn't restart itself, a Heister will have to repair it.",
		loading_op_gameplay_34 =					"A Mastermind can aid the entire team with slight bonuses, Insider access to certain Assets, Inspire or Weapon Recoil reduction.",
		loading_op_gameplay_35 =					"Inspiring a teammate speeds up their interaction speed.",
		loading_op_gameplay_36 =					"SWAT Turrets are weak to explosives.",
		loading_op_gameplay_37 =					"ECMs cause SWAT Turrets to attack fellow Police Force members instead of Heisters for as long as its active.",
		loading_op_gameplay_38 =					"The Fugitive can be supplementary for other skilltrees, but can also become its own role in the team if enough skillpoints are invested.",
		loading_op_gameplay_39 =					"A Ghost is the master of Stealth but also the master of Close-Quarters Combat and covertly doing objectives while the team distracts enemies.",
		loading_op_gameplay_40 =					"Mr. Wise Guy does stack.",
		loading_op_gameplay_41 =					"Play safe, take your time. Don't be afraid to retreat somewhere else to defend in when things are becoming difficult.",
		loading_op_gameplay_42 =					"The cops will constantly try to sabotage your objectives (Computers, Drills, Lootbags) if you leave them unattended.",
		loading_op_gameplay_43 =					"Every weapon has its own use, don't be afraid to experiment.",
		loading_op_gameplay_44 =					"Always search for a defensible location to retreat to in case if you get overwhelmed by the cops.",
		loading_op_gameplay_45 =					"Explosives have a large radius.",
		loading_op_gameplay_46 =					"Having players fulfill different roles in the team is better than having everyone try to do a little bit of everything at same time.",
		loading_op_gameplay_47 =					"Sometimes the obvious approach to an objective is not the best move.",
		loading_op_gameplay_48 =					"Provide Covering Fire to distract enemies while a teammate is being revived.",
		loading_op_gameplay_49 =					"ECM Feedback works through walls.",
		loading_op_gameplay_50 =					"If you're playing a heist which prevents you from returning to certain areas, make sure that everyone has used the deployed Medic and Ammo bags before moving on.",
		loading_op_gameplay_51 =					"When wearing lighter armor on higher difficulties, you need to be more careful and pick your fights accordingly. Your teammates can protect you with their heavier armor, while you can carry loot faster than them.",
		loading_op_gameplay_52 =					"Consider remaining in Casing Mode during stealth, you will be able to go anywhere to check things for teammates, mark guards, use Sixth-Sense in better positions or utilize your Perks.",
		loading_op_gameplay_53 =					"Don't deploy all of your equipment in one spot as you would end up without resources if you'd get cornered somewhere else.",
		loading_op_gameplay_54 =					"All weapons have a basic 25% chance to penetrate armor.",
		loading_op_trivia_1 =						"Nothing special happened in 2015 and 2016.",
		menu_prof_mod_contract =					"If you fail, the entire contract will be terminated.",
		menu_prof_mod_hostage =						"The amount of hostages is unknown during the assault.",
		menu_prof_mod_flash =						"Flashbang thrown by the enemy have no delay.",
		menu_prof_mod_inventory =					"Special equipment is not transferred if the player is taken into custody.",
		menu_achievements_teamwork_players_2_to_4 =	"2-4 Players",
		menu_cn_legend_hidden =						"##Hidden## Contracts",
		menu_cn_legend_hate =						"Hate level",
		menu_holiday_exp_bonus =					"Holiday bonus",
		menu_killed_civs_reduction_exp =			"Killed civilians penalty",
		menu_loose_money_collected_exp =			"Loose money found",
		menu_one_down_additional =					"Current wave:",
		menu_one_down_additional_2 =				"Experience increased by",
		menu_killed_civs =							"Civilians were killed! Experience reduced by ",
		menu_collected_packages =					"Gage packages found. Experience increased by ",
		menu_loose_money =							"Loose money found. Experience increased by ",
		cn_menu_contract_day =						"$stages day",
		menu_OP_title =								"Original Pack",
	})
end)