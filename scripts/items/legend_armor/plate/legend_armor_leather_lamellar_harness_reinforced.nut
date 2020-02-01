
this.legend_armor_leather_lamellar_harness_reinforced <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate
		this.m.ID = "legend_armor.leather_lamellar_harness_reinforced";
		this.m.Name = "Reinforced Lamellar Harness";
		this.m.Description = "A body armor made of thick overlapping metal plates that cover most of the upper body.";
		this.m.ArmorDescription = "Includes body armor made of thick overlapping metal plates that cover most of the upper body.";
		this.m.Icon = "legend_armor/plate/legend_leather_lamellar_harness_reinforced.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/plate/icon_legend_leather_lamellar_harness_reinforced.png";
		this.m.OverlayIconLarge = "legend_armor/plate/inventory_legend_leather_lamellar_harness_reinforced.png";
		this.m.SpriteBack = "bust_legend_leather_lamellar_harness_reinforced";
		this.m.SpriteDamagedBack = "bust_legend_leather_lamellar_harness_reinforced_damaged";
		this.m.SpriteCorpseBack = "bust_legend_leather_lamellar_harness_reinforced_dead";
		this.m.Value = 3500;
		this.m.Condition = 130;
		this.m.ConditionMax = 130;
		this.m.StaminaModifier = -18;
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
	}

});

