if (!("Camp" in ::Legends))
	::Legends.Camp <- {};

::Legends.Camp.Tent <- {
	Craft = "tent.craft_tent",
	Enchant = "tent.enchant_tent",
	Fletcher = "tent.fletcher_tent",
	Gather = "tent.gather_tent",
	Healer = "tent.healer_tent",
	Hunter = "tent.hunter_tent",
	Repair = "tent.repair_tent",
	Scout = "tent.scout_tent",
	Scrap = "tent.scrap_tent",
	Training = "tent.training_tent"
};

::Legends.Camp.Tents <- [{
		ID = ::Legends.Camp.Tent.Craft,
		Script = "tents/legend_tent_craft"
	}, {
		ID = ::Legends.Camp.Tent.Enchant,
		Script = "tents/legend_tent_enchant"
	}, {
		ID = ::Legends.Camp.Tent.Fletcher,
		Script = "tents/legend_tent_fletcher"
	}, {
		ID = ::Legends.Camp.Tent.Gather,
		Script = "tents/legend_tent_gather"
	}, {
		ID = ::Legends.Camp.Tent.Healer,
		Script = "tents/legend_tent_heal"
	}, {
		ID = ::Legends.Camp.Tent.Hunter,
		Script = "tents/legend_tent_hunter"
	}, {
		ID = ::Legends.Camp.Tent.Repair,
		Script = "tents/legend_tent_repair"
	}, {
		ID = ::Legends.Camp.Tent.Scout,
		Script = "tents/legend_tent_scout"
	}, {
		ID = ::Legends.Camp.Tent.Scrap,
		Script = "tents/legend_tent_scrap"
	}, {
		ID = ::Legends.Camp.Tent.Training,
		Script = "tents/legend_tent_train"
	}
];
