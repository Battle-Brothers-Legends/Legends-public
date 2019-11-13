this.legend_sackcloth_patched <- this.inherit("scripts/items/legend_armor/cloth/legend_sackcloth", {
	m = {},
	function create()
	{
		this.legend_sackcloth.create();
		this.m.ID = "legend.armor.body.patched_sackcloth";
		this.m.Name = "Leather Wraps";
		this.m.Description = "Various patches of rough leather sewn together.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
        local variants = [
            3,
			19,
			20,
			21,
			22,
			23,
			24,
			25
        ]
		this.m.Variant = variants[this.Math.rand(1, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 35;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = 0;
	}

});

