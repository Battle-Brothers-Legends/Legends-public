this.legend_rune_endurance <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.legend_rune_endurance";
		this.m.Type = this.Const.Items.ArmorUpgrades.Rune;
		this.m.Name = "Armor Rune Sigil: Endurance";
		this.m.Description = "An inscribed rock that can be attached to a character\'s armor to increase the wearer's endurance.";
		this.m.ArmorDescription = "Includes an endurance rune.";
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
		this.setRuneVariant(::Legends.Rune.LegendRsaEndurance);
		this.setRuneBonus(false); // false = unupgraded enchanter stats. true = upgraded enchanter stats
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		return _damage;
	}
});

