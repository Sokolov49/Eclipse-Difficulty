function HuskPlayerMovement:set_cbt_permanent(on)
end

function HuskPlayerMovement:_chk_change_stance()
	local wanted_stance_code = nil

	if self.clean_states[self._state] then
		wanted_stance_code = self._stance.owner_stance_code
	elseif self._aim_up_expire_t then
		wanted_stance_code = 3
	else
		wanted_stance_code = self._stance.owner_stance_code
	end

	if wanted_stance_code ~= self._stance.code then
		self:_change_stance(wanted_stance_code)
	end
end