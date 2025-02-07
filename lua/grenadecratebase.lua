--interacting with a grenade case restores entire throwable supply
function GrenadeCrateBase:take_grenade(unit)
	if self._empty then
		return
	end

	local can_take_grenade = self:_can_take_grenade() and 1 or 0

	if can_take_grenade == 1 then
		local max_grenades = managers.player:get_max_grenades()
		unit:sound():play("pickup_ammo")
		local grenade_amount = managers.player:add_grenade_amount(max_grenades, true)
		managers.network:session():send_to_peers_synched("sync_unit_event_id_16", self._unit, "base", 1)
		self._grenade_amount = self._grenade_amount - 1
	end

	if self._grenade_amount <= 0 then
		self:_set_empty()
	end

	self:_set_visual_stage()

	return can_take_grenade
end