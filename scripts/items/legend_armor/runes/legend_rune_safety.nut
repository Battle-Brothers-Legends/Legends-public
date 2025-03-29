this.legend_rune_safety <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.legend_rune_safety";
		this.m.Type = this.Const.Items.ArmorUpgrades.Rune;
		this.m.Name = "Armor Rune Sigil: Safety";
		this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
		this.m.ArmorDescription = "Includes An inscribed rock that grants additional safety bonuses.";
		this.m.Icon = "rune_sigils/rune_stone_3.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "layers/glow_runed_icon.png";
		this.m.OverlayIconLarge = "layers/glow_runed_inventory.png";
		this.m.SpriteFront = "";
		this.m.SpriteBack = "";
		this.m.SpriteDamagedFront = "";
		this.m.SpriteDamagedBack = "";
		this.m.SpriteCorpseFront = "";
		this.m.SpriteCorpseBack = "";
		this.m.Value = 1200;
		this.setRuneVariant(::Legends.Rune.LegendRsaSafety);
		this.setRuneBonus(false); // false = unupgraded enchanter stats. true = upgraded enchanter stats
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Safety:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getRuneBonus1() + "%[/color] Hitpoints.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.getRuneBonus2() + "%[/color] Damage received."
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Safety:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getRuneBonus1() + "%[/color] Hitpoints.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.getRuneBonus2() + "%[/color] Damage received."
		});
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		return _damage;
	}
});

