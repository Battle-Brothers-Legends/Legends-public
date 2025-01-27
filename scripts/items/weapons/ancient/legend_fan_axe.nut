this.legend_fan_axe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_fan_axe";
		this.m.Name = "Ancient Fan Axe";
		this.m.Description = "A long, two-handed axe that doubles as a very heavy fan";
		this.m.IconLarge = "weapons/melee/legend_fan_axe_01.png";
		this.m.Icon = "weapons/melee/legend_fan_axe_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_fan_axe_01";
		this.m.Value = 3000;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 95;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Strike, function (_skill) {
			_skill.setApplyAxeMastery(true);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.RoundSwing);
		::Legends.Actives.grant(this, ::Legends.Active.SplitMan);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
	}

});

