this.legend_named_swordstaff <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_swordstaff";
		this.m.NameList = this.Const.Strings.SpetumNames;
		this.m.Description = "This Swordstaff is especially well-crafted, and its blade would be worthy of even a noble";
		this.m.IconLarge = "weapons/melee/legend_swordstaff_01_named_01.png";
		this.m.Icon = "weapons/melee/legend_swordstaff_01_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_named_swordstaff_01";
		this.m.Value = 4800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 65.0;
		this.m.ConditionMax = 65.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsStaffSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}
});

