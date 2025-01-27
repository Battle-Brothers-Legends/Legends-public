this.legend_named_warhammer <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_warhammer";
		this.m.NameList = this.Const.Strings.HammerNames;
		this.m.Description = "A legendary iron warhammer, all work is of the finest craftsmanship.";
		this.m.IconLarge = "weapons/melee/legend_named_hammer_01.png";
		this.m.Icon = "weapons/melee/legend_named_hammer_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_named_hammer_01";
		this.m.Value = 5000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 2.5;
		this.m.DirectDamageMult = 0.5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Hammer);
		::Legends.Actives.grant(this, ::Legends.Active.CrushArmor);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestRock);
	}

});

