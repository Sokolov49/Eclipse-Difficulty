Hooks:PostHook(MenuSceneManager, "setup_camera", "promod_init", function(self)
	managers.environment_controller:set_default_color_grading( "color_bhd" )
end)


Hooks:PostHook(MenuSceneManager, "_set_up_templates", "NotHEATMenuTemplate", function(self)
	local ref = self._bg_unit:get_object(Idstring("a_camera_reference"))
	local c_ref = self._bg_unit:get_object(Idstring("a_reference"))
	local target_pos = Vector3(0, 0, ref:position().z)
	local offset = Vector3(ref:position().x, ref:position().y, 0)
	
	self._scene_templates.standard.lights = {
		self:_create_light({ --Fill Front
			far_range = 200,
			color = Vector3(1, 1, 1) * 0.1,
			position = Vector3(-55, -100, 30)
		}),
		self:_create_light({ --Key Left
			far_range = 200,
			color = Vector3(1, 0, 0) * 4,
			position = Vector3(-154, -6, 26)
		}),
		self:_create_light({ --Key Right
			far_range = 160,
			color = Vector3(0.811, 0.945, 0.968) * 2,
			position = Vector3(35, -13, 26)
		}),
		self:_create_light({ --Rim Left
			far_range = 200,
			color = Vector3(1, 1, 1) * 6,
			position = Vector3(-141, 65, 62)
		}),
		self:_create_light({ --Rim Right
			far_range = 160,
			color = Vector3(1, 1, 1) * 6,
			position = Vector3(-11, 89, 56)
		})
	}
	
	self._scene_templates.standard.show_mm10_event = false
	
	self._scene_templates.infamy_preview = {
		fov = 40,
		can_change_fov = false,
		use_item_grab = true,
		camera_pos = offset:rotate_with(Rotation(90)) + Vector3(0, 0, 202),
		target_pos = target_pos + Vector3(0, 0, 200),
		character_pos = Vector3(-75, 10, 100),
		hide_armor = true,
		hide_mask = true,
		hide_menu_logo = true,
		hide_weapons = true,
		disable_rotate = true,
		character_visible = true,
		use_character_grab2 = false,
		use_character_pan = false,
		lights = {
			self:_create_light({ -- Top
				far_range = 350,
				specular_multiplier = 155,
				color = Vector3(1, 1, 1) * 8,
				position = Vector3(40, 0, 300)
			}),
			self:_create_light({ -- Left
				far_range = 450,
				specular_multiplier = 155,
				color = Vector3(1, 1, 1) * 0.5,
				position = Vector3(100, -100, 200)
			}),
			self:_create_light({ -- Right
				far_range = 370,
				specular_multiplier = 55,
				color = Vector3(0.95, 0.9, 1) * 1.5,
				position = Vector3(200, 160, 180)
			})
		}
	}
	
	self._scene_templates.character_customization = {
		use_character_grab = true,
		camera_pos = Vector3(-73.1618, -168.021, -35.0786),
		target_pos = Vector3(-73.1618, -168.021, -35.0786) + Vector3(0.31113, 0.944697, -0.103666) * 100,
		lights = clone(self._scene_templates.standard.lights)
	}
	
	self._scene_templates.lobby = {
		use_character_grab = false,
		hide_menu_logo = true,
		camera_pos = offset:rotate_with(Rotation(90)),
		target_pos = target_pos,
		character_pos = c_ref:position() + Vector3(0, 500, 0),
		lobby_characters_visible = true,
		fov = 40,
		lights = {
			-- self:_create_light({ --Fill Front
				-- far_range = 300,
				-- color = Vector3(1, 1, 1) * 0.1,
				-- position = Vector3(-175, -10, -8)
			-- }),
			self:_create_light({ --Key Red
				far_range = 300,
				color = Vector3(1, 1, 1) * 1,
				position = Vector3(-40, -144, -27)
			}),
			self:_create_light({ --Key Blue
				far_range = 300,
				color = Vector3(1, 1, 1) * 1,
				position = Vector3(-13, 116, 61)
			}),
			self:_create_light({ --Rim Left
				far_range = 220,
				color = Vector3(1, 0, 0) * 4,
				position = Vector3(-160, -50, 80)
			}),
			self:_create_light({ --Rim Right
				far_range = 200,
				color = Vector3(1, 1, 1) * 2,
				position = Vector3(-160, 50, 56)
			})
		}
	}
	
	self._scene_templates.lobby1 = {
		use_character_grab = false,
		lobby_characters_visible = true,
		hide_menu_logo = true,
		camera_pos = Vector3(-90.5634, -157.226, -28.6729),
		target_pos = Vector3(-90.5634, -157.226, -28.6729) + Vector3(-0.58315, 0.781811, 0.220697) * 100,
		fov = 30,
		lights = clone(self._scene_templates.lobby.lights)
	}
	
	self._scene_templates.lobby2 = {
		use_character_grab = false,
		lobby_characters_visible = true,
		hide_menu_logo = true,
		camera_pos = Vector3(-21.2779, -264.36, -56.7304),
		target_pos = Vector3(-21.2779, -264.36, -56.7304) + Vector3(-0.633319, 0.758269, 0.154709) * 100,
		fov = 30,
		lights = clone(self._scene_templates.lobby.lights)
	}
	
	self._scene_templates.lobby3 = {
		use_character_grab = false,
		lobby_characters_visible = true,
		hide_menu_logo = true,
		camera_pos = Vector3(149.695, -363.069, -110.613),
		target_pos = Vector3(149.695, -363.069, -110.613) + Vector3(-0.648856, 0.748553, 0.136579) * 100,
		fov = 30,
		lights = clone(self._scene_templates.lobby.lights)
	}
	
	self._scene_templates.lobby4 = {
		use_character_grab = false,
		lobby_characters_visible = true,
		hide_menu_logo = true,
		camera_pos = Vector3(210.949, -449.61, -126.709),
		target_pos = Vector3(210.949, -449.61, -126.709) + Vector3(-0.668524, 0.734205, 0.118403) * 100,
		fov = 30,
		lights = clone(self._scene_templates.lobby.lights)
	}
	
	self._scene_templates.blackmarket_item.lights = {
		self:_create_light({ -- Top
			far_range = 350,
			specular_multiplier = 155,
			color = Vector3(1, 1, 1) * 8,
			position = Vector3(40, 0, 300)
		}),
		self:_create_light({ -- Left
			far_range = 450,
			specular_multiplier = 155,
			color = Vector3(1, 1, 1) * 0.5,
			position = Vector3(100, -100, 200)
		}),
		self:_create_light({ -- Right
			far_range = 370,
			specular_multiplier = 55,
			color = Vector3(0.95, 0.9, 1) * 2.25,
			position = Vector3(200, 160, 180)
		})
	}
	self._scene_templates.blackmarket_mask.lights = {
		self:_create_light({ -- Top
			far_range = 350,
			specular_multiplier = 155,
			color = Vector3(1, 1, 1) * 8,
			position = Vector3(40, 0, 300)
		}),
		self:_create_light({ -- Left
			far_range = 450,
			specular_multiplier = 155,
			color = Vector3(1, 1, 1) * 0.5,
			position = Vector3(100, -100, 200)
		}),
		self:_create_light({ -- Right
			far_range = 370,
			specular_multiplier = 55,
			color = Vector3(0.95, 0.9, 1) * 1.5,
			position = Vector3(200, 160, 180)
		})
	}

	self._scene_templates.inventory = {
		fov = 50,
		can_change_fov = true,
		change_fov_sensitivity = 3,
		use_character_grab2 = true,
		use_character_pan = true,
		character_visible = true,
		recreate_character = true,
		lobby_characters_visible = false,
		hide_menu_logo = true,
		camera_pos = ref:position(),
		target_pos = target_pos - self._camera_start_rot:x() * 40 - self._camera_start_rot:z() * 5 + self._camera_start_rot:y() * 20,
		character_pos = c_ref:position(),
		remove_infamy_card = true
	}
	self._scene_templates.inventory.lights = {
		self:_create_light({ --Fill Front
			far_range = 200,
			color = Vector3(1, 1, 1) * 0,
			position = Vector3(-30, -100, 30)
		}),
		self:_create_light({ --Key Left
			far_range = 200,
			color = Vector3(0.811, 0.945, 0.968) * 5,
			position = Vector3(-154, -6, 26)
		}),
		self:_create_light({ --Key Right
			far_range = 160,
			color = Vector3(0.811, 0.945, 0.968) * 2,
			position = Vector3(35, -13, 26)
		}),
		self:_create_light({ --Rim Left
			far_range = 200,
			color = Vector3(1, 1, 1) * 8,
			position = Vector3(-141, 65, 62)
		}),
		self:_create_light({ --Rim Right
			far_range = 160,
			color = Vector3(1, 1, 1) * 8,
			position = Vector3(-11, 89, 56)
		})
	}
	
	self._scene_templates.blackmarket_customize = {
		fov = 40,
		use_item_grab = true,
		disable_rotate = true,
		disable_item_updates = true,
		can_change_fov = true,
		can_move_item = true,
		hide_menu_logo = true,
		change_fov_sensitivity = 2,
		camera_pos = Vector3(1500, -2000, 0)
	}
	
	self._scene_templates.crime_spree_lobby = {
		use_character_grab = false,
		camera_pos = offset:rotate_with(Rotation(90)),
		target_pos = target_pos,
		character_pos = c_ref:position() + Vector3(0, 500, 0),
		lobby_characters_visible = true,
		fov = 40,
		hide_menu_logo = true,
		lights = {
			self:_create_light({
				far_range = 300,
				color = Vector3(1, 1, 1) * 3,
				position = Vector3(56, 100, -10)
			}),
			self:_create_light({
				far_range = 3000,
				specular_multiplier = 6,
				color = Vector3(1, 1, 1) * 3,
				position = Vector3(-1000, -300, 800)
			}),
			self:_create_light({
				far_range = 800,
				specular_multiplier = 0,
				color = Vector3(1, 1, 1) * 0.35,
				position = Vector3(300, 100, 0)
			})
		}
	}
	
	self._scene_templates.crew_management = {
		use_character_grab = false,
		hide_menu_logo = true,
		camera_pos = offset:rotate_with(Rotation(90)),
		target_pos = target_pos,
		character_pos = c_ref:position() + Vector3(0, 500, 0),
		character_visible = false,
		lobby_characters_visible = false,
		henchmen_characters_visible = true,
		fov = 40,
		lights  = {
			self:_create_light({ --Fill
				far_range = 250,
				color = Vector3(1, 1, 1) * 0.2,
				position = Vector3(40, -70, 60)
			}),
			self:_create_light({ --Key Blue
				far_range = 300,
				color = Vector3(1, 1, 1) * 2,
				position = Vector3(-70, -30, 60)
			}),
			self:_create_light({ --Key Red
				far_range = 340,
				color = Vector3(1, 0, 0) * 2,
				position = Vector3(50, 100, -60)
			}),
			-- self:_create_light({ --Rim Top
				-- far_range = 220,
				-- color = Vector3(1, 1, 1) * 3,
				-- position = Vector3(-100, 30, 150)
			-- }),
			self:_create_light({ --Rim Left
				far_range = 220,
				color = Vector3(1, 1, 1) * 0.2,
				position = Vector3(-100, -170, 60)
			})
		}
	}
	
	self._scene_templates.raid_menu = {
		use_character_grab = false,
		camera_pos = offset:rotate_with(Rotation(90)),
		target_pos = target_pos,
		character_pos = c_ref:position() + Vector3(0, 500, 0),
		character_visible = false,
		hide_menu_logo = true,
		lobby_characters_visible = false,
		henchmen_characters_visible = true,
		fov = 40,
		lights = {
			self:_create_light({
				far_range = 300,
				color = Vector3(0.86, 0.57, 0.31) * 3,
				position = Vector3(56, 100, -10)
			}),
			self:_create_light({
				far_range = 3000,
				specular_multiplier = 6,
				color = Vector3(1, 2.5, 4.5) * 3,
				position = Vector3(-1000, -300, 800)
			}),
			self:_create_light({
				far_range = 800,
				specular_multiplier = 0,
				color = Vector3(1, 1, 1) * 0.35,
				position = Vector3(300, 100, 0)
			})
		}
	}
	
	self._scene_templates.movie_theater = {
		use_character_grab = false,
		hide_menu_logo = true,
		camera_pos = offset:rotate_with(Rotation(90)),
		target_pos = target_pos,
		character_visible = false,
		lobby_characters_visible = false,
		fov = 40
	}
end)

function MenuSceneManager:_setup_bg()
	local yaw = 180
		--This element must never be removed.
	self._bg_unit = World:spawn_unit(Idstring("units/menu/menu_scene/menu_cylinder"), Vector3(0, 0, 0), Rotation(yaw, 0, 0))


		--Background pattern & smoke FX.  Smoke is 3 different scrolling planes, pattern is 1.  smokecylinder1 is lowest poly and without the other FX, very evident.
	--World:spawn_unit(Idstring("units/menu/menu_scene/menu_cylinder_pattern"), Vector3(0, 0, 0), Rotation(yaw, 0, 0))
	World:spawn_unit(Idstring("units/menu/menu_scene/menu_smokecylinder1"), Vector3(0, 0, 0), Rotation(yaw, 0, 0))
	World:spawn_unit(Idstring("units/menu/menu_scene/menu_smokecylinder2"), Vector3(0, 0, 0), Rotation(yaw, 0, 0))
	World:spawn_unit(Idstring("units/menu/menu_scene/menu_smokecylinder3"), Vector3(0, 0, 0), Rotation(yaw, 0, 0))


		--Menu logo.
	self._menu_logo = World:spawn_unit(Idstring("units/menu/menu_scene/menu_logo"), Vector3(0, 10, 0), Rotation(yaw, 0, 0))


	self:set_character(managers.blackmarket:get_preferred_character())
		
		local e_money = self._bg_unit:effect_spawner(Idstring("e_money"))

		if e_money then
			e_money:set_enabled(false)
		end	
		
	self:_setup_lobby_characters()
	self:_setup_henchmen_characters()
end

function MenuSceneManager:_set_up_environments()
	self._environments = {
		standard = {}
	}
	self._environments.standard.environment = "environments/env_menu/env_menu"
	self._environments.standard.color_grading = "color_bhd"
	self._environments.standard.angle = 0
	self._environments.safe = {
		environment = "environments/env_menu/env_menu",
		color_grading = "color_off",
		angle = -135
	}
	self._environments.crafting = {
		environment = "environments/env_menu/env_menu",
		color_grading = "color_off",
		angle = -135
	}
end