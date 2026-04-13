this.legend_protective_runes_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_protective_runes";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Protective Runes and Sigils";
		this.m.Description = "A set of protective runes and sigils written on parched skin and emitting an unsettling aura.";
		this.m.ArmorDescription = "Includes a set of protective runes and sigils.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 1100;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_protective_runes_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_protective_runes_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_protective_runes_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_protective_runes_" + variant + "_upgrade.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_protective_runes_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_protective_runes_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=%positive%]+20[/color] Resolve at morale checks against fear, panic or mind control effects"
		});
		return _tooltip;
	}

	function getTooltip()	{
		return updateTooltip(this.legend_armor_upgrade.getTooltip());
	}

	function onArmorTooltip( _result )	{
		this.legend_armor_upgrade.onArmorTooltip(updateTooltip(_result));
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.MoraleCheckBravery[1] += 20;
	}

});

