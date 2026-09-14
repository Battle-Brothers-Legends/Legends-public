this.legend_barbarian_sling <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_barbarian_sling";
		this.m.Name = "Wild Sling";
		this.m.Description = "A crude and heavy sling, for hurling rocks at your rivals. With stones abundant everywhere, it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/1h_sling_02.png";
		this.m.Icon = "weapons/ranged/1h_sling_02_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_1h_sling_02";
		this.m.Value = 250;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.35;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.SlingStone);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendWindUp);
	}

});
