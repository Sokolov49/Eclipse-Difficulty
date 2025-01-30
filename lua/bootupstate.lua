function BootupState:setup_intro_videos()
	local res = RenderSettings.resolution
	local safe_rect_pixels = managers.gui_data:scaled_size()
	local legal_text = managers.localization:text("legal_text")
	local item_layer = self._back_drop_gui:background_layers()
	local intro_trailer_layer = self._back_drop_gui:foreground_layers()
	local completed_whitehouse = MenuCallbackHandler.has_only_one_movie

	--this will play the bain burial ending if the player completed whitehouse
	--otherwise, it plays the normal trailer from 2013
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
			video = "movies/game_intro",
			can_skip = true,
			padding = 200,
			layer = item_layer,
			width = res.x,
			height = res.y
		})
	end
end