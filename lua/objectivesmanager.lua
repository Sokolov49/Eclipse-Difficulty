--hides objectives on overkill and above
local _objectives_original = ObjectivesManager.activate_objective
function ObjectivesManager:activate_objective(id, load_data, data)
	local difficulty_index = tweak_data:difficulty_to_index(Global.game_settings.difficulty)
	if difficulty_index < 5 then
		return _objectives_original(self, id, load_data, data)
	else
	
	if not id or not self._objectives[id] then
		Application:stack_dump_error("Bad id to activate objective, " .. tostring(id) .. ".")

		return
	end

	Telemetry:send_on_player_tutorial(id)
	Telemetry:on_start_objective(id)

	local objective = self._objectives[id]

	for _, sub_objective in pairs(objective.sub_objectives) do
		sub_objective.completed = false
	end

	objective.current_amount = load_data and load_data.current_amount or data and data.amount and 0 or objective.current_amount
	objective.amount = load_data and load_data.amount or data and data.amount or objective.amount
	local activate_params = {
		id = id,
		text = objective.text,
		sub_objectives = objective.sub_objectives,
		amount = objective.amount,
		current_amount = objective.current_amount,
		amount_text = objective.amount_text
	}

	if not load_data then
		local title_message = data and data.title_message or managers.localization:text("mission_objective_activated")
		local text = objective.text
	end

	self._active_objectives[id] = objective
	self._remind_objectives[id] = {
		next_t = Application:time() + self.REMINDER_INTERVAL
	}
	end
end