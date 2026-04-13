this.legend_armor_chain_and_mail_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_chain_and_mail";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Amulet Coif";
		this.m.Description = "An expensive amulet on a gold chain set on a mail collar. Certain to attract attention.";
		this.m.ArmorDescription = "Includes an expensive chain on a mail collar.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_chain_and_mail_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_chain_and_mail_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_chain_and_mail_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_chain_and_mail_" + variant + "_upgrade.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_chain_and_mail_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_chain_and_mail_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=%positive%]+3[/color] Resolve"
		});
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Doubles enemy desire to attack you in battle"
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
		_properties.Bravery += 3;
		_properties.TargetAttractionMult *= 2.0;
	}
});

