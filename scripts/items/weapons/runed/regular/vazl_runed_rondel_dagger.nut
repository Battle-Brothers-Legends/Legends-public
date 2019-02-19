this.vazl_runed_rondel_dagger <- this.inherit("scripts/items/weapons/runed/vazl_runed_weapon", {
	m = {},
	function create()
	{
		this.vazl_runed_weapon.create();
		this.m.ID = "weapon.vazl_runed_rondel_dagger";
		this.m.Name = "Rondel Dagger";
		this.m.Description = "A long, quadrangular spike designed to pierce through weakpoints in armor.";
		this.m.Categories = "Dagger, One-Handed";
		this.m.IconLarge = "weapons/melee/runed_dagger_02.png";
		this.m.Icon = "weapons/melee/runed_dagger_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "runed_icon_dagger_02";
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.Value = 400;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.2;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/stab"));
		this.addSkill(this.new("scripts/skills/actives/puncture"));
	}

});
