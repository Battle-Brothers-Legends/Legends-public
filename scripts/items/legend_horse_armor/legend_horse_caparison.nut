this.legend_horse_caparison <- this.inherit("scripts/items/legend_horse_armor/legend_horse_armor", {
	m = {},
	function create()
	{
		this.legend_horse_armor.create();
		this.m.ID = "legend.armor.body.horse_caparison";
		this.m.Name = "Horse Caparison";
		this.m.Description = "Mwah has absolutely no idea what a horse caparison is but it sure sounds cool. Stick this on your horse and find out.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			"black",
			"blue",
			"blue_green",
			"blue_red",
			"blue_white",
			"blue_yellow",
			"brown",
			"green_yellow",
			"red_yellow",
			"white_black",
			"yellow_black",
			"yellow_red"
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 1500;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
		this.m.StaminaModifier = -15;
	}

	function updateVariant()
	{
		this.m.Sprite = "horse_caparison" + variant;
		this.m.SpriteDamaged = "horse_caparison" + variant + "_damaged";
		this.m.SpriteCorpse = "horse_caparison" + variant + "_dead";
		this.m.IconLarge = "rune_sigils/rune_stone_1.png";
		this.m.Icon = "rune_sigils/rune_stone_1.png";
	}

});

