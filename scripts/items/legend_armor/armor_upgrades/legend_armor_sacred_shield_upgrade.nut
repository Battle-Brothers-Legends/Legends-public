this.legend_armor_sacred_shield_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_sacred_shield";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Sacred Shield";
		this.m.Description = "A holy relic shield to be strapped to the shoulder, it protects the wearer both physically and spiritually. Primarily of benefit to the strong of mind.";
		this.m.ArmorDescription = "Includes a holy relic shield.";
		this.m.Variants = [1,2,3,4,5,6];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 1500;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_belt_shield_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_belt_shield_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_belt_shield_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_belt_shield_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_belt_shield_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_belt_shield_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_belt_shield_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=%positive%]+5%[/color] Resolve"
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
		_properties.BraveryMult *= 1.05;
	}
});

