this.legend_cat_o_nine_tails <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_cat_o_nine_tails";
		this.m.Name = "Cat o nine tails";
		this.m.Description = "A short leather whip with multiple heads, used for punishment not fighting";
		this.m.IconLarge = "weapons/melee/legend_cat_o_nine_tails_01.png";
		this.m.Icon = "weapons/melee/legend_cat_o_nine_tails_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Whip;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_cat_o_nine_tails_01";
		this.m.RangeMin = 1;
		this.m.RangeMax = 1;
		this.m.RangeIdeal = 1;
		this.m.Value = 20;
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.m.StaminaModifier = -1;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 15;
		this.m.ArmorDamageMult = 0.15;
		this.m.DirectDamageMult = 0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendFlagellate);
		::Legends.Actives.grant(this, ::Legends.Active.LegendNinetailsDisarm);
		::Legends.Actives.grant(this, ::Legends.Active.LegendFlogging);
	}

});

