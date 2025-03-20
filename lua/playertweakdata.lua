function PlayerTweakData:_set_normal()
	self.damage.REVIVE_HEALTH_STEPS = { 0.7 }
	self.damage.MIN_DAMAGE_INTERVAL = 0.4

	self.damage.automatic_respawn_time = 120
	self.alarm_pager.call_duration = {
		{6, 6},
		{6, 6}
	}
	self.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 0}
	self.fall_damage_alert_size = 0

	self.suspicion.max_value = 8
	self.suspicion.range_mul = 0.8
	self.suspicion.buildup_mul = 0.8
end

function PlayerTweakData:_set_hard()
	self.damage.REVIVE_HEALTH_STEPS = { 0.6 }
	self.damage.MIN_DAMAGE_INTERVAL = 0.3

	self.damage.automatic_respawn_time = 220
	self.damage.DOWNED_TIME_DEC = 7
	self.damage.DOWNED_TIME_MIN = 5
	self.damage.automatic_respawn_time = 120
	self.alarm_pager.call_duration = {
		{6, 6},
		{6, 6}
	}
	self.alarm_pager.bluff_success_chance = {1, 1, 1, 1, 0}
	self.fall_damage_alert_size = 0

	self.suspicion.max_value = 9
	self.suspicion.range_mul = 1
	self.suspicion.buildup_mul = 1
end

function PlayerTweakData:_set_overkill()
	self.damage.REVIVE_HEALTH_STEPS = { 0.5 }
	self.damage.MIN_DAMAGE_INTERVAL = 0.25
	self.fall_damage_alert_size = 0

	self.suspicion.max_value = 10
	self.suspicion.range_mul = 1.2
	self.suspicion.buildup_mul = 1.2
end

function PlayerTweakData:_set_overkill_145()
	self.damage.REVIVE_HEALTH_STEPS = { 0.4 }
	self.damage.MIN_DAMAGE_INTERVAL = 0.2
	self.fall_damage_alert_size = 0

	self.suspicion.max_value = 11
	self.suspicion.range_mul = 1.4
	self.suspicion.buildup_mul = 1.4
end

function PlayerTweakData:_set_easy_wish()
	self.damage.REVIVE_HEALTH_STEPS = { 0.4 }
	self.damage.MIN_DAMAGE_INTERVAL = 0.15

	self.suspicion.max_value = 12
	self.suspicion.range_mul = 1.7
	self.suspicion.buildup_mul = 1.7
end

Hooks:PostHook(PlayerTweakData, "init", "eclipse__init", function(self)
	self.damage.respawn_time_penalty = 0
	self.damage.BLEED_OUT_HEALTH_INIT = 23
	-- self.damage.REGENERATE_TIME = 4.5
	self.damage.DOWNED_TIME = 30
	self.damage.DOWNED_TIME_DEC = 0
	self.damage.DOWNED_TIME_MIN = 30
	self.damage.TASED_RECOVER_TIME = 2
	
		self.alarm_pager = {
		first_call_delay = {2, 4},
		call_duration = {
			{3, 6},
			{3, 6}
		},
		nr_of_calls = {2, 2},
		bluff_success_chance = {1, 1, 0},
		bluff_success_chance_w_skill = {1, 1, 1, 1, 0}
	}
	self.fall_damage_alert_size = 1000
	
	--normal player height
	self.stances.default.standard.head.translation = Vector3(0, 0, 160)
	
	-- breathing in ads
	self.stances.default.steelsight.shakers.breathing.amplitude = 0.095
end)

-- Game too hard for single player appparently????
function PlayerTweakData:_set_singleplayer() end

--lmg steelsights
local default_init_hk21 = PlayerTweakData._init_hk21
function PlayerTweakData:_init_hk21()
    default_init_hk21(self)
	local pivot_shoulder_translation = Vector3(8.54, 8, -3.29)
	local pivot_shoulder_rotation = Rotation(7.08051E-6, 0.00559065, 3.07211E-4)     
	local pivot_head_translation = Vector3(0, 10, 0) -- 8, 10, -1
	local pivot_head_rotation = Rotation(0, 0, 0) -- 0.2, 0.2, -8
	self.stances.hk21.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.hk21.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
end

-- KSP
local default_init_m249 = PlayerTweakData._init_m249
function PlayerTweakData:_init_m249()
    default_init_m249(self)
	local pivot_shoulder_translation = Vector3(10.716, 4, -0.55)
	local pivot_shoulder_rotation = Rotation(0.106596, -0.0844502, 0.629187)    
	local pivot_head_translation = Vector3(0, 12, 0) -- 10, 12, -2
	local pivot_head_rotation = Rotation(0, 0, 0) -- 0, 0, -5
	self.stances.m249.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m249.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
end


-- RPK
local default_init_rpk = PlayerTweakData._init_rpk
function PlayerTweakData:_init_rpk()
    default_init_rpk(self)
	local pivot_shoulder_translation = Vector3(10.6, 27.7166, -4.93564)
	local pivot_shoulder_rotation = Rotation(0.1067, -0.0850111, 0.629008)
	local pivot_head_translation = Vector3(0, 28, 0)  -- 6, 30, -1
	local pivot_head_rotation = Rotation(0, 0, 0)  -- 0, 0, -5
	self.stances.rpk.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.rpk.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
end


-- BUZZSAW
local default_init_mg42 = PlayerTweakData._init_mg42
function PlayerTweakData:_init_mg42()
    default_init_mg42(self)
	local pivot_shoulder_translation = Vector3(10.713, 47.8277, 0.873785)
	local pivot_shoulder_rotation = Rotation(0.10662, -0.0844545, 0.629209)
	local pivot_head_translation = Vector3(0, 40, 0)  -- default = 3,40,-2
	local pivot_head_rotation = Rotation(0, 0, 0)      -- default = 0, 0, -2
	self.stances.mg42.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.mg42.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
end


--M240
local default_init_par = PlayerTweakData._init_par
function PlayerTweakData:_init_par()
    default_init_par(self)
        local pivot_shoulder_translation = Vector3(10.020, 5, -3.94)
        local pivot_shoulder_rotation = Rotation(0, -0.0844502, 0.629187)    
        local pivot_head_translation = Vector3(0, 12, 0) -- 10, 12, -2
        local pivot_head_rotation = Rotation(0, 0, 0) -- 0, 0, -5
        self.stances.par.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
        self.stances.par.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
end

--M60
Hooks:PostHook(PlayerTweakData, "_init_m60", "PostHook_PlayerTweakData_init_m60", function(self)
	local pivot_shoulder_translation = Vector3(10.713, 47.8277, 0.873785)
	local pivot_shoulder_rotation = Rotation(0.10662, -0.0844545, 0.629209)
	local pivot_head_translation = Vector3(0, 40, 0)
	local pivot_head_rotation = Rotation(0, 0, 0)
	self.stances.m60.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
	self.stances.m60.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
end)