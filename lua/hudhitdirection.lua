function HUDHitDirection:_get_indicator_color(damage_type, t)
	if managers.user:get_setting("color_blind_hit_direction") then
		local name = HUDHitDirection.DAMAGE_TYPE_NAMES[damage_type]
		local color = tweak_data.hud_color_blind_assist[name]

		if color then
			return color
		end
	end

	if damage_type == HUDHitDirection.DAMAGE_TYPES.HEALTH then
		return Color(1, t, t)
	elseif damage_type == HUDHitDirection.DAMAGE_TYPES.ARMOUR then
		return Color(1, t, t) --Color(t, 1, 1) original , Color(1, t, t) red health , Color(0.99, 0.86, 0.23)piss yellow
	elseif damage_type == HUDHitDirection.DAMAGE_TYPES.VEHICLE then
		return Color(1, 0.8, t)
	end

	return Color(1, t, t)
end