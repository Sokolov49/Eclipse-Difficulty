local mvec3_add = mvector3.add
local mvec3_cpy = mvector3.copy
local mvec3_cross = mvector3.cross
local mvec3_mul = mvector3.multiply
local mvec3_norm = mvector3.normalize
local mvec3_set = mvector3.set
local math_cos = math.cos
local math_rad = math.rad
local math_random = math.random
local math_sin = math.sin
local math_tan = math.tan
local math_max = math.max
local math_min = math.min

local mvec_to = Vector3()
local mvec_right = Vector3()
local mvec_up = Vector3()
local mvec_ax = Vector3()
local mvec_ay = Vector3()
local mvec_spread_direction = Vector3()

Hooks:PostHook(ShotgunBase, "_update_stats_values", "eclipse__update_stats_values", function(self)
	local extra_pellets = managers.player:upgrade_value("shotgun", "extra_pellets", 0)
	if self._ammo_data then
		if self._ammo_data.rays ~= 1 then
			self._rays = self._rays + extra_pellets
		end
	end
end)

function ShotgunBase:_fire_raycast(user_unit, from_pos, direction, dmg_mul, ...)
	self._enemy_penetrations = nil
	self._hit_through_enemy = nil
	self._hit_through_wall = nil
	self._hit_through_shield = nil

	local result = {
		hit_enemy = false,
		rays = {},
	}

	local ray_distance = self:weapon_range(user_unit)

	for _ = 1, self._rays do
		local res = ShotgunBase.super._fire_raycast(self, user_unit, from_pos, direction, ...)
		result.hit_enemy = result.hit_enemy or res.hit_enemy
		table.list_append(result.rays, res.rays)
	end

	return result
end

function ShotgunBase:get_damage_falloff(damage, col_ray, user_unit)
	local distance = col_ray.distance or mvector3.distance(col_ray.unit:position(), user_unit:position())
	local inc_range_mul = 1
	local current_state = user_unit:movement()._current_state

	self._damage_near = tweak_data.weapon[self._name_id].damage_near
	self._damage_far = tweak_data.weapon[self._name_id].damage_far

	if current_state and current_state:in_steelsight() then
		inc_range_mul = managers.player:upgrade_value("shotgun", "steelsight_range_inc", 1)
	end
	
	local damage_percent_min = damage * 0.1
	local new_damage = 1 - math.min(1, math.max(0, distance - self._damage_near * inc_range_mul) / (self._damage_far * inc_range_mul))
	new_damage = new_damage * damage
	
	if new_damage < damage_percent_min then
		new_damage = damage_percent_min
	end

	--log("damage is: " .. tostring(new_damage) .. "")

	return new_damage
end