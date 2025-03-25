function MenuRenderer:show_node(node)
	local gui_class = MenuNodeGui

	if node:parameters().gui_class then
		gui_class = CoreSerialize.string_to_classtable(node:parameters().gui_class)
	end

	local parameters = {
		marker_alpha = 0.6,
		align = "right",
		row_item_blend_mode = "add",
		to_upper = true,
		font = "fonts/font_medium_shadow_mf",
		row_item_color = Color.white,
		row_item_hightlight_color = Color.red, --tweak_data.screen_colors.button_stage_2,
		font_size = tweak_data.menu.pd2_medium_font_size,
		node_gui_class = gui_class,
		spacing = node:parameters().spacing,
		marker_color = tweak_data.screen_colors.button_stage_3:with_alpha(0.2)
	}

	MenuRenderer.super.show_node(self, node, parameters)

	local previous_node_gui = self._node_gui_stack[#self._node_gui_stack - 1]

	if previous_node_gui and (node:parameters().hide_previous == false or node:parameters().hide_previous == "false") then
		previous_node_gui:set_visible(true)
	end
end