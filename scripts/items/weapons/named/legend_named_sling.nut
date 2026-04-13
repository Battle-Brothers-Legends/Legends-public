this.legend_named_sling <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_sling";
		this.m.NameList = this.Const.Strings.SlingNames;
		this.m.Description = "This sling is reinforced and features a high quality leather pouch. Used to pelt your enemies with rocks. With stones abundant everywhere, it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/1h_sling_named_01.png";
		this.m.Icon = "weapons/ranged/1h_sling_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_named_1h_sling_01";
		this.m.Value = 2900;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.4;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.DirectDamageAdd = 0.1;
		this.randomizeValues();
	}


	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.SlingStone);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendWindUp);
	}

});
