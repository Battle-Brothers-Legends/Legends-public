this.legend_shiv <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_shiv";
		this.m.Name = "Shank";
		this.m.Description = "A makeshift weapon fashioned from a rusty metal scrap wrapped in cloth. Fit only for the desperate or deranged.";
		this.m.IconLarge = "weapons/melee/legend_shiv_01.png";
		this.m.Icon = "weapons/melee/legend_shiv_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_shiv_01";
		this.m.Value = 3;
		this.m.Condition = 13.0;
		this.m.ConditionMax = 13.0;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = -0.05;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Stab);
		::Legends.Actives.grant(this, ::Legends.Active.Puncture);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

