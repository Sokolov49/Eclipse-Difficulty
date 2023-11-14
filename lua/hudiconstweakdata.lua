--dont know how to implement difficulty checks into this code without crashing so its unused for now
local old_init = HudIconsTweakData.init
	function HudIconsTweakData:init(tweak_data)
		old_init(self, tweak_data)
		
		self.pd2_lootdrop = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_escape = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_talk = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_kill = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_drill = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_generic_look = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_phone = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_c4 = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_generic_saw = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_chainsaw = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_power = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_door = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_computer = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_fire = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_loot = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_methlab = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_generic_interact = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_goto = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_ladder = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_fix = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_question = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_defend = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.wp_arrow = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_car = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_melee = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_water_tap = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.pd2_bodybag = {
			texture = "guis/textures/pd2/pd2_waypoints",
			texture_rect = {}
		}
		self.wp_vial = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_standard = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_revive = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_rescue = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_trade = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_powersupply = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_watersupply = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_drill = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_hack = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_talk = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_c4 = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_crowbar = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_planks = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_door = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_saw = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_bag = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_exit = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_can = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_target = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_key = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_winch = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_escort = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_powerbutton = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_server = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_powercord = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_phone = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_scrubs = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_sentry = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_suspicious = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		self.wp_detected = {
			texture = "guis/textures/hud_icons",
			texture_rect = {}
		}
		
	end