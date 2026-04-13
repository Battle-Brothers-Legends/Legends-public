this.legend_named_warlock_skull <- this.inherit("scripts/items/legend_helmets/legend_named_helmet_upgrade", {
	m = {
		StackCount = 0
	},
	function create()
	{
		this.legend_named_helmet_upgrade.create();
		this.m.ID = "armor.head.legend_named_warlock_skull";
		this.m.Type = this.Const.Items.HelmetUpgrades.Top;
		this.m.Name = "Warlock Faceplate";
		this.m.Description = "A skull faceplate fashioned with dark magic and dead bodies. Wearing this makes the wearer feel invulnerable.";
		this.m.ArmorDescription = "Includes a skull faceplate fashioned with dark magic.";
		this.m.Variants = [1,2,3];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorBoneImpact;
		this.m.InventorySound = this.Const.Sound.ArmorBoneImpact;
		this.m.Value = 2000;
		this.m.Condition = 90; // rolls 90-115
		this.m.ConditionMax = 90;
		this.m.StaminaModifier = -2;
		this.m.Vision = 0;
		this.m.Lower = true;
		this.m.HideHair = false;
		this.m.HideBeard = true;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Cultist;
        this.randomizeValues();
		this.m.NameList = this.Const.Strings.LegendHelmetLayers;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_warlock_skull_" + variant;
		this.m.SpriteDamaged = "legendhelms_warlock_skull_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_warlock_skull_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_warlock_skull_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain [color=%positive%]+10[/color] bonus to resolve in morale checks for every hit you took in the battle"
		});
		return result;
	}

	function resetStats()
	{
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
		this.m.StaminaModifier = -2;
		this.m.Vision = 0;
	}

	// taste the pain, kinda
	function onDamageReceived (_damage, _fatalityType, _attacker)
	{
		local ret = this.legend_helmet_upgrade.onDamageReceived(_damage, _fatalityType, _attacker);

		if (_attacker == null)
			return ret;

		if (_attacker.isAlliedWith(this.getContainer().getActor()))
			return ret;

		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null)
			return ret;

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() != _attacker.getID())
			return ret;

		++this.m.StackCount;
		
		return ret;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_named_helmet_upgrade.onUpdateProperties( _properties );
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.MoraleCheckBravery[0] += this.m.StackCount * 10;
		_properties.MoraleCheckBravery[1] += this.m.StackCount * 10;
		_properties.MoraleCheckBravery[2] += this.m.StackCount * 10;
	}

	function randomizeValues()
	{
        this.m.Vision = this.Math.rand(0, 1) * -1 ;
		this.m.StaminaModifier = this.Math.rand(1, 2) * -1;
		this.m.Condition = this.Math.rand(90, 115);
		this.m.ConditionMax = this.m.Condition;
	}

	
	function onCombatFinished()
	{
		this.m.StackCount = 0;
	}
});
