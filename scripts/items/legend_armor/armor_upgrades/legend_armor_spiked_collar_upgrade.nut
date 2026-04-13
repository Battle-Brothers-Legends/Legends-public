this.legend_armor_spiked_collar_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_spiked_collar";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Spiked Coif";
		this.m.Description = "A noisy spiked mail collar offering a modicum of defense.";
		this.m.ArmorDescription = "Includes a spiked mail collar.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_spiked_chain_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_spiked_chain_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_spiked_chain_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_spiked_chain_" + variant + "_upgrade.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_spiked_chain_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_spiked_chain_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "[color=%positive%]+3[/color] Melee Defense"
		});
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=%negative%]-6[/color] Initiative"
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
		_properties.MeleeDefense += 3;
		_properties.Initiative -= 6;
	}
});

