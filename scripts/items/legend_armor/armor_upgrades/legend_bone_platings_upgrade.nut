this.legend_bone_platings_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_bone_platings";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Bone Plating";
		this.m.Description = "An ablative armor made of ornate bone platings, crafted from strong but surprisingly light bones. Worn on top of regular armor.";
		this.m.ArmorDescription = "Includes an armor made of ornate bone plates.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorBoneImpact;
		this.m.InventorySound = this.Const.Sound.ArmorBoneImpact;
		this.m.Value = 850;
		this.m.StaminaModifier = -2;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_bone_platings_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_bone_platings_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_bone_platings_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_bone_platings_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_bone_platings_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_bone_platings_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_bone_platings_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Completely absorbs the first hit of every combat encounter which doesn\'t ignore armor"
		});
		return _tooltip;
	}

	function getTooltip()	{
		return updateTooltip(this.legend_armor_upgrade.getTooltip());
	}

	function onArmorTooltip( _result )	{
		this.legend_armor_upgrade.onArmorTooltip(updateTooltip(_result));
	}

	function onCombatStarted()
	{
		this.addSkill(::Legends.Effects.new(::Legends.Effect.LegendBonePlating));
	}
});

