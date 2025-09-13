this.legend_named_rusty_serrated_axe <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.legend_named_rusty_serrated_axe";
		this.m.NameList = this.Const.Strings.AxeNames;
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.SuffixList = this.Const.Strings.BarbarianSuffix;
		this.m.UseRandomName = false;
		this.m.Description = "The rust on this axe could fool you that the blade is dull, but just checking its edge almost cost you your thumb. The serrated teeth can cause horrific wounds, while the axe itself is uniquely suited to decapitations.";
		this.m.Categories = "Axe, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 96.0;
		this.m.ConditionMax = 96.0;
		this.m.StaminaModifier = -22;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = 0.1;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color] lower threshold to inflict injuries"
		});
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_named_rusty_serrated_axe_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_named_rusty_serrated_axe_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_named_rusty_serrated_axe_0" + this.m.Variant;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != null && _skill.IsWeaponSkill)
		{
			_properties.ThresholdToInflictInjuryMult *= 0.66;
		}
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Chop, function (_skill) {
			_skill.m.FatigueCost = 15;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.ApplyAxeMastery = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.RoundSwing);
	}

});

