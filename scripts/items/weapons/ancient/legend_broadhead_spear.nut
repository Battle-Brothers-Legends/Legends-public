this.legend_broadhead_spear <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_broadhead_spear";
		this.m.Name = "Ancient Broadhead Spear";
		this.m.Description = "A larger, broader ancient spear with a leaf-shaped head. It is much heavier than it\'s counterparts, but leaves a significantly larger wound at the cost of penetrating power.";
		this.m.IconLarge = "weapons/melee/ancient_spear_01_2.png";
		this.m.Icon = "weapons/melee/ancient_spear_01_2_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Defensive;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_ancient_spear_01_2";
		this.m.Value = 1050;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.35;
		this.m.DirectDamageMult = 0.25;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.Spearwall);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

