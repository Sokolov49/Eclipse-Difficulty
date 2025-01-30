--the same thing again just in case
	function HUDManager:_add_name_label(data)
		local hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
		local last_id = self._hud.name_labels[#self._hud.name_labels] and self._hud.name_labels[#self._hud.name_labels].id or 0
		local id = last_id + 1
		local character_name = data.name
		local rank = 0
		local peer_id
		local is_husk_player = data.unit:base().is_husk_player
		if is_husk_player then
			peer_id = data.unit:network():peer():id()
			local level = data.unit:network():peer():level()
			rank = data.unit:network():peer():rank()
			if level then
				local color_range_offset = utf8.len(data.name) + 2
				local experience, color_ranges = managers.experience:gui_string(level, rank, color_range_offset)
				data.name_color_ranges = color_ranges
				data.name = data.name .. " [" .. experience .. "]"
			end
		end
		local panel = hud.panel:panel({
			name = "name_label" .. id
		})
		local radius = 24
		local interact = CircleBitmapGuiObject:new(panel, {
			use_bg = true,
			radius = radius,
			blend_mode = "add",
			color = Color.white,
			layer = 0
		})
		interact:set_visible(false)
		local tabs_texture = "guis/textures/pd2/hud_tabs"
		local bag_rect = {
			2,
			34,
			20,
			17
		}
		local color_id = managers.criminals:character_color_id_by_unit(data.unit)
		local crim_color = tweak_data.chat_colors[color_id]
		local text = panel:text({
			name = "text",
			text = utf8.to_upper(data.name),
			font = tweak_data.menu.medium_font,
			font_size = 28,
			color = crim_color,
			align = "left",
			vertical = "top",
			layer = -1,
			w = 256,
			h = 18
		})
		local bag = panel:bitmap({
			name = "bag",
			texture = tabs_texture,
			texture_rect = bag_rect,
			visible = false,
			layer = 0,
			color = crim_color:with_alpha(1),
			x = 1,
			y = 1
		})
		panel:text({
			name = "cheater",
			text = utf8.to_upper(managers.localization:text("menu_hud_cheater")),
			font = tweak_data.menu.medium_font,
			font_size = 28,
			color = tweak_data.screen_colors.pro_color,
			align = "center",
			visible = false,
			layer = -1,
			w = 256,
			h = 18
		})
		panel:text({
			name = "action",
			rotation = 360,
			visible = false,
			text = utf8.to_upper("Fixing"),
			font = tweak_data.menu.medium_font,
			font_size = 28,
			color = crim_color:with_alpha(1),
			align = "left",
			vertical = "bottom",
			layer = -1,
			w = 256,
			h = 18
		})
		if rank > 0 then
			local texture, texture_rect = managers.experience:rank_icon_data(rank)
			panel:bitmap({
				name = "infamy",
				layer = 0,
				h = 16,
				w = 16,
				texture = texture,
				texture_rect = texture_rect,
				color = crim_color
			})
		end

		for _, color_range in ipairs(data.name_color_ranges or {}) do
			text:set_range_color(color_range.start, color_range.stop, color_range.color)
		end

		self:align_teammate_name_label(panel, interact)
		table.insert(self._hud.name_labels, {
			movement = data.unit:movement(),
			panel = panel,
			text = text,
			id = id,
			peer_id = peer_id,
			character_name = character_name,
			interact = interact,
			bag = bag
		})
		return id
	end
	
function HUDTeammate:set_name(teammate_name)
	local teammate_panel = self._panel
	local name = teammate_panel:child("name")
	local name_bg = teammate_panel:child("name_bg")
	local callsign = teammate_panel:child("callsign")
	local name_text
	name_text = utf8.to_upper( " "..teammate_name )
	name:set_text( name_text, 23, false )
	local h = name:h()
	managers.hud:make_fine_text(name)
	name:set_h(h)
	name_bg:set_w(name:w() + 4)
end

function HUDManager:update_name_label_by_peer(peer)
	for _, data in pairs(self._hud.name_labels) do
		if data.peer_id == peer:id() then
			local name = data.character_name

			if peer:level() then
				local color_range_offset = utf8.len(name) + 2
				local experience, color_ranges = managers.experience:gui_string(peer:level(), peer:rank(), color_range_offset)
				data.name_color_ranges = color_ranges
				name = name .. " [" .. experience .. "]"
			end

			data.text:set_text( utf8.to_upper(name) )

			for _, color_range in ipairs(data.name_color_ranges or {}) do
				data.text:set_range_color(color_range.start, color_range.stop, color_range.color)
			end

			self:align_teammate_name_label(data.panel, data.interact)

			break
		end
	end
end