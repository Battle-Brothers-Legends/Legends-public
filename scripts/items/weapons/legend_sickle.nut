this.legend_sickle <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.sickle";
		this.m.Name = "Sickle";
		this.m.Description = "A tool for gathering plants, can also gather ears";
		this.m.IconLarge = "weapons/melee/legend_sickle_01.png";
		this.m.Icon = "weapons/melee/legend_sickle_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_sickle_01";
		this.m.Value = 45;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.StaminaModifier = -3;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageMult = -0.05;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash);
		::Legends.Actives.grant(this, ::Legends.Active.Gash);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestBush);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

