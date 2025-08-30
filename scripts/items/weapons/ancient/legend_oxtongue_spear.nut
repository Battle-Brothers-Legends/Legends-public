this.legend_oxtongue_spear <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_oxtongue_spear";
		this.m.Name = "Ancient Ox Tongue Spear";
		this.m.Description = "A double edged spear with a sleek yet wide profile compared to other spears, it excels at penetrating armour whilst remaining light enough for skirmishing.";
		this.m.IconLarge = "weapons/melee/ancient_spear_01_1.png";
		this.m.Icon = "weapons/melee/ancient_spear_01_1_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Defensive;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_ancient_spear_01_1";
		this.m.Value = 1050;
		this.m.Condition = 45.0;
		this.m.ConditionMax = 45.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.35;
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

