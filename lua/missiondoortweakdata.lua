	--Fix for doors that using shaped charge from second slot.
	local data = MissionDoorTweakData.init
	function MissionDoorTweakData:init(tweak_data)
		data(self, tweak_data)
		self.reinforced_door_single.devices.c4[1].unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		self.keycard_door_single.devices.c4[1].unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		self.keycard_door_single.devices.c4[2].unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		self.cage_door_deluxe.devices.c4[1].unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
		self.cage_door_deluxe_non_jamming.devices.c4[1].unit = Idstring("units/payday2/equipment/gen_equipment_shape_charge/gen_equipment_shape_charge")
	end