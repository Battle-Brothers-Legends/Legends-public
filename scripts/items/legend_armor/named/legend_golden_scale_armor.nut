this.legend_golden_scale_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.golden_scale";
		this.m.Description = "A scale armor made of small, interlocking metal scales. The style and craftsmanship hint at the armor coming from a far-away region.";
		this.m.NameList = [
			"Scale Shirt",
			"Scale Armor",
			"Dragonskin",
			"Snakeskin",
			"Scales",
			"Wyrmskin",
			"Goldskin",
			"Scale Tunic",
			"Golden Armor",
			"Golden Reminder"
		];
		this.m.Variant = 44;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 8000;
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
		this.m.StaminaModifier = -30;
		this.randomizeValues();
	}

});

