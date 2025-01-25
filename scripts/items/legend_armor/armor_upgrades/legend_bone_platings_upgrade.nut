this.legend_bone_platings_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_bone_platings";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Bone Plating";
		this.m.Description = "Crafted from strong but surprisingly light bones, these ornate platings make for an ablative armor to be worn ontop of regular armor.";
		this.m.ArmorDescription = "A layer of ornate bone plates is attached to this armor.";
		this.m.Icon = "armor_upgrades/upgrade_06.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_06.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_06.png";
		this.m.SpriteBack = "upgrade_06_back";
		this.m.SpriteDamagedBack = "upgrade_06_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_06_back_dead";

		this.m.Value = 850;
		this.m.StaminaModifier = -2;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Completely absorbs the first hit of every combat encounter which doesn\'t ignore armor"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Completely absorbs the first hit of every combat encounter which doesn\'t ignore armor"
		});
	}

	function onCombatStarted()
	{
		this.addSkill(::Legends.Effects.new(::Legends.Effect.LegendBonePlating));
	}
});

