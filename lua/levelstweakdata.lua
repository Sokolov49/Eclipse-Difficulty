--add packages that include missing SF/Texas beat cops
Hooks:PostHook(LevelsTweakData, "init", "eclipse_init", function(self)
	--LAPD
	self.rvd1.ai_unit_group_overrides = {
		beat_cop = {
			america = {
				Idstring("units/pd2_dlc_rvd/characters/ene_la_cop_1/ene_la_cop_1"),
				Idstring("units/pd2_dlc_rvd/characters/ene_la_cop_2/ene_la_cop_2"),
				Idstring("units/pd2_dlc_rvd/characters/ene_la_cop_3/ene_la_cop_3"),
				Idstring("units/pd2_dlc_rvd/characters/ene_la_cop_4/ene_la_cop_4"),
			},
		},
	}
	self.rvd2.ai_unit_group_overrides = self.rvd1.ai_unit_group_overrides

	--SFPD
	self.chas.ai_unit_group_overrides = {
		beat_cop = {
			america = {
				Idstring("units/pd2_dlc_ranc/characters/ene_male_chas_police_01/ene_male_chas_police_01"),
				Idstring("units/pd2_dlc_ranc/characters/ene_male_chas_police_02/ene_male_chas_police_02"),
			},
		},
	}
	self.pent.ai_unit_group_overrides = self.chas.ai_unit_group_overrides

	--Texas Rangers
	self.ranc.ai_unit_group_overrides = {
		beat_cop = {
			america = {
				Idstring("units/pd2_dlc_ranc/characters/ene_male_ranc_ranger_01/ene_male_ranc_ranger_01"),
				Idstring("units/pd2_dlc_ranc/characters/ene_male_ranc_ranger_02/ene_male_ranc_ranger_02"),
			},
		},
	}
	
	self.framing_frame_1.player_style = "slaughterhouse"
	self.framing_frame_3.player_style = "slaughterhouse"
	self.election_day_1.player_style = "slaughterhouse"
	self.election_day_2.player_style = "slaughterhouse"
	self.alex_1.player_style = "slaughterhouse"
	self.alex_3.player_style = "slaughterhouse"
	self.watchdogs_1.player_style = "slaughterhouse"
	self.watchdogs_2.player_style = "slaughterhouse"
	self.firestarter_1.player_style = "slaughterhouse"
	self.firestarter_2.player_style = "sneak_suit"
	self.welcome_to_the_jungle_1.player_style = "slaughterhouse"
	self.welcome_to_the_jungle_2.player_style = "slaughterhouse"
	self.crojob2.player_style = "slaughterhouse"
	self.crojob3.player_style = "slaughterhouse"
	self.arm_cro.player_style = "jumpsuit"
	self.arm_und.player_style = "jumpsuit"
	self.arm_hcm.player_style = "jumpsuit"
	self.arm_par.player_style = "jumpsuit"
	self.arm_fac.player_style = "jumpsuit"
	self.arm_for.player_style = "jumpsuit"
	self.kosugi.player_style = "sneak_suit"
	self.pines.player_style = "winter_suit"

	self.dinner.player_style = "slaughterhouse"
	self.cane.player_style = "winter_suit"
	self.pal.player_style = "poolrepair"
	self.man.player_style = "slaughterhouse"
	self.mad.player_style = "winter_suit"
	self.moon.player_style = "winter_suit"

	self.dah.player_style = "slaughterhouse"
	self.wwh.player_style = "winter_suit"
	self.brb.player_style = "winter_suit"

end)
