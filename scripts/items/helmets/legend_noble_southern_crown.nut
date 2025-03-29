this.legend_noble_southern_crown <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.noble_southern_crown";
		this.m.Name = "Southern Noble Crown";
		this.m.Description = "A fine crown made of metal.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 800;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = 0;
	}
	
		function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "southern_noble_crown_" + variant;
		this.m.SpriteDamaged = "southern_noble_crown_" + variant + "_damaged";
		this.m.SpriteCorpse = "southern_noble_crown_" + variant + "_dead";
		this.m.IconLarge = "legend_helmets/southern_noble_crown_" + variant + ".png";
		this.m.Icon = "legend_helmets/southern_noble_crown_" + variant + ".png";
	}

});

