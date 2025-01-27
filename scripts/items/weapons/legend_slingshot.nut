this.legend_slingshot <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_slingshot";
		this.m.Name = "Slingshot";
		this.m.Description = "A primitive yet effective weapon for troublesome children and grown killers alike. With stones abundant everywhere, it will never run out of ammunition. Can target the head to daze enemies.";
		this.m.IconLarge = "weapons/ranged/legend_sling_01.png";
		this.m.Icon = "weapons/ranged/legend_sling_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_sling_01";
		this.m.Value = 100;
		this.m.StaminaModifier = -2;
		this.m.RangeMin = 2;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.1;
		this.m.DirectDamageMult = 0.4;
	//	this.m.IsDroppedAsLoot = true;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendShootStone);
		::Legends.Actives.grant(this, ::Legends.Active.LegendShootPreciseStone);
	}

});

