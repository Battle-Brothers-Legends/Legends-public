this.legend_noble_southern_hat <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.southern_noble_hat";
		this.m.Name = "Southern Noble Hat";
		this.m.Description = "A fine hat made of exotic materials.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		local variants = [
			1,
			2,
			3,
			4,
			5,
			6
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 80;
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.m.StaminaModifier = 0;
	}
	
		function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "southern_noble_hat_" + variant;
		this.m.SpriteDamaged = "southern_noble_hat_" + variant + "_damaged";
		this.m.SpriteCorpse = "southern_noble_hat_" + variant + "_dead";
		this.m.IconLarge = "legend_helmets/southern_noble_hat_" + variant + ".png";
		this.m.Icon = "legend_helmets/southern_noble_hat_" + variant + ".png";
	}

});

