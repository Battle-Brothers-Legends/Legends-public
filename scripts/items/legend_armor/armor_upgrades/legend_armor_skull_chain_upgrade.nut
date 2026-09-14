this.legend_armor_skull_chain_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_skull_chain";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Skull Chain";
		this.m.Description = "A dead man's skull hanging on a heavy chain. An unmistakable mark of a headhunter.";
		this.m.ArmorDescription = "Includes a human skull on a heavy chain.";
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 150;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -2;
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "pauldrons_skull_chain_" + variant + "";
		this.m.SpriteDamagedBack = "pauldrons_skull_chain_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "pauldrons_skull_chain_" + variant + "_dead";
		this.m.Icon = "legend_armor/upgrades/pauldrons_skull_chain_" + variant + "_upgrade.png";
		this.m.IconLarge = "legend_armor/inventory_pauldrons_skull_chain_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_pauldrons_skull_chain_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_pauldrons_skull_chain_"  + variant + ".png";
	}

	function updateTooltip( _tooltip )	{
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Has a [color=%positive%]+5%[/color] Chance To Hit Head"
		});
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Builds up [color=%negative%]1[/color] more fatigue for each tile travelled"
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
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
		_properties.MovementFatigueCostAdditional += 1;
	}
});

