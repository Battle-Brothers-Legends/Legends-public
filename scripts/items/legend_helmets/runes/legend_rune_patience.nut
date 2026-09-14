this.legend_rune_patience <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.ID = "legend_helmet_upgrade.legend_rune_patience";
		this.m.Type = this.Const.Items.HelmetUpgrades.Rune;
		this.m.Name = "Helmet Rune Sigil: Patience";
		this.m.Description = "An inscribed rock that can be attached to a character\'s helmet to increase the wearer's patience.";
		this.m.ArmorDescription = "Includes a patience rune.";
		this.m.Icon = "rune_sigils/rune_stone_2.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "layers/glow_runed_icon.png";
		this.m.OverlayIconLarge = "layers/glow_runed_icon.png";
		this.m.Sprite = "bust_legend_helmet_runed";
		this.m.Value = 1200;
		this.setRuneVariant(::Legends.Rune.LegendRshPatience);
		this.setRuneBonus(false); // false = unupgraded enchanter stats. true = upgraded enchanter stats
	}

	function updateVariant()
	{
	}
});

