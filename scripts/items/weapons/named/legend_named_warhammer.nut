this.legend_named_warhammer <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "weapon.legend_named_warhammer";
		this.m.NameList = this.Const.Strings.HammerNames;
		this.m.Description = "An ornate iron mastercrafted warhammer that easily destroys armor and breaks bones. ";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
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

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_named_warhammer_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_named_warhammer_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_named_warhammer_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Hammer);
		::Legends.Actives.grant(this, ::Legends.Active.CrushArmor);
		::Legends.Actives.grant(this, ::Legends.Active.LegendPryArmor);
	}

});

