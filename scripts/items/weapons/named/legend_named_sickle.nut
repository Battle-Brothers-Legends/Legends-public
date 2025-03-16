this.legend_named_sickle <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_sickle";
		this.m.Name = "Sickle";
		this.m.NameList = this.Const.Strings.SwordNames;
		this.m.Description = "A ritualisticly engraved tool usually for gathering plants, made of the highest quality druidic metals";
		this.m.IconLarge = "weapons/melee/legend_sickle_02.png";
		this.m.Icon = "weapons/melee/legend_sickle_02_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_sickle_02";
		this.m.Value = 4500;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.2;
		this.m.ChanceToHitHead = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash);
		::Legends.Actives.grant(this, ::Legends.Active.Gash);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestBush);
	}


});

