this.legend_staff_gnarled <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_staff_gnarled";
		this.m.Name = "Gnarled Staff";
		this.m.Description = "A twisted staff made from withered roots";
		this.m.Categories = "Staff, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_staff_04.png";
		this.m.Icon = "weapons/melee/legend_staff_04_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.MagicStaff;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_staff_04";
		this.m.Value = 5000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.3;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.weapon.onEquip();
		local s = this.new("scripts/skills/actives/legend_staff_bash");
		s.m.Icon = "skills/staff_bash_gnarled.png";
		s.m.IconDisabled = "skills/staff_bash_gnarled_bw.png";
		this.addSkill(s);

		local t = this.new("scripts/skills/actives/legend_staff_knock_out");
		t.m.Icon = "skills/staff_knock_out_gnarled.png";
		t.m.IconDisabled = "skills/staff_knock_out_gnarled_bw.png";
		this.addSkill(t);

		this.addSkill(this.new("scripts/skills/actives/legend_hex_skill"));
	}

});
