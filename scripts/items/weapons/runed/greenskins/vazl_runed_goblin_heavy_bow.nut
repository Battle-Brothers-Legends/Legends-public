this.vazl_runed_goblin_heavy_bow <- this.inherit("scripts/items/weapons/runed/vazl_runed_weapon", {
	m = {},
	function create()
	{
		this.vazl_runed_weapon.create();
		this.m.ID = "weapon.vazl_runed_goblin_heavy_bow";
		this.m.Name = "Reinforced Boondock Bow";
		this.m.Description = "A light, yet powerful bow made from various woods.";
		this.m.Categories = "Bow, Two-Handed";
		this.m.IconLarge = "weapons/ranged/bow_goblin_02.png";
		this.m.Icon = "weapons/ranged/bow_goblin_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_goblin_bow_02";
		this.m.Value = 500;
		this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.35;
	}

	function getAmmoID()
	{
		return "ammo.arrows";
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/quick_shot"));
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}

});
