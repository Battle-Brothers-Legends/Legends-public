this.legend_named_bronze_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.named_bronze_armor";
		this.m.Description = "This armor is composed of a strange alloy, and well crafted for barbarian standards. A truly rare and remarkable piece.";
		this.m.NameList = [
			"Tarnished Harness",
			"Alloy Plate Armor",
			"Tainted Bulwark",
			"Tribal Plate"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.Variant = 103;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 9000;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -38;
		this.randomizeValues();
	}

});

