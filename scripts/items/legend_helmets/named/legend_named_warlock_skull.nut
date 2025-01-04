this.legend_named_warlock_skull <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Top;
		this.m.ID = "armor.head.legend_named_warlock_skull";
        this.m.NameList = this.Const.Strings.LegendArmorLayers;
		this.m.Description = "A skull faceplate fashioned with dark magic and dead bodies. Wearing this makes the wearer feel invulnerable.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1, 2, 3];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 2000;
		this.m.Condition = 90; // rolls 90-115
		this.m.ConditionMax = 90;
		this.m.StaminaModifier = -2;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = false;
		this.m.HideBeard = true;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Cultist;
        this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Whenever getting hurt would normally trigger a morale check, instead gain [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] morale"
		});
		return result;
	}

	// taste the pain
	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		ret = this.legend_helmet_upgrade.onDamageReceived(_damage, _fatalityType, _attacker);

		if (_attacker == null)
			return;

		if (_attacker.isAlliedWith(this.getContainer().getActor()))
			return;

		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null)
			return;

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() != _attacker.getID())
			return;

		this.getContainer().getActor().getCurrentProperties().MoraleCheckBravery[0] += 10;
		this.getContainer().getActor().getCurrentProperties().MoraleCheckBravery[1] += 10;
		this.getContainer().getActor().getCurrentProperties().MoraleCheckBravery[2] += 10;

		return ret;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_named_helmet_upgrade.onUpdateProperties( _properties )
		_properties.IsAffectedByLosingHitpoints = false;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_warlock_skull" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_warlock_skull" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_warlock_skull" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_warlock_skull" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function randomizeValues()
	{
        this.m.Vision = this.Math.rand(0, 1) * -1 ;
		this.m.StaminaModifier = this.Math.rand(1, 2) * -1;
		this.m.Condition = this.Math.rand(90, 115);
		this.m.ConditionMax = this.m.Condition;
	}
});
