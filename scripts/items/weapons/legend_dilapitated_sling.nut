this.legend_dilapitated_sling <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_dilapitated_sling";
		this.m.Name = "Dilapitated Sling";
		this.m.Description = "A very simple sling, for hurling rocks at your rivals. Time and use have taken it\'s toll on this item and you\'re surprised it doesn\'t fall apart. With stones abundant everywhere, it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/legend_sling_02.png";
		this.m.Icon = "weapons/ranged/legend_sling_02_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_sling_02";
		this.m.Value = 50;
		this.m.StaminaModifier = -3;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 20.0;
		this.m.ConditionMax = 20.0;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.4;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 30;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.SlingStone);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendWindUp);
	}

});
