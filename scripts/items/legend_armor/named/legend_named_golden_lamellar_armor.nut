this.legend_named_golden_lamellar_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.named_golden_lamellar_armor";
		this.m.Description = "An extraordinarily well-crafted piece of lamellar armor. It is covered with beaten gold, which makes it truly stand out.";
		this.m.NameList = [
			"Harness",
			"Ward",
			"Defense",
			"Splendor",
			"Golden Lamellar"
		];
		this.m.Variant = 100;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 11000;
		this.m.Condition = 285;
		this.m.ConditionMax = 285;
		this.m.StaminaModifier = -40;
		this.randomizeValues();
	}

});

