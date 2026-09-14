this.legend_armor_white_wolf_pelt_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_armor_white_wolf_pelt_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "White Wolf Pelt Mantle";
		this.m.Description = "A cloak swen from the cured pelts taken from white wolves, worn as a beast hunter\'s trophy. It looks terrifying when donned.";
		this.m.ArmorDescription = "Includes a cloak sewn from the cured white wolf pelts.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 6000;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -2;
		this.m.ThreatModifier = 15;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_pelt_wolf_white_" + variant + "_back";
		this.m.SpriteDamagedBack = "cloak_pelt_wolf_white_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "cloak_pelt_wolf_white_" + variant + "_back_dead";
		this.m.SpriteFront = "cloak_pelt_wolf_white_" + variant + "_front";
		this.m.SpriteDamagedFront = "cloak_pelt_wolf_white_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "cloak_pelt_wolf_white_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/icon_cloak_pelt_wolf_white_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_pelt_wolf_white_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_pelt_wolf_white_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_pelt_wolf_white_"  + variant + ".png";
	}
});