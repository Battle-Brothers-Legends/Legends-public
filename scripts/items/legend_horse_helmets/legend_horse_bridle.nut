this.legend_horse_bridle <- this.inherit("scripts/items/legend_horse_helmets/legend_horse_helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "legend.armor.helmet.horse_bridle";
		this.m.Name = "Horse Bridle";
		this.m.Description = "Mwah has absolutely no idea what a horse bridle is but it sure sounds cool. Stick this on your horse and find out.";
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			"black_brown",
			"black_white",
			"black_yellow",
			"blue_green",
			"blue_red",
			"blue_white",
			"blue_yellow",
			"brown",
			"green_yellow",
			"red_yellow",
			"white_black",
			"yellow_black"
		];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = ::Const.Sound.ClothEquip;
		this.m.Value = 1500;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
		this.m.StaminaModifier = -15;
	}

	function updateVariant()
	{
		this.m.Sprite = "horse_armor_hood_" + this.m.Variant;
		this.m.SpriteDamaged = "horse_armor_hood_" + this.m.Variant + "_damaged";
		this.m.SpriteCorpse = "horse_armor_hood_" + this.m.Variant + "_dead";
		this.m.IconLarge = "rune_sigils/rune_stone_1.png";
		this.m.Icon = "rune_sigils/rune_stone_1.png";
	}

});

