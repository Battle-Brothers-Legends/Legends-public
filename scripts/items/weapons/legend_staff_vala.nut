this.legend_staff_vala <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_staff_vala";
		this.m.Name = "Vala Staff";
		this.m.Description = "A beautiful staff with the distinctive twisted design of a vala.";
		this.m.Categories = "Staff, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_staff_05.png";
		this.m.Icon = "weapons/melee/legend_staff_05_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_staff_05";
		this.m.Value = 1000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.4;
//		this.m.IsChangeableInBattle = false;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_staff_bash"));
		this.addSkill(this.new("scripts/skills/actives/legend_staff_knock_out"));
	}
});
