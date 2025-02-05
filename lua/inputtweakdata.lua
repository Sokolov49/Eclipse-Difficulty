--make this a posthook thanks future me
Hooks:PostHook( InputTweakData, "init", "input_init", function(self)
    self.gamepad = {
        aim_assist_move_speed = 200,
        aim_assist_move_th_min = 1.0,
		aim_assist_move_th_max = 1.0,
        aim_assist_gradient_min = 1.0,
        aim_assist_gradient_max = 1.0,
        aim_assist_gradient_max_distance = 3000,
		aim_assist_look_speed = 200,
		aim_assist_snap_speed = 200,
		look_speed_standard = 200,
        look_speed_dead_zone = 0.02,
		look_speed_transition_zone = 0.95,
        look_speed_fast = 340,
        look_speed_transition_occluder = 0.95,
        look_speed_steel_sight = 300,
        look_speed_transition_to_fast = 0.55,
        uses_keyboard = true,
		aim_assist_use_sticky_aim = true,
        deprecated = {
            look_speed_fast = 360,
            look_speed_transition_to_fast = 0.5,
            aim_assist_snap_speed = 200,
            uses_keyboard = true,
            look_speed_dead_zone = 0.1,
            look_speed_transition_zone = 0.8,
            look_speed_transition_occluder = 0.95,
            aim_assist_use_sticky_aim = false,
            look_speed_steel_sight = 60,
            look_speed_standard = 120
        }
    }
end)