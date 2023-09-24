if string.lower(RequiredScript) == "lib/managers/hudmanagerpd2" then
	function HUDManager:temp_show_carry_bag( carry_id, value )
		self._hud_temp:show_carry_bag( carry_id, value )
		self._sound_source:post_event( "Play_bag_generic_pickup" )
	end
end