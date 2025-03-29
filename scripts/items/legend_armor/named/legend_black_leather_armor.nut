this.legend_black_leather_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.black_leather";
		this.m.Description = "A well-crafted and hardened leather armor supported by a padded gambeson and chainmail. Light to wear but very sturdy.";
		this.m.NameList = [
			"Leather Cuirass",
			"Mail Shirt",
			"Leather Armor",
			"Skin",
			"Peel",
			"Guard",
			"Coat",
			"Nightcloak",
			"Black",
			"Dark Omen"
		];
		this.m.Variant = 42;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 2000;
		this.m.Condition = 110;
		this.m.ConditionMax = 110;
		this.m.StaminaModifier = -11;
		this.randomizeValues();
	}

});

