this.legend_hyena_fur_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_hyena_fur_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Hyena Fur Mantle";
		this.m.Description = "A cloak sewn from the cured furs taken from ferocious hyenas, worn as a beast hunter\'s trophy. It bolsters the wearer's drive to action when donned.";
		this.m.ArmorDescription = "Includes a cloak sewn from cured hyena furs.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 600;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.InitiativeModifier = 15;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_fur_hyena_" + variant + "_back";
		this.m.SpriteDamagedBack = "cloak_fur_hyena_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "cloak_fur_hyena_" + variant + "_back_dead";
		this.m.SpriteFront = "cloak_fur_hyena_" + variant + "_front";
		this.m.SpriteDamagedFront = "cloak_fur_hyena_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "cloak_fur_hyena_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/icon_cloak_fur_hyena_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_fur_hyena_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_fur_hyena_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_fur_hyena_"  + variant + ".png";
	}
});