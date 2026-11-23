this.legend_staff_gnarled <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_staff_gnarled";
		this.m.Name = "Gnarled Staff";
		this.m.Description = "A twisted staff made from withered roots";
		this.m.IconLarge = "weapons/melee/legend_staff_04.png";
		this.m.Icon = "weapons/melee/legend_staff_04_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Polearm | this.Const.Items.WeaponType.Staff | this.Const.Items.WeaponType.MagicStaff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_staff_04";
		this.m.Value = 5000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = -0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.Icon = "skills/staff_bash_gnarled.png";
			_skill.m.IconDisabled = "skills/staff_bash_gnarled_bw.png";
			_skill.m.IsStaffBash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.Icon = "skills/staff_knock_out_gnarled.png";
			_skill.m.IconDisabled = "skills/staff_knock_out_gnarled_bw.png";
			_skill.m.IsStaffKnockOut = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHex);
		::Legends.Actives.grant(this, ::Legends.Active.LegendStaffRiposte);
	}

});

