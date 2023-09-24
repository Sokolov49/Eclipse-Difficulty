--doing this within lua is more fun than actually replacing the movies (not really)
function BootupState:setup_intro_videos()
	local res = RenderSettings.resolution
	local safe_rect_pixels = managers.gui_data:scaled_size()
	local legal_text = managers.localization:text("legal_text")
	local item_layer = self._back_drop_gui:background_layers()
	local intro_trailer_layer = self._back_drop_gui:foreground_layers()
	local completed_whitehouse = MenuCallbackHandler.has_only_one_movie

--this will play the bain burial ending if the player completed whitehouse
--otherwise, it plays hoxton safehouse trailer
if completed_whitehouse then
	table.insert(self._play_data_list, {
		video = "movies/the_end",
		can_skip = true,
		padding = 200,
		limit_file_streamer = true,
		layer = intro_trailer_layer,
		width = res.x,
		height = res.y
	})
else
	table.insert(self._play_data_list, {
		video = "movies/new_safehouse",
		can_skip = true,
		padding = 200,
		limit_file_streamer = true,
		layer = intro_trailer_layer,
		width = res.x,
		height = res.y
	})
end
	table.insert(self._play_data_list, {
		word_wrap = true,
		vertical = "center",
		wrap = true,
		font_size = 24,
		padding = 200,
		fade_in = 1.25,
		fade_out = 1.25,
		can_skip = true,
		duration = 6,
		layer = item_layer,
		text = legal_text,
		font = tweak_data.menu.pd2_medium_font,
		width = safe_rect_pixels.width,
		height = safe_rect_pixels.height
	})
end