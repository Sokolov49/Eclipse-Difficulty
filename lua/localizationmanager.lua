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
	local hoxton_tier1_1 = form("b", self.values.player.gangster_damage_dampener)
	local hoxton_tier2_1 = form("c", self.values.player.damage_shake_addend, 10)
	local hoxton_tier3_1 = form("b2", self.values.player.gangster_damage_dampener)
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

	local mastercraftsman_1_a = form("b", self.values.player.crafting_weapon_multiplier)
	local mastercraftsman_1_b = form("a", self.values.player.passive_xp_multiplier)
	local awareness_1_b = form("b", self.values.temporary.dmg_dampener_outnumbered_strong[1])
	local thick_skin_1_a = form("a", self.values.player.tier_armor_multiplier)
	local thick_skin_1_b = form("c", self.values.player.level_2_armor_addend, 10)
	local jail_workout_1_a = (self.values.player.marked_enemy_damage_mul - 1) * 100
	local up_you_go_1_a = form("c", self.values.player.revived_health_regain_solid_amount)
	local up_you_go_2_a = form("c", self.values.player.revived_health_regain_solid_wolverine)
	local up_you_go_1_b = form("c2", self.values.player.revived_health_regain_solid_amount)
	local up_you_go_2_b = form("b", self.values.temporary.revived_damage_resist[1])
	local up_you_go_3_b = self.values.temporary.revived_damage_resist[1][2]
	local second_wind_1_a = form("a", self.values.temporary.damage_speed_multiplier[1])
	local second_wind_2_a = self.values.temporary.damage_speed_multiplier[1][2]
	local second_wind_1_b = form("c", self.values.player.level_2_dodge_addend)
	local tea_cookies_1_a = form("c", self.values.first_aid_kit.quantity, 1)
	local tea_cookies_1_b = 3
	local tea_cookies_2_b = form("c", self.values.temporary.chico_injector[1])
	local tea_cookies_3_b = self.values.temporary.chico_injector[1][2]
	local tea_cookies_4_b = form("c2", self.values.first_aid_kit.quantity, 1)
	local walking_bleedout_1_a = form("c", self.values.player.walking_bleedout_chance)
	local walking_bleedout_2_a = form("c", self.values.player.walking_bleedout_temporary_health_mul)
	local walking_bleedout_3_a = form("g", self.walking_bleedout_walk_speed_penalty)
	local walking_bleedout_4_a = form("f", self.walking_bleedout_reload_speed_penalty - 1)
	local walking_bleedout_5_a = tweak_data.player.damage.DOWNED_TIME - self.values.player.walking_bleedout_time_to_bleed[1]
	local walking_bleedout_6_a = self.walking_bleedout_time_to_fatal_state
	local walking_bleedout_1_b = form("c2", self.values.player.walking_bleedout_chance)
	local walking_bleedout_2_b = form("c", self.values.player.walking_bleedout_fak_self_revive)
	local more_blood_to_bleed_1_a = form("c2", self.values.player.walking_bleedout_temporary_health_mul)
	local more_blood_to_bleed_1_b = form("c3", self.values.player.walking_bleedout_temporary_health_mul)
	local more_blood_to_bleed_2_b = tweak_data.player.damage.DOWNED_TIME - self.values.player.walking_bleedout_time_to_bleed[2]
	local time_heals_1_a = self.values.player.walking_bleedout_ticks_to_ressurection[1]
	local time_heals_1_b = self.values.player.walking_bleedout_ticks_to_ressurection[2]
	local time_heals_2_b = form("c", self.values.player.walking_bleedout_fak_self_revive_additional)
	local akimbo_1_a = 50
	local akimbo_1_b = 25
	local akimbo_2_b = 50
	
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
		menu_tea_cookies_desc =			"BASIC: ##$basic##\nAdds ##"..tea_cookies_1_a.."## more first aid kits to your inventory.\n\nACE: ##$pro##\nUnlocks ##"..tea_cookies_1_b.."## Injectors. Activating the Injector will heal you with ##"..tea_cookies_2_b.."%## of all damage taken for ##"..tea_cookies_3_b.."## seconds.\n\nAdds ##"..tea_cookies_4_b.."## more first aid kits to your inventory.",
		menu_gunzerker_desc =			"BASIC: ##$basic##\nYou can dual wield two shotguns.\n\nACE: ##$pro##\nYou can dual wield two SMG.",
		menu_time_heals_desc =			"BASIC: ##$basic##\nIf you keep yourself alive within ##"..time_heals_1_a.."## seconds, you can revive yourself.\n\nYour movement, interaction, reload speed and bleed-out time will be gradually recovered.\n\nACE: ##$pro##\nTime to keep yourself alive is reduced to ##"..time_heals_1_b.."## seconds.\nYou can revive yourself by using First Aid Kit with additional ##"..time_heals_2_b.."%## chance.",		
		menu_more_blood_to_bleed_desc =	"BASIC: ##$basic##\nYou recieve ##"..more_blood_to_bleed_1_a.."%## more temporary health.\n\nACE: ##$pro##\nYou recieve ##"..more_blood_to_bleed_1_b.."%## even more temporary health. Maximum bleed-out time penalty is now ##"..more_blood_to_bleed_2_b.."## seconds.",		
		menu_walking_bleedout_desc =	"BASIC: ##$basic##\nWhen you lose all your health instead of being downed you have a ##"..walking_bleedout_1_a.."%## chance to survive and gain ##"..walking_bleedout_2_a.."%## temporary health, but your movement and interaction speed will be reduced by ##"..walking_bleedout_3_a.."%##, and reload speed will be reduced by ##"..walking_bleedout_4_a.."%##.\n\nYour bleed-out time will be reduced every second down to ##"..walking_bleedout_5_a.."## seconds as long as you staying alive in that state.\n\nIf you going down after ##"..walking_bleedout_6_a.."## seconds, you fall immidiatly into the fatal state without a chance to fight back while laying down.\n\nYou can revive yourself before getting down by using a medic bag.\n\nACE: ##$pro##\nYou have additional ##"..walking_bleedout_1_b.."%## chance to survive.\n\nYou can revive yourself by using First Aid Kit with ##"..walking_bleedout_2_b.."%## chance.",
		menu_up_you_go_beta_desc =		"BASIC: ##$basic##\nYou always receive ##"..up_you_go_1_a.."%## health of your total amount when you get revived.\n\nSynergy: If you have ##Berserker## skill owned, you will receive ##"..up_you_go_2_a.."%## health when you get revived.\n\nACE: ##$pro##\nYou receive ##"..up_you_go_1_b.."%## additional health when you get revived.\nYou take ##"..up_you_go_2_b.."%## less damage for ##"..up_you_go_3_b.."## seconds after being revived.",
		menu_akimbo_skill_desc =		"BASIC: ##$basic##\nYou can dual wield two pistols.\n\nDual wielded weapons have ##"..akimbo_1_a.."%## stability penalty.\n\nACE: ##$pro##\nYour stability penalty with Akimbo weapons is set to ##"..akimbo_1_b.."%## and increases the ammo capacity of your Akimbo weapons to ##"..akimbo_2_b.."%##.",
		menu_second_wind_desc =			"BASIC: ##$basic##\nWhen your armor breaks your movement speed is increased by ##"..second_wind_1_a.."%## for ##"..second_wind_2_a.."## seconds.\n\nACE: ##$pro##\nYour chance to dodge is increased by ##"..second_wind_1_b.."%## for ballistic vests.",
		menu_jail_workout_desc =		"BASIC: ##$basic##\nSpecial enemies marked by you take ##"..jail_workout_1_a.."%## additional damage.\n\nACE: ##$pro##\nWhen you stand still for ##3.5## seconds in stealth, you start highlighting people around you within a ##10## meter radius.",
		menu_thick_skin_desc =			"BASIC: ##$basic##\nYou gain an additional ##"..thick_skin_1_a.."%## more armor.\n\nACE: ##$pro##\nIncreases the armor of all ballistic vests by ##"..thick_skin_1_b.."##.",
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
		
		menu_shaped_charge_desc =		"BASIC: ##$basic##\nAdds ##3## more trip mines to your inventory.\n\nACE: ##$pro##\nTrip mines can be converted to shaped charges, used to breach certain safes and doors.",
		menu_trip_miner_desc =			"BASIC: ##$basic##\nDecreases your trip mine deploy time by ##20%##.\n\nACE: ##$pro##\nAdds ##1## more trip mine to your inventory.",

		menu_gunzerker =				"Gunzerker",
		menu_time_heals =				"Rehab",
		menu_more_blood_to_bleed =		"More Blood to Bleed",
		menu_walking_bleedout =			"Fatal Injury",
		menu_second_wind =				"Second Wind",
		menu_up_you_go_beta =			"Strong Stitches",
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
		
		menu_mastermind_tier_5 =		"Increases your doctor bag interaction speed by additional ##"..mastermind_tier5_1.."%##.\nDecreases your doctor bag deploy time by ##"..mastermind_tier5_2.."%##.",
		menu_mastermind_tier_6 =		"The power of your intimidation is increased by ##"..mastermind_tier6_1.."%##. Reduces the asset costs in the Job Overview by ##"..mastermind_tier6_2.."%##.\n\nYou now a chance of finding cable ties in ammo boxes, ##20%## in loud and a guaranteed pickup during stealth.",
		menu_menu_enforcer_tier_3 =		"Enemies are ##"..enforcer_tier3_1.."%## more easily threatened by you.\nIncreases your ammo bag interaction speed by ##"..enforcer_tier3_2.."%##.",
		menu_menu_enforcer_tier_5 =		"You do ##"..enforcer_tier5_1.."%## more damage.\nIncreases your ammo bag interaction speed by ##"..enforcer_tier5_2.."%##.",
		menu_technician_tier_4 =		"Increases your headshot damage by ##"..technician_tier4_1.."%##.",
		menu_hoxton_tier_1 =			"The damage thugs deal to you is reduced by ##"..hoxton_tier1_1.."%##",
		menu_hoxton_tier_2 =			"Your steadiness is increased by ##"..hoxton_tier2_1.."##.",
		menu_hoxton_tier_3 =			"The damage thugs deal to you is reduced by ##"..hoxton_tier3_1.."%##",
		menu_hoxton_tier_4 =			"You deal ##"..hoxton_tier4_1.."%## more damage against special enemies.",
		menu_hoxton_tier_5 =			"You gain ##"..hoxton_tier5_1.."%## more health.",
		menu_hoxton_tier_6 =			"You are ##"..hoxton_tier6_1.."%## less likely to be targeted by enemies.",

		menu_bonus_exp =		 					"Mr. Wise Guy",
		menu_bonus_exp_desc =		 				"Increasing experience to you and your crew.",
		menu_bonus_exp_detailed_desc =				"You gain ##"..mr_wise_guy_1.."%## more experience to you and your crew for completing days and job.\n\nYour chance of getting a higher quality item during a PAYDAY is increased by ##"..mr_wise_guy_2.."%##.",
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

	if Idstring("russian"):key() == SystemInfo:language():key() then
		LocalizationManager:add_localized_strings({
			menu_tea_cookies_desc =			"БАЗОВЫЙ: ##$basic##\nДобавляет ##"..tea_cookies_1_a.."## аптечки первой помощи в инвентарь.\n\nПРО: ##$pro##\nОткрывает ##"..tea_cookies_1_b.."## инъектора. Активируя инъектор, вы будете исцеляться на ##"..tea_cookies_2_b.."%## от всего получаемого урона в течение ##"..tea_cookies_3_b.."## секунд.\n\nДобавляет ещё ##"..tea_cookies_4_b.."## аптечек первой помощи в инвентарь.",
			menu_gunzerker_desc =			"БАЗОВЫЙ: ##$basic##\nОткрывает парные дробовики.\n\nПРО: ##$pro##\nОткрывает парные пистолеты-пулеметы.",
			menu_time_heals_desc =			"БАЗОВЫЙ: ##$basic##\nЕсли вы будете поддерживать себя живим на протяжении ##"..time_heals_1_a.."## секунд, то вы можете пережить падение.\n\nВаша скорость ходьбы, взаимодействия, перезарядки и время блидаута будет постепенно восстанавливатся.\n\nПРО: ##$pro##\nВремя поддерживания себя живым снижено до ##"..time_heals_1_b.."## секунд.\nАптечки первой помощи могут полностью вас вылечить с дополнительным ##"..time_heals_2_b.."%## шансом.",
			menu_more_blood_to_bleed_desc =	"БАЗОВЫЙ: ##$basic##\nВы получаете на ##"..more_blood_to_bleed_1_a.."%## больше временного здоровья.\n\nПРО: ##$pro##\nВы получаете ещё на ##"..more_blood_to_bleed_1_b.."%## больше временного здоровья.\n\nМаксимальный штраф времени в блидауте теперь ##"..more_blood_to_bleed_2_b.."## секунд.",
			menu_walking_bleedout_desc =	"БАЗОВЫЙ: ##$basic##\nС шансом ##"..walking_bleedout_1_a.."%## вы можете пережить смертельное попадание и получить ##"..walking_bleedout_2_a.."%## временного здоровья, но ваша скорость взаимодействия и передвижения снижается на ##"..walking_bleedout_3_a.."%##, а скорость перезарядки снижается на ##"..walking_bleedout_4_a.."%##.\n\nВремя блидаута снижается с каждой секундой максимум до ##"..walking_bleedout_5_a.."## секунд находясь в этом состоянии.\n\nНаходясь в этом состоянии ##"..walking_bleedout_6_a.."## секунд и более, если вас добили враги, то ваше падение становится фатальным, без возможности отстреливатся во время блидаута.\n\nИспользование медицинской сумки полностью вылечивает вас от смертельного состояния.\n\nПРО: ##$pro##\nВы получаете дополнительные ##"..walking_bleedout_1_b.."%## шанса чтобы пережить сметельное ранение.\n\nАптечки первой помощи могут полностью вас вылечить с шансом ##"..walking_bleedout_2_b.."%##.",
			menu_up_you_go_beta_desc =		"БАЗОВЫЙ: ##$basic##\nВы всегда получаете ##"..up_you_go_1_a.."%## здоровья от вашего общего количества после того, как вас подняли.\n\nСинергия: если у вас открыт навык ##Берсеркер##, тогда ваше количество здоровья будет ##"..up_you_go_2_a.."%## после того, как вас подняли.\n\nПРО: ##$pro##\nВы получаете дополнительно ##"..up_you_go_1_b.."%## здоровья после того, как вас подняли.\nВы получаете на ##"..up_you_go_2_b.."%## меньше урона в течение ##"..up_you_go_3_b.."## секунд после того, как вас подняли.",
			menu_akimbo_skill_desc =		"БАЗОВЫЙ: ##$basic##\nТеперь вы можете использовать парные пистолеты. У всего парного оружия стабильность снижена на ##"..akimbo_1_a.."%##.\n\nПРО: ##$pro##\nУ всего парного оружия стабильность снижена на ##"..akimbo_1_b.."%##, а количество их боеприпасов повышается на ##"..akimbo_2_b.."%##.",
			menu_second_wind_desc =			"БАЗОВЫЙ: ##$basic##\nКогда вы лишаетесь брони во время боя, скорость вашего передвижения увеличивается на ##"..second_wind_1_a.."%## в течение ##"..second_wind_2_a.."## секунд.\n\nПРО: ##$pro##\nПри ношении баллистических бронежилетов, шанс увернуться от вражеского огня увеличен на ##"..second_wind_1_b.."%##.",
			menu_jail_workout_desc =		"БАЗОВЫЙ: ##$basic##\nСпециальные юниты отмеченные вами получают на ##"..jail_workout_1_a.."%## больше урона.\n\nПРО: ##$pro##\nЕсли вы до поднятия тревоги стоите на месте ##3.5## секунды, не совершая никаких действий, то начнёте автоматически помечать всех людей на расстоянии в ##10## метров.",				
			menu_thick_skin_desc =			"БАЗОВЫЙ: ##$basic##\nПрочность брони увеличена ещё на ##"..thick_skin_1_a.."%##.\n\nПРО: ##$pro##\nПрочность всех баллистических бронежилетов увеличена на ##"..thick_skin_1_b.."##.",
			menu_awareness_desc =			"БАЗОВЫЙ: ##$basic##\nСкорость передвижения не изменяется, когда вы прицеливаетесь.\n\nПРО: ##$pro##\nКогда вы находитесь на средней дистанции к врагу, вы будете получать на ##"..awareness_1_b.."%## меньше урона.",
			menu_mastercraftsman_desc =		"БАЗОВЫЙ: ##$basic##\nУменьшает цену улучшения оружия и покраски масок на ##"..mastercraftsman_1_a.."%##.\n\nПРО: ##$pro##\nВы получаете ##"..mastercraftsman_1_b.."%## больше опыта при завершении дней и контрактов.",

			menu_ecm_feedback_desc =		"БАЗОВЫЙ: ##$basic##\nПозволяет взаимодействовать с генераторами помех, чтобы создать акустическую петлю. После взаимодействия, генератор может с вероятностью ##"..ecm_feedback_1_a.."## оглушать врагов в радиусе ##"..ecm_feedback_2_a.."## метров каждые ##"..ecm_feedback_3_a.."## секунды.\n\nПетля длится ##"..ecm_feedback_4_a.."## секунд.\n\nПРО: ##$pro##\nОткрывает ##"..ecm_feedback_1_b.."## Карманных генератора помех, который работает ##"..ecm_feedback_2_b.."## секунд каждый.\n\nВы моментально взаимодействуете с генератором помех. Время действия петли увеличено на ##"..ecm_feedback_3_b.."%##.\n\nГенератор помех перезаряжается с вероятностью ##"..ecm_feedback_4_b.."%## каждые ##"..ecm_feedback_5_b.."## минуты, позволяя снова включить петлю.",
			menu_hitman_desc =				"БАЗОВЫЙ: ##$basic##\nУрон любого оружия с глушителем и шанс пробить вражескую броню увеличены на ##"..hitman_1_a.."%## и ##"..hitman_2_a.."%## соответственно.\n\nПРО: ##$pro##\nУрон любого оружия с глушителем и шанс пробить вражескую броню увеличены на дополнительные ##"..hitman_1_b.."%## и ##"..hitman_2_b.."%## соответственно.",
			menu_silence_expert_desc =		"БАЗОВЫЙ: ##$basic##\nПовышает точность и стабильность оружия с установленным глушителем на ##"..silence_expert_1_a.."%##. Вы прицеливаетесь на ##"..silence_expert_2_a.."%## быстрее со всем оружием, на котором установлен глушитель.\n\nПРО: ##$pro##\nВаше вторичное оружие с установленным глушителем наносит дополнительные ##"..silence_expert_1_b.."## урона.",
			menu_spotter_desc =				"БАЗОВЫЙ: ##$basic##\nУвеличивает продолжительность пометки врагов на ##"..spotter_1_a.."%##.\n\nПРО: ##$pro##\nОткрывает активы Наблюдателя в меню задания.\n\nВо время стелса, наблюдатель будет подсвечивать охрану для вас и вашей команды. После поднятия тревоги наблюдатель будет подсвечивать специальных юнитов.",
			menu_cleaner_desc =				"БАЗОВЫЙ: ##$basic##\nВ инвентаре будет ##"..cleaner_1_a.."## мешкок с самого начала.\n\nВы можете купить мешки для трупов в меню активов для себя и команды. Актив содержит ##"..cleaner_2_a.."## мешка.\n\nПРО: ##$pro##\nВ инвентаре будет ##"..cleaner_1_b.."## дополнительный мешкок с самого начала.\n\nСкорость упаковки трупов увеличена на ##"..cleaner_2_b.."%##.",
			menu_chameleon_desc =			"БАЗОВЫЙ: ##$basic##\nВы можете подсвечивать охрану и камеры в режиме исследования. Вы на ##"..chameleon_1_a.."%## скрытнее для гражданских и врагов до тех пор, пока не наденете маску.\n\nПРО: ##$pro##\nЕсли ваша скрытность ##"..chameleon_1_b.."## или ниже, охранники не не смогут вас заподозрить в режиме исследования.",
			menu_cat_burglar_desc =			"БАЗОВЫЙ: ##$basic##\nУрон от падения с несмертельной высоты снижен на ##"..cat_burglar_1_a.."%##.\n\nПРО: ##$pro##\nПадая с несмертельной высоты вы приземляетесь бесшумно, а так же при падении вы не теряете здоровье.",

			menu_iron_man_desc =			"БАЗОВЫЙ: ##$basic##\nПоказатель брони увеличен на ##"..iron_man_1_a.."%## .\n\nПРО: ##$pro##\nУвеличивает скорость восстановления брони у вас и у напарников на ##"..iron_man_1_b.."%##.\n\nКогда вы лишитесь брони, то она восстановится через ##"..iron_man_2_b.."## секунд даже будучи под обстрелом.",
			menu_aggressive_shots_desc =	"БАЗОВЫЙ: ##$basic##\nВаши пистолеты-пулеметы и штурмовые винтовки в одиночном режиме стрельбы наносят ##"..body_expertise_1_a.."%## урона множителя попадания в голову стреляя по телу.\n\nУбийство в голову увеличивает вашу скорость перезарядки на дополнительные ##"..body_expertise_2_a.."%## в течение ##"..body_expertise_3_a.."## секунд.\n\nПРО: ##$pro##\nВаши пистолеты-пулеметы и штурмовые винтовки в одиночном режиме стрельбы наносят дополнительный ##"..body_expertise_1_b.."%## урона множителя попадания в голову стреляя по телу.\n\nУвеличивает скорость перезарядки снайперских винтовок на ##"..body_expertise_2_b.."%##.",
			menu_sentry_gun_2x_desc =		"БАЗОВЫЙ: ##$basic##\nПозволяет устанавливать ##"..sentry_gun_2x_1_a.."## турели вместо одной.\n\nПРО: ##$pro##\nУвеличивает урон, наносимый вашими турелями на ##"..sentry_gun_2x_1_b.."%##.\n\nОткрывает менее заметную, приглушённую бронебойную турель с уменьшенной скорострельностью, но значительно увеличенным уроном.",
			menu_sentry_gun_desc =			"БАЗОВЫЙ: ##$basic##\nОткрывает турель.\n\nПРО: ##$pro##\nЗдоровье и скорость вращения ваших турелей увеличено на ##"..sentry_gun_1_b.."%##.\n\nОткрывает особую модифицированную менее заметную турель с приглушённым стволом, бронебойными патронами, уменьшенной скорострельность для экономии патронов и увеличенным количеством урона.",
			menu_master_craftsman_desc =	"БАЗОВЫЙ: ##$basic##\nУвеличивает радиус поражения мин на ##"..master_craftsman_1_a.."%##.\n\nПРО: ##$pro##\nУвеличивает радиус поражения мин еще на ##"..master_craftsman_1_b.."%##.\n\nСпециальные юниты, отмеченные вашими минами, получают на ##"..master_craftsman_2_b.."%## больше урона.",
			menu_sharpshooter_beta_desc =	"БАЗОВЫЙ: ##$basic##\nВы получаете ##"..marksman_1_a.."%## точности для всех пистолетов-пулеметов, штурмовых и снайперских винтовок в режиме одиночной стрельбы.\n\nТакже вы получаете прибавку к стабильности на ##"..marksman_2_a.."%## не двигаясь и ##"..marksman_3_a.."%## при прицеливании из оружия с одиночным режимом стрельбы.\n\nПРО: ##$pro##\nУвеличена скорострельность на ##"..marksman_1_b.."%## и увеличена точность, при прицельной стрельбе на ##"..marksman_2_b.."%## из пистолетов-пулеметов, штурмовых и снайперских винтовок в режиме одиночной стрельбы.",
			menu_discipline_desc = 			"БАЗОВЫЙ: ##$basic##\nВы можете прицеливаться, когда упали.\n\nПРО: ##$pro##\nПолучаемый урон снижен на ##"..discipline_1_b.."%##, если вы взаимодействуете с каким-либо предметом.",

			menu_carbon_blade_desc =		"БАЗОВЫЙ: ##$basic##\nВы заменяете лезвия вашей пилы на углеродные, повышая тем самым её эффективность на ##"..carbon_blade_1_a.."%##.\n\nПРО: ##$pro##\nЛезвия пилы при использовании не изнашиваются с шансом ##"..carbon_blade_1_b.."%##. Лезвия становятся на ##"..carbon_blade_2_b.."%## эффективнее.\n\nСкорость смены лезвий портативной пилы OVE9000 увеличивается на ##"..carbon_blade_3_b.."%##.",
			menu_overkill_desc =			"БАЗОВЫЙ: ##$basic##\nПосле убийства врага с помощью дробовика или пилы OVE9000, вы будете наносить на ##"..overkill_1_a.."%## больше урона в течение ##"..overkill_2_a.."## секунд.\n\nПРО: ##$pro##\nУвеличено время действия навыка на дополнительные ##"..overkill_1_b.."## секунд. Бонус к урону теперь применяется ко всему оружию. Навык должен быть активирован использованием дробовика или пилы OVE9000.\n\nТеперь вы можете прорезать щитовиков своей пилой OVE9000, а также атака врагов портативной пилой изнашивает лезвия на ##"..overkill_2_b.."%## меньше.\n\nВнимание: действие навыка не распространяется на гранатомёты, метательное, луки и арбалеты.",
			menu_from_the_hip_desc =		"БАЗОВЫЙ: ##$basic##\nПовышает скорость прицеливания из дробовиков на ##"..from_the_hip_1_a.."%##.\n\nПРО: ##$pro##\nПри стрельбе по щитовику из дробовика от бедра, у вас есть шанс отбросить его назад с шансом ##"..from_the_hip_1_b.."%## и ##"..from_the_hip_2_b.."%## при прицеливании.",
			menu_shotgun_cqb_desc =			"БАЗОВЫЙ: ##$basic##\nПовышает скорость перезарядки дробовиков на ##"..shotgun_cqb_1_a.."%##.\n\nПРО: ##$pro##\nПовышает точность вашего дробовика при стрельбе от бедра на ##"..shotgun_cqb_1_b.."%##.\n\nВаша скорострельность будет увеличена на ##"..shotgun_cqb_2_b.."%## при стрельбе от бедра из дробовиков с одиночным режимом стрельбы.",
			menu_scavenger_desc =			"БАЗОВЫЙ: ##$basic##\nРадиус, с которого вы можете поднимать патроны увеличен на ##"..scavenger_1_a.."%##.\n\nПРО: ##$pro##\nКогда вы собираете боеприпасы, оставленные врагами, ваши напарники будут получать ##"..scavenger_1_b.."%## от собранного вами количества.\n\nНавык срабатывает только один раз за ##"..scavenger_2_b.."## секунд.",
			menu_pack_mule_desc =			"БАЗОВЫЙ: ##$basic##\nПозволяет передвигаться с сумкой быстрее на ##"..pack_mule_1_b.."%##.\n\nПРО: ##$pro##\nПозволяет кидать сумки на ##"..pack_mule_1_a.."%## дальше.",

			menu_pistol_beta_messiah_desc =	"БАЗОВЫЙ: ##$basic##\nВы самостоятельно поднимаетесь на ноги, если убьёте врага. Навык срабатывает только ##"..messiah_1_a.."## раз.\n\nПРО: ##$pro##\nВы сможете снова использовать навык, если воспользуетесь медицинской сумкой, но только один заряд за каждое использование медицинской сумки.\n\nНавык срабатывает еще ##"..messiah_1_b.."## раза.",
			menu_stockholm_syndrome_desc =	"БАЗОВЫЙ: ##$basic##\nПри взаимодействии с гражданскими есть вероятность того, что он согласится вас поднять. Гражданские, поднявшие вас, могут дать вам патроны.\n\nПРО: ##$pro##\nВаши заложники не станут убегать с места, если были освобождены полицией. Как только вы попадёте в тюрьму, они попытаются обменять себя на вас. Этот эффект может сработать даже во время полицейского штурма, но только ##"..stockholm_syndrome_1_b.."## раз.",
			menu_kilmer_desc =				"БАЗОВЫЙ: ##$basic##\nУвеличивает скорость перезарядки штурмовых винтовок на ##"..kilmer_1_a.."%##.\n\nПРО: ##$pro##\nПонижает множитель разброса штурмовых во время движения на ##"..kilmer_1_b.."%##.\n\nВы можете перезаряжать оружие во время спринта.",
			menu_dominator_desc =			"БАЗОВЫЙ: ##$basic##\nВы можете брать врагов в заложники во время скрытного прохождения и во время штурма.\n\nПРО: ##$pro##\nВы можете брать ##2## врагов в заложники.\n\nДистанция, с которой вы можете брать заложников увеличена на ##"..dominator_1_b.."%##, как и сила вашего убеждения.",
			menu_control_freak_desc =		"БАЗОВЫЙ: ##$basic##\nИспуганые гражданские которые пытаются сбежать или позвонить в полицию отмечаются синим вопросительным знаком. Это дает больше времени чтобы запугать их.\n\nПРО: ##$pro##\nШум, издаваемый вами, устрашает гражданских.",
			menu_black_marketeer_desc =		"БАЗОВЫЙ: ##$basic##\nУменьшает цены на все ваши покупки на ##"..black_marketeer_1_a.."%##.\n\nПРО: ##$pro##\nУменьшает цены на все ваши покупки еще на ##"..black_marketeer_1_b.."%## и продажа предметов на ##"..black_marketeer_2_b.."%## выгоднее.",
			menu_inside_man_desc =			"БАЗОВЫЙ: ##$basic##\nУменьшает цены в меню активов на ##"..inside_man_1_a.."%##.\n\nПРО: ##$pro##\nОткрывает особые активы Своего человека.",
			menu_smooth_talker_desc =		"БАЗОВЫЙ: ##$basic##\nВы можете ответить на ##2## дополнительных пейджера.\n\nПРО: ##$pro##\nВы отвечаете на пейджер ##"..smooth_talker_1_b.."%## быстрее.",
			menu_hostage_taker_desc =		"БАЗОВЫЙ: ##$basic##\nГражданские остаются запуганными на ##"..hostage_taker_1_a.."%## дольше.\n\nПРО: ##$pro##\nВзаимодейстие с заложниками для их перемещения снижено на ##"..hostage_taker_1_b.."%##.",

			menu_gunzerker =				"Шизострел",
			menu_time_heals =				"Реабилитация",
			menu_more_blood_to_bleed =		"Больше крови для истекания",
			menu_walking_bleedout =			"Смертельная травма",
			menu_second_wind =				"Второй шанс",
			menu_up_you_go_beta =			"Прочные швы",
			menu_mastercraftsman =			"Прилежный ученик",
			menu_spotter =					"Наблюдатель",
			menu_aggressive_shots =			"Хирургическая точность",
			menu_sentry_gun =				"Турель",
			menu_scavenger =				"Мародер",
			menu_control_freak =			"Контроль толпы",
			menu_black_marketeer =			"Торговец с черного рынка",
			menu_inside_man =				"Свой Человек",
			menu_smooth_talker =			"Пустозвон",
			menu_hostage_taker =			"Захват заложников",
			menu_awareness =				"Стрельба с перебежками",

			menu_mastermind_tier_5 =		"Увеличивает скорость взаимодействия с медицинскими сумками на ##"..mastermind_tier5_1.."%##.\nУвеличивает скорость для установки медицинских сумок на ##"..mastermind_tier5_2.."%##.",
			menu_mastermind_tier_6 =		"Увеличивает силу запугивания на ##"..mastermind_tier6_1.."%##. Снижает стоимость поддержки в меню подготовки на ##"..mastermind_tier6_2.."%##.\n\nВы можете подбирать кабельные стяжки за каждую подобраную коробку с патронами с шансом ##20%##, а во время скрытного прохождения получаете гарантировано одну.",
			menu_menu_enforcer_tier_3 =		"Вы на ##"..enforcer_tier3_1.."%## легче подавляете врагов.\nУскоряет взаимодействие с сумкой патронов на ##"..enforcer_tier3_2.."%##.",
			menu_menu_enforcer_tier_5 =		"Вы наносите на ##"..enforcer_tier5_1.."%## больше урона.\nУскоряет взаимодействие с сумкой патронов на ##"..enforcer_tier5_2.."%##.",
			menu_technician_tier_4 =		"Урон от попадания в голову увеличен на ##"..technician_tier4_1.."%##.",
			menu_hoxton_tier_1 =			"Урон от бандитов снижен на ##"..hoxton_tier1_1.."%##",
			menu_hoxton_tier_2 =			"Стойкость увеличена на ##"..hoxton_tier2_1.."## пунктов.",
			menu_hoxton_tier_3 =			"Урон от бандитов снижен на ##"..hoxton_tier3_1.."%##",
			menu_hoxton_tier_4 =			"Вы наносите на ##"..hoxton_tier4_1.."%## больше урона специальным юнитам.",
			menu_hoxton_tier_5 =			"Здоровье увеличено на ##"..hoxton_tier5_1.."%##.",
			menu_hoxton_tier_6 =			"Вы на ##"..hoxton_tier6_1.."%## менее приоритетная цель для врагов.",
			
			menu_bonus_exp =			 				"Мистер Умник",
			menu_bonus_exp_desc =		 				"Увеличивает количество опыта вам и вашей команде.",
			menu_bonus_exp_detailed_desc =				"Вы получаете ##"..mr_wise_guy_1.."%## больше опыта вам и вашей команде при завершении дней и контрактов.\n\nШанс получить предмет высокого качества при завершении контракта увеличивается на ##"..mr_wise_guy_2.."%##.",
			menu_bonus_small_money =		 			"Мертвые президенты",
			menu_bonus_small_money_desc =				"Увеличивает ценность мелкой добычи которую вы забрали.",
			menu_bonus_small_money_detailed_desc =		"Ценность мелкой добычи увеличивается на ##"..dead_presidents_1.."%##.\n\nСнижено количество денег требуемых для перечисления в бонусный опыт ##"..dead_presidents_2.."%## когда вы нашли мелкую добычу.",
			menu_good_luck_charm_desc =					"Вы можете зациклить изображение камеры тем самым отключить её.",
			menu_good_luck_charm_detailed_desc =		"Вы можете зациклить изображение камеры на ##"..good_luck_charm_1.."## секунд и тем самым отключить её.",
			menu_triathlete_desc =		 				"Увеличивает выносливость вам и вашей команде.",
			menu_triathlete_detailed_desc =		 		"Увеличивает выносливость вам и вашей команде на ##"..triathlete_1.."%##.\n\nСкорость передвижения увеличена на ##"..triathlete_2.."%##.\n\nПозволяет бегать в любом направлении.",
			menu_joker_desc =		 					"Взятый в заложники враг может сражаться на вашей стороне.",
			menu_joker_detailed_desc =					"Вы можете перевести одного врага на свою сторону. Навык работает только после поднятия тревоги.\n\nПерешедшие противники наносят на ##"..joker_1.."%## больше урона и будет получать на ##"..joker_2.."%## меньше урона в зависимости от сложности.",
			menu_ammo_reservoir_desc =		 			"Вы и ваша команда можете стрелять не расходуя боеприпасы используя ваши патроны.",
			menu_ammo_reservoir_detailed_desc =			"Увеличивает вместительность магазинов вашего оружия ещё на ##"..ammo_reservoir_1.."## патронов.\n\nСразу после установки и использования сумки с патронами, вы и ваша команда можете стрелять не расходуя боеприпасы в течение ##"..ammo_reservoir_2.."## секунд. Чем больше амуниции вы восстановите из сумки, тем дольше будет эффект непрерывной стрельбы.",
			menu_keys_under_the_carpet =				"Ключи под ковриком",
			menu_keys_under_the_carpet_desc =			"Улучшает взлом замков.",
			menu_keys_under_the_carpet_detailed_desc =	"Вы взламываете замки на ##"..keys_under_the_carpet_1.."%## быстрее.\n\nВы можете взламывать замки в режиме исследования.",
			menu_infiltrator =							"Инфильтратор",
			menu_infiltrator_desc =						"Улучшает режим исследования.",
			menu_infiltrator_detailed_desc =			"Вы можете подбирать предметы, использовать ключ-карты к дверям и временным замкам и взаимодействовать с компьютерами в режиме исследования.",
			menu_kick_starter_desc =					"Починка дрели ударом по ней.",
			menu_kick_starter_detailed_desc =			"Теперь вы можете починить дрель или пилу, ударив по ним оружием ближнего боя. У вас есть ##"..kick_starter_1.."%## шанс, если та сломается. Данный навык срабатывает только один раз за поломку дрели или пилы.",
			menu_fire_trap_desc =						"Модифицирует ваши мины в зажигательные.",
			menu_fire_trap_detailed_desc =				"Ваши мины оставляют на месте огненную ловушку в течение ##"..fire_trap_1.."## секунд в ##"..fire_trap_2.."## метровом радиусе.",
			menu_hostage_situation =					"Ситуация с заложниками",
			menu_hostage_situation_desc =				"Прикрытие с помощью заложников.",
			menu_hostage_situation_detailed_desc =		"Вы и ваши напарники будете получать в зависимости от сложности на ##"..hostage_situation_1.."## меньше урона за каждого связанного заложника. Данный эффект складывается до максимума в ##"..hostage_situation_2.."## заложников.",

		})
	end
end)

Hooks:Add("LocalizationManagerPostInit", "OrPack_loc", function(...)				
	LocalizationManager:add_localized_strings({
		menu_crimenet =								"Crime.NET",
		menu_crimenet_offline =						"Crime.NET Offline",
		menu_specialization =						"Perk",
		OP_credits_help = 							"Meet the Original Pack Crew",
		OP_credits = 								"Credits",
		menu_OP_discord_desc = 						"Join Original Pack Discord server",
		menu_OP_discord = 							"Discord",
		menu_OP_changelog =							"Changelog",
		menu_OP_changelog_desc =					"Changelog and update history.",
		menu_find_game =							"Find Game",
		menu_find_game_desc =						"Join to any lobby.",
		menu_max_progress =							"Max Progress",
		menu_max_progress_desc =					"Switch to the Maximum Progress mode.",
		menu_normal_progress =						"Normal Progress",
		menu_normal_progress_desc =					"Back to normal progress.",
		menu_max_progress_dialog_title =			"Switching to Max Progress Mode",
		menu_max_progress_dialog_message =			"Max Progress mode uses a different save file.\n\nSo everything that you gain in Normal Mode will be safe, you can come back any time.\nGame will restart on its own as soon as you confirm switching to Max Progress.\n\nDo you want switch to Max Progress Mode?",
		menu_normal_progress_dialog_title =			"Switching to Normal Progress",
		menu_normal_progress_dialog_message =		"Game will restart on its own as soon as you confirm switching to Normal Progress.\n\nDo you want switch to Normal Progress?",
		dialog_what_is_max_progress =				"What is Max Progress Mode?",
		dialog_what_is_max_progress_text =			"In Max Progress Mode you get all items, weapons, masks, materials, and etc. for free. One for each type of item. (Only those items that you have from DLC)\nMaximum Infamy rank and 100 level.\nThis mode uses a different save file, which allows you to switch between the max and normal modes without spoiling your progress and also has its own progress of achievements. But you can only play with those players who also have the Max Progress enabled.\n\nStarter money kit:\nOffshore Account - $1.000.000.000\nSpending cash - $150.000.000\nContinental coins - © 250.000\n\nDo you want switch to Max Progress Mode?",
		menu_always_show_body_bags_title =			"Show body bags counter",
		menu_always_show_accuracy_title =			"Show accuracy counter",
		menu_always_show_kills_title =				"Show kill counter",
		heist_arm =									"Armored Transport",
		menu_challenge_pink_panther_objective =		"On day 1 of the Framing Frame job, steal 9 sold paintings without being seen.",
		menu_silencer_radius_silent =				"Noise suppression: Silent",
		menu_silencer_radius_very_small =			"Noise suppression: Very High",
		menu_silencer_radius_small =				"Noise suppression: High",
		menu_silencer_radius_medium =				"Noise suppression: Medium",
		menu_silencer_radius_high =					"Noise suppression: Low",
		menu_silencer_radius_very_high =			"Noise suppression: Very Low",
		menu_asset_lock_additional_assets =			"Requires the ''Inside Man'' Skill to unlock",
		menu_asset_lock_buy_bodybags_asset =		"Requires the ''Cleaner'' Skill to unlock",
		menu_asset_lock_buy_spotter_asset =			"Requires the ''Spotter'' Skill to unlock",
		bm_menu_unlock_akimbo =						"Requires the Akimbo skill",
		bm_menu_unlock_gunzerker =					"Requires the Gunzerker skill",
		bm_menu_unlock_overpowered =				"Locked to reputation level 85",
		menu_offshore_remains =						"Offshore Remains",
		achievement_cac_15 =						"C-Forever",
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
		
	if Idstring("russian"):key() == SystemInfo:language():key() then
		LocalizationManager:add_localized_strings({
			menu_crimenet_offline =							"Crime.NET Оффлайн",
			menu_specialization =							"Перк",
			OP_credits_help = 								"Познакомтесь с командой Original Pack",
			OP_credits = 									"Титры",
			menu_OP_discord_desc = 							"Присоединяйтесь к Дискорд серверу Original Pack",
			menu_OP_discord = 								"Дискорд",
			menu_OP_changelog =								"Изменения",
			menu_OP_changelog_desc =						"Список изменений и версии которые выходили ранее.",
			menu_find_game =								"Найти игру",
			menu_find_game_desc =							"Присоединится к любому лобби.",
			menu_max_progress =								"Максимальный прогресс",
			menu_max_progress_desc =						"Переключение на максимальный прогресс, у вас будет все чего вы хотите для игры. Что-то вроде творческого режима.",
			menu_max_progress_dialog_title =				"Переключение на максимальный прогресс",
			menu_max_progress_dialog_message =				"В режиме Максимального прогресса используется другой файл сохранения.\n\nТо есть все что вы успели наиграть в обычном режиме сохранится, вы в любой момент сможете вернутся назад и продолжить с теми ресурсами которые вы успели заработать.\nИгра перезапустится самостоятельно как только вы подтвердите переход на Максимальный прогресс.\n\nВы хотите перейти в режим Максимального прогресса?",
			menu_normal_progress =							"Обычный прогресс",
			menu_normal_progress_desc =						"Вернутся назад в обычный режим.",
			menu_normal_progress_dialog_title =				"Переключение на обычный прогресс",
			menu_normal_progress_dialog_message =			"Игра перезапустится самостоятельно как только вы подтвердите переход на обычный прогресс.\n\nВы хотите перейти в обычный прогресс?",
			dialog_what_is_max_progress =					"Что такое Максимальный прогресс?",
			dialog_what_is_max_progress_text =				"Максимальный прогресс - это режим, в котором открыты все игровые предметы, оружие, маски, материалы и тд.\nВсё по одному экземпляру (Только те предметы, из DLC которых вы имеете).\nТак же вы будете максимального ранга Дурной репутации и 100 уровня.\nЭтот режим использует другой файл сохранения, что позваляет переключатся между максимальным и обычным режимами без вреда прогрессу и так же имеет свой прогресс достижений. Но играть вы сможете только с теми игроками у кого также включен Максимальный прогресс.\n\nНачальные средства:\nОфшорный счет - $1.000.000.000\nНаличные - $150.000.000\nКонтиненталь монеты - ©250.000\n\nВы хотите перейти в Максимальный прогресс?",
			menu_always_show_body_bags_title =				"Показывать мешки для трупов",
			menu_always_show_accuracy_title =				"Показывать счетчик точности",
			menu_always_show_kills_title =					"Показывать счетчик убийств",
			heist_arm =										"Транспорт",
			menu_challenge_pink_panther_objective =			"Завершите первый день контракта ''Подстава с картинами'', украв 9 картин, не поднимая тревогу.",
			menu_silencer_radius_silent =					"Подавление шума: Бесшумно",
			menu_silencer_radius_very_small =				"Подавление шума: Очень большое",
			menu_silencer_radius_small =					"Подавление шума: Большое",
			menu_silencer_radius_medium =					"Подавление шума: Среднее",
			menu_silencer_radius_high =						"Подавление шума: Слабое",
			menu_silencer_radius_very_high =				"Подавление шума: Очень слабое",
			menu_asset_lock_additional_assets =				"Требуется навык ''Свой человек''",
			menu_asset_lock_buy_bodybags_asset =			"Требуется навык ''Чистильщик''",
			menu_asset_lock_buy_spotter_asset =				"Требуется навык ''Наблюдатель''",
			bm_menu_unlock_akimbo =							"Требуется навык ''Акимбо''",
			bm_menu_unlock_gunzerker =						"Требуется навык ''Шизострел''",
			bm_menu_unlock_overpowered =					"Заблокировано до уровня репутации 85",
			menu_offshore_remains =							"Офшорный счет",
			bm_wp_upg_bonus_team_exp_money_p3_desc =		"+5% опыта и денег для вас и вашей команды",
			bm_menu_skill_locked_chico_injector =			"Требуется навык ''Колеса''",
			bm_menu_skill_locked_pocket_ecm_jammer =		"Требуется навык ''Акустическая петля''",
			loading_op_gameplay_title =						"Советы Original Pack",
			loading_op_trivia_title =						"Прочее о Original Pack",
			loading_op_gameplay_1 =							"''События'', ''Классческие'' и некоторые другие контракты выпадают только в Crime.NET. Их невозможно купить в брокере контрактов.", 
			loading_op_gameplay_2 =							"Светошумовые гранаты не мигают и издают звука перед взрывом, но их всё еще можно найти и сломать.",
			loading_op_gameplay_3 =							"Медиков можно встретить только на Защите убежища или Противостоянии.",
			loading_op_gameplay_4 =							"Во время стелса задоминированые охранники не требуют ответа на пейджер.",
			loading_op_gameplay_5 =							"Максимум можно ответить на 4 пейджера, без навыка на 2. Если вы ответили на 2 пейджера, то товарщи у которых нет навыка больше не смогут ответить на пейджер, иначе поднимится тревога.",
			loading_op_gameplay_6 =							"Если сложность контракта ''Сложно'' или ниже, то вы можете отвечать на максимальное количество пейджеров без необходимых на это навыков.",
			loading_op_gameplay_7 =							"Когда вы бежите, то в радиусе 2 метров вас могут услышать. Если вы стреляете из оружия с глушителем, то пулю которая ударилась в стену или землю могут услышать в радиусе 1 метра.",
			loading_op_gameplay_8 =							"Даже если ваше оружие с глушителем, оно все равно издает шум. Это зависит от того, какой глушитель установлен и самого оружия.",
			loading_op_gameplay_9 =							"У гражданских, которых вы запугали со временем исчезает индикатор. Так что будьте на чеку. Так же есть навык который заранее указывает, что гражданский встал и скоро будет звонить полиции или убегать.",
			loading_op_gameplay_10 =						"Количество задоминированых врагов зависит от количества товарищей в команде с навыком ''Доминатор'' вплоть до 4.",
			loading_op_gameplay_11 =						"Если вам нужно открыть сейф или дверь с помощью С4, то вам необходим определенный навык в ветке Техника.",
			loading_op_gameplay_12 =						"В большинстве случаев покупка контрактов не окупается его прохождением. Так что в некоторых случаях лучше подождать выпадения лучшего контракта в Crime.NET.",
			loading_op_gameplay_13 =						"Дрель издает шум в радиусе 10 метров, который может потревожить мимо стоящих гражданских и охранников. Навыки в древе Техника могут уменьшить шум.",
			loading_op_gameplay_14 =						"В игре есть перки, которые улучшают возможности в режиме исследования. Например: вы можете взамывать замки, подбирать предметы, взаимодействовать с компьютерами не надевая маски.",
			loading_op_gameplay_15 =						"Ценность сумок зависит от двух факотов - сложности контракта и уровня оплаты. Чем выше эти два фактора, тем больше цена за сумки.",
			loading_op_gameplay_16 =						"Вы можете разблокировать Карманные Генераторы Помех открытием навыка Акустическая Петля ПРО.",
			loading_op_gameplay_17 =						"Если ваш напарник упал, то убедитесь что он лежит не на открытой местности. Иначе пытаясь поднять его подстрелят и вас, тогда придется поднимать вас обоих.",
			loading_op_gameplay_18 =						"Не стеснятесь пользоватся укрытиями столько времени, сколько необходимо. Даже если придется сидеть полчаса.",
			loading_op_gameplay_19 =						"Получение очков перков идет по курсу 10.000 к 1. Если контракт дает меньше 10.000 опыта, то очки начислятся не будут.",
			loading_op_gameplay_20 =						"Если вы не хотите играть с нуля, то специально для вас в меню есть опция ''Максимальный прогресс''. Но играть вы сможете только с такими же игроками у кого включен максимальный прогресс.",
			loading_op_gameplay_21 =						"Максимальная сложность до 5й Дурной репутации - ''Жажда Смерти''. После вам будет доступны ''Хаос'' и при достижении 20 ранга ''Серии Преступлений'' вам будет доступен ''Смертный приговор''. Найти их можно только в Crime.NET.",
			loading_op_gameplay_22 =						"Достижения в Original Pack не идут в прогресс достижений Steam.",
			loading_op_gameplay_23 =						"Новое убежище, Профили навыков, монеты Континенталь, Серия Преступлений и Противостояние - всё это открывается с 5го уровня Дурной Репутации.",
			loading_op_gameplay_24 =						"Если вы стреляете сковзь стены или щиты, то урон снижается на 80%.",
			loading_op_gameplay_25 =						"В режиме ''Серия преступлений'' установлена уникальная сложность игры - ''Смертный приговор''. Вас встретят юниты ''Zeal'', у которых повышенные урон и здоровье. Чтобы дать им отпор, вам необходимо собрать все свои силы и навыки.",
			loading_op_gameplay_26 =						"Рестарт доступен только после провала тихого прохождения и только до того как начнется первый штурм.",
			loading_op_gameplay_27 =						"Контракты от ''События'' можно приобрести каждую пятницу 13-е или октябрь 31-го.",
			loading_op_gameplay_28 =						"Если вы собираетесь на громкое ограбление без патронов, то выживаемость вашей команды снизится до 75-50%.",
			loading_op_gameplay_29 =						"Оружие со взрывными и зажигательными снарядами полезнее обычных, но боезапас восполняется только из сумок с патронами.",
			loading_op_gameplay_30 =						"Если побег доступен и вы собираетесь скрытся, удостоверьтесь что вся команда восполнила своё здоровье. Иначе кто-то из вас сможет недобежать до побега.",
			loading_op_gameplay_31 =						"Когда штурм закончился, враги могут сдатся даже если у вас нет навыка ''Доминатор''. Полезно когда в округе нет гражданских, которых можно связать.",
			loading_op_gameplay_32 =						"При убийстве гражданского вы теряете опыт. За каждого убитого снимается 1%, на уровне сложности OVERKILL - 2%, а на Жажде Смерти - 3%.",
			loading_op_gameplay_33 =						"Лазерные целеуказатели могут потревожить гражданских и охранников. Фонарики игнорируются, так как каждый охранник имеет свой фонарь и не вызывает подозрения нежели лазерные целеуказатели.",
			loading_op_gameplay_34 =						"Не с кем играть? Загляните в Дискорд сервер по ссылке в главном меню.",
			loading_op_gameplay_35 =						"Посмотрите Original Pack Изменения нажав кнопку в главном меню, уверен вы найдете там больше полезной информации о старых обновлениях которые добавили элементы которые могут быть полезными при прохождении.",
			loading_op_gameplay_36 =						"У некоторых контрактов уровень оплаты меняется каждый день.",
			loading_op_gameplay_37 =						"Штурмовики могут с легкостью подавлять врагов, предоставляя защиту своим напарникам. Подавленные враги будут забывать про свое текущие задачи, хуже стрелять или вовсе постараются вас избежать.",
			loading_op_gameplay_38 =						"Пробуйте действовать скрытно. Это позволит вам выполнить часть заданий, даже если в конечном итоге ограбление придется завершать громко.",
			loading_op_gameplay_39 =						"Полиция будет тратить больше времени на подготовку к штурму, если у вас есть заложники.",
			loading_op_gameplay_40 =						"Если вы будете играть в дни выхода PAYDAY 2 и PAYDAY: The Heist, то сможете приобрести Классические контракты.",
			loading_op_gameplay_41 =						"Уничтожение обычных камер заставляет охранников их проверять.",
			loading_op_gameplay_42 =						"Отстреливайтесь от врагов, когда пересекаете открытые пространства. Даже если вы не попадете, то запугаете их и понизите их точность стрельбы. Это позволит безопаснее пройти этот участок.",
			loading_op_gameplay_43 =						"Если вы будете получать много урона или падать во время перерывов, то полиция начнет штурм раньше.",
			loading_op_gameplay_44 =						"Точная стрельба - один из залогов успеха.",
			loading_op_gameplay_45 =						"Если у вас низкий уровень репутации, то контракт с высоким уровнем оплаты может дать мало опыта.",
			loading_op_gameplay_46 =						"На уровне сложности Жажда Смерти и выше, вам будут встречаться Отряды Клокеров. Держитесь вместе и никого не оставляйте позади.",
			loading_op_gameplay_47 =						"Вы можете услышать, когда полицейские бросают светошумовые гранаты. Отвернитесь или уничтожьте ее до того, как она взорвется.",
			loading_op_gameplay_48 =						"Перки тоже сбрасываются при получении уровня Бесславия.",
			loading_op_gameplay_49 =						"Особое Оружие открывается при получении 85-ого Уровня Репутации.",
			loading_op_gameplay_50 =						"На уровнях сложности выше OVERKILL охранники и гражданские могут услышать речь грабителей при скрытном прохождении.",
			loading_op_gameplay_51 =						"Наблюдатель и Камеры-шпионы будут помечать Особых Врагов при громокм прохождении.",
			loading_op_gameplay_52 =						"Техник может значительно улучшать дрели, а также блокировать проходы, предоставлять поддержку на расстоянии и помогать в борьбе с Особыми Врагами при помощи своих Мин-сенсоров.",
			loading_op_gameplay_53 =						"При наличии соответствующего навыка дрель попытается починиться сама после поломки, однако только один раз. Если дрель не починилась, то это придется делать одному из грабителей.",
			loading_op_gameplay_54 =						"Манипулятор может помогать всей команде небольшими бонусами, доступом к услугам своего человека, Вдохновением и уменьшением отдачи оружия.",
			loading_op_gameplay_55 =						"Вдохновение увеличивает скорость взаимодействия напарника.",
			loading_op_gameplay_56 =						"Турели уязвимы к взырвчатке.",
			loading_op_gameplay_57 =						"Пока работает Генератор Помех турель будет атаковать полицейских, а не грабителей.",
			loading_op_gameplay_58 =						"Древо навыков Беглец может использоваться в дополнение к другим древам, но может и быть собственной ролью, если вложить достаточное количество очков навыков.",
			loading_op_gameplay_59 =						"Призрак - мастер скрытности. Однако, он также крайне способен в ближнем бою и может скрытно выполнять задания, пока его команда отвлекает врагов во время громкого прохождения.",
			loading_op_gameplay_60 =						"Перк Мистер Умник складывается.",
			loading_op_gameplay_61 =						"Награды за посылки Гейджа меняются каждый день.",
			loading_op_gameplay_62 =						"Играйте осторожно и не торопитесь. Не стесняйтесь отступать в безопасное место, если ситуация выходит из под контроля.",
			loading_op_gameplay_63 =						"Полицейские будут пытаться помешать вам выполнять задачи: останавливать взлом компьютеров, ломать дрели и воровать сумки. Постарайтесь следить за своими целями.",
			loading_op_gameplay_64 =						"Сбор достаточного количества мелкой добычи даст небольшой бонус к опыту.",
			loading_op_gameplay_65 =						"Каждое оружие имеет свое применение. Не бойтесь экспериментировать.",
			loading_op_gameplay_66 =						"Всегда ищите надежное место, в которое вы сможете укрыться в случае турдной ситуации.",
			loading_op_gameplay_67 =						"Взырвчатка имеет большой радиус взрыва.",
			loading_op_gameplay_68 =						"Лучше иметь разделенные роли в команде, чем когда каждый будет пытаться делать все понемногу.",
			loading_op_gameplay_69 =						"Самый очевидный подход не всегда самый лучший.",
			loading_op_gameplay_70 =						"Во время того, как вашего напарника поднимают, старайтесь отвлекать врагов огнем.",
			loading_op_gameplay_71 =						"Акустическая петля работает через стены.",
			loading_op_gameplay_72 =						"Пули ударившись от любой обьект издают шум и могут потревожить гражданских и охранников. на сложностях Хаос и Смертный приговор.",
			loading_op_gameplay_73 =						"Если вы играете в ограблении, которое не позволяет вам вернуться в определенные зоны, убедитесь, что все воспользовались разложенными аптечками и сумками с патронами, прежде чем двигаться дальше.",
			loading_op_gameplay_74 =						"Хаос и Смертный приговор открываются на уровне 95 или ранге Бесславия 1.",
			loading_op_gameplay_75 =						"Жажда смерти открывается на уровне 80.",
			loading_op_gameplay_76 =						"Надевая более легкую броню на более высоких уровнях сложности, вам нужно быть более осторожным и соответственно выбирать свои бои. Ваши товарищи по команде могут защитить вас своей более тяжелой броней, в то время как вы можете переносить добычу быстрее, чем они.",
			loading_op_gameplay_77 =						"Подумайте о том, чтобы оставаться в режиме наблюдения во время скрытности, вы сможете пойти куда угодно, чтобы проверить положение товарищей по команде, отметить охранников, использовать шестое чувство в более выгодных позициях или воспользоваться своими привилегиями.",
			loading_op_gameplay_78 =						"Не размещайте все свое снаряжение в одном месте, так как в конечном итоге вы останетесь без ресурсов, если вас загонят в угол где-нибудь в другом месте.",
			loading_op_trivia_1 =							"В 2015 и 2016 годах ничего особенного не произошло.",
			menu_prof_mod_contract =						"В случае неудачи контракт будет отменен.",
			menu_prof_mod_hostage =							"Количество заложников неизвестно во время штурма.",
			menu_prof_mod_flash =							"Cветошумовые гранаты, брошенные противником, не имеют задержки.",
			menu_prof_mod_inventory =						"Особое снаряжение не передается если игрок попал под стражу.",	
			menu_achievements_teamwork_players_2_to_4 =		"2-4 Игроков",
			menu_cn_legend_hidden =							"##Скрытые## контракты",
			menu_cn_legend_hate =							"Уровень ненависти",
			menu_holiday_exp_bonus =						"Праздничные дни",
			menu_killed_civs_reduction_exp =				"Штраф убийства гражданских",
			menu_loose_money_collected_exp =				"Найдена мелкая добыча",
			menu_one_down_additional =						"Текущая волна:",
			menu_one_down_additional_2 =					"Количество очков опыта увеличено на",
			menu_killed_civs =								"Убиты гражданские! Количество очков опыта снижено на ",
			menu_collected_packages =						"Найдены посылки Гейджа. Количество очков опыта увеличено на ",
			menu_loose_money =								"Найдена мелкая добыча. Количество очков опыта увеличено на ",
			cn_menu_contract_length_header =				"Длительность:",
			cn_menu_contract_day =							"$stages День",
			cn_menu_contract_length =						"$stages Дня",
			cn_menu_community =								"Сообщество",
			cn_menu_pro_job =								"PRO JOB",
			menu_es_next_level =							"Следующий уровень:",
		})
	end
end)