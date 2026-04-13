this.legend_sturdy_sling <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_sturdy_sling";
		this.m.Name = "Sturdy Sling";
		this.m.Description = "Well crafted and reinforced sling, for hurling rocks at your rivals. With stones abundant everywhere, it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/1h_sling_01.png";
		this.m.Icon = "weapons/ranged/1h_sling_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_1h_sling_01";
		this.m.Value = 200;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 45.0;
		this.m.ConditionMax = 45.0;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.4;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 40;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.SlingStone);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendWindUp);
	}

});
