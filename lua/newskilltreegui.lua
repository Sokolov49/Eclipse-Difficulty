--[[
IMAGE TRANSPARENCY
This value sets how see-through the background images are.
0 (minimum value) is invisible. 1 (maximum value) is very visible.

default: 0.6
--]]
local image_transparency = 0.6

--[[
ASPECT RATIO ADJUSTMENT METHOD
PAYDAY 2 normally scales background images to your game's resolution,
not the resolution the main menu is actually being displayed at. This
means using any aspect ratio except 16:9 could be cutting off portions
of the image. I've attempted to fix this so that the images are scaled
to the menu's actual rendered resolution.

For people who see black bars at their main menu, this should make
images fit a little better.

If it's causing problems, your menu doesn't render at 16:9 for some
reason, or you just want the old scaling method back, set
adjust_aspect_ratio = false.
--]]
local adjust_aspect_ratio = true








function NewSkillTreeGui:setbgimg(page, init)
	local bgpanels = { "_bg_image1", "_bg_image2", "_bg_image3", "_bg_image4", "_bg_image5" }

	if init then
		if self._fullscreen_ws then
			managers.gui_data:destroy_workspace(self._fullscreen_ws)
		end
		self._fullscreen_ws = nil
		self._fullscreen_panel = nil
		self._bg_image1 = nil
		self._bg_image2 = nil
		self._bg_image3 = nil
		self._bg_image4 = nil
		self._bg_image5 = nil

		self._fullscreen_ws = managers.gui_data:create_fullscreen_workspace()
		self._fullscreen_panel = self._fullscreen_ws:panel():panel({name = "fullscreen"})

		self._bg_image1 = self._fullscreen_panel:bitmap({
			name = "bg_image1",
			texture = "guis/textures/pd2/skilltree/bg_mastermind",
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h(),
			layer = 1,
			blend_mode = "add"
		})

		self._bg_image2 = self._fullscreen_panel:bitmap({
			name = "bg_image2",
			texture = "guis/textures/pd2/skilltree/bg_enforcer",
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h(),
			layer = 1,
			blend_mode = "add"
		})

		self._bg_image3 = self._fullscreen_panel:bitmap({
			name = "bg_image3",
			texture = "guis/textures/pd2/skilltree/bg_technician",
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h(),
			layer = 1,
			blend_mode = "add"
		})

		self._bg_image4 = self._fullscreen_panel:bitmap({
			name = "bg_image4",
			texture = "guis/textures/pd2/skilltree/bg_ghost",
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h(),
			layer = 1,
			blend_mode = "add"
		})

		self._bg_image5 = self._fullscreen_panel:bitmap({
			name = "bg_image5",
			texture = "guis/textures/pd2/skilltree/bg_fugitive",
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h(),
			layer = 1,
			blend_mode = "add"
		})
	end


	for i, panel in ipairs(bgpanels) do
		self[panel]:set_alpha(image_transparency)
		local aspect = self._fullscreen_panel:w() / self._fullscreen_panel:h()
		local texture_width = self[panel]:texture_width()
		local texture_height = self[panel]:texture_height()

	if adjust_aspect_ratio == true then
		local correct_height = self._fullscreen_panel:w() / (16/9) -- actual menu aspect ratio
		self[panel]:set_size(correct_height, correct_height)
	else
		local sw = math.max(texture_width, texture_height * aspect)
		local sh = math.max(texture_height, texture_width / aspect)
		local dw = texture_width / sw
		local dh = texture_height / sh
		self[panel]:set_size(dw * self._fullscreen_panel:w(), dh * self._fullscreen_panel:h())
	end

		self[panel]:set_right(self._fullscreen_panel:w())
		self[panel]:set_center_y(self._fullscreen_panel:h() / 2)
	end

	for i, panel in ipairs(bgpanels) do
		self[panel]:set_visible(false)
	end

	if page == 1 then
		self._bg_image1:set_visible(true)
	elseif page == 2 then
		self._bg_image2:set_visible(true)
	elseif page == 3 then
		self._bg_image3:set_visible(true)
	elseif page == 4 then
		self._bg_image4:set_visible(true)
	elseif page == 5 then
		self._bg_image5:set_visible(true)
	end
end

Hooks:PreHook( NewSkillTreeGui , "init" , "gibskillbg_init" , function( self , params )
	NewSkillTreeGui:setbgimg(1, true)
end)

Hooks:PostHook( NewSkillTreeGui , "set_active_page" , "gibskillbg_setpage" , function( self , params )
	NewSkillTreeGui:setbgimg(self._active_page, false)
end)

Hooks:PostHook( NewSkillTreeGui , "close" , "gibtest2" , function( self , params )
	NewSkillTreeGui:setbgimg(0, false)
end)