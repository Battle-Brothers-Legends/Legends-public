this.legend_barbarian_horn_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_barbarian_horn";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Horn and Bone";
		this.m.Description = "The ceremonial adornment of a self-proclaimed barbarian king. The rare and durable horns act as an surprisingly effective armor.";
		this.m.ArmorDescription = "Includes a ceremonial horn adornment.";
		this.m.Variants = [1,2,3,4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorBoneImpact;
		this.m.InventorySound = this.Const.Sound.ArmorBoneImpact;
		this.m.Value = 250;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.ConditionModifier = 40;
		this.m.StaminaModifier = -3;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_barbarian_horn_" + variant + "_back";
		this.m.SpriteDamagedBack = "pauldrons_barbarian_horn_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "pauldrons_barbarian_horn_" + variant + "_back_dead";
		this.m.SpriteFront = "pauldrons_barbarian_horn_" + variant + "_front";
		this.m.SpriteDamagedFront = "pauldrons_barbarian_horn_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "pauldrons_barbarian_horn_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_barbarian_horn_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_barbarian_horn_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_barbarian_horn_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_barbarian_horn_"  + variant + ".png";
	}

	function onArmorTooltip( _result )
	{
	}

});

