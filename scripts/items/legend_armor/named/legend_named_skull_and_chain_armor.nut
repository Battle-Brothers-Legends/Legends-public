this.legend_named_skull_and_chain_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.named_skull_and_chain_armor";
		this.m.Description = "A barbarian armor of crude making that has been adjusted to protect without being too cumbersome. It wears the typical markings of the northern barbarian tribes.";
		this.m.NameList = [
			"Tribal Hide",
			"Barbarian Coat",
			"Scavenged Armor",
			"Barbarian Pelt",
			"Primitive Harness"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.Variant = 102;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5500;
		this.m.Condition = 190;
		this.m.ConditionMax = 190;
		this.m.StaminaModifier = -24;
		this.randomizeValues();
	}

});

