--prevent active gadgets from visually forcing the player into hostile state
function HuskPlayerInventory:synch_weapon_gadget_state(state)
	if self:equipped_unit():base().set_gadget_on and self._unit:movement().set_cbt_permanent then
		self:equipped_unit():base():set_gadget_on(state, false)

		if state and state > 0 then
			self._unit:movement():set_cbt_permanent(false)
		end
	end
end