this.legend_direwolf_pelt_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_direwolf_pelt_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Direwolf Pelt Mantle";
		this.m.Description = "A cloak sewn from the cured pelts taken from ferocious direwolves, worn as a beast hunter\'s trophy. It looks imposing when donned.";
		this.m.ArmorDescription = "Includes a cloak sewn from the cured direwolf pelts.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 600;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = 0;
		this.m.ThreatModifier = 5;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_pelt_wolf_dire_" + variant + "_back";
		this.m.SpriteDamagedBack = "cloak_pelt_wolf_dire_" + variant + "_back_damaged";
		this.m.SpriteCorpseBack = "cloak_pelt_wolf_dire_" + variant + "_back_dead";
		this.m.SpriteFront = "cloak_pelt_wolf_dire_" + variant + "_front";
		this.m.SpriteDamagedFront = "cloak_pelt_wolf_dire_" + variant + "_front_damaged";
		this.m.SpriteCorpseFront = "cloak_pelt_wolf_dire_" + variant + "_front_dead";
		this.m.Icon = "legend_armor/icon_cloak_pelt_wolf_dire_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_pelt_wolf_dire_"  + variant + ".png";;
		this.m.OverlayIcon = "legend_armor/icon_cloak_pelt_wolf_dire_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_pelt_wolf_dire_"  + variant + ".png";
	}
});