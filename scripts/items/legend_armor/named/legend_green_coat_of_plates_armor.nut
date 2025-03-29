this.legend_green_coat_of_plates_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.green_coat_of_plates";
		this.m.Description = "A rare coat of plates enhanced with chainmail and additional padding. A piece of true craftsmanship!";
		this.m.NameList = [
			"Coat of Plates",
			"Bulwark",
			"Carapace",
			"Shell",
			"Plate Cuirass",
			"Plate Coat",
			"Harness",
			"Ward"
		];
		this.m.Variant = 43;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 15000;
		this.m.Condition = 320;
		this.m.ConditionMax = 320;
		this.m.StaminaModifier = -42;
		this.randomizeValues();
	}

});

