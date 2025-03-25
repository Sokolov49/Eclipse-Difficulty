local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
local difficulty_index = tweak_data:difficulty_to_index(difficulty)
if difficulty_index < 4 then
	return
else
	Hooks:PostHook(SecurityCamera, "init", "postinit_test_cam", function(self)
		self._initialized_yaw = false
		self._current_yaw_action = 1
		-- 1 = Increase
		-- 2 = Decrease
	end)

	Hooks:PostHook(SecurityCamera, "update", "postinit_update_camera", function(self, t, dt)
		local current_yaw = self._yaw
		local current_pitch = self._pitch
		local max_yaw_positive = 60
		local max_yaw_negative = -60

		self:_init_dynamic_yaw()

		if self._current_yaw_action == 1 then
			if math.floor(self._yaw) == max_yaw_positive then
				self._current_yaw_action = 2
			else
				self:_increase_yaw()
			end
		end

		if self._current_yaw_action == 2 then
			if math.floor(self._yaw) == max_yaw_negative then
				self._current_yaw_action = 1
			else
				self:_decrease_yaw()
			end
		end
	end)

	function SecurityCamera:_init_dynamic_yaw()
		local max_yaw_negative = -60
		local current_pitch = self._pitch

		if not self._initialized_yaw then
			self._initialized_yaw = true
			self:apply_rotations(max_yaw_negative, current_pitch)
		end
	end

	function SecurityCamera:_increase_yaw()
		local max_yaw_positive = 60
		local current_pitch = self._pitch

		if self._yaw <= max_yaw_positive then
			local new_yaw = self._yaw + 0.1
			self:apply_rotations(new_yaw, current_pitch)
		end
	end

	function SecurityCamera:_decrease_yaw()
		local max_yaw_negative = -60
		local current_pitch = self._pitch

		if self._yaw >= max_yaw_negative then
			local new_yaw = self._yaw - 0.1
			self:apply_rotations(new_yaw, current_pitch)
		end
	end
end