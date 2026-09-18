this.legend_wooden_spear <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_wooden_spear";
		this.m.Name = "Wooden Spear";
		this.m.Description = "A large branch whittled to a fine point. It\'s so unbalanced and irregular you need to use two hands just to keep it steady. Liable to snap at any moment. Deals additional damage to vampires";
		this.m.IconLarge = "weapons/melee/legend_wooden_spear_01.png";
		this.m.Icon = "weapons/melee/legend_wooden_spear_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Spear;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded | ::Const.Items.ItemType.Defensive;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_wooden_spear_01";
		this.m.Value = 15;
		this.m.Condition = 16.0;
		this.m.ConditionMax = 16.0;
		this.m.StaminaModifier = -6;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 5;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.45;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = -0.05;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Thrust);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHeartseeker);
		::Legends.Actives.grant(this, ::Legends.Active.Spearwall);
		::Legends.Actives.grant(this, ::Legends.Active.LegendThrowBackupSpear);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

