this.legend_swordstaff <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_swordstaff";
		this.m.Name = "Swordstaff";
		this.m.Description = "A cross between a spear and a sword, making for a good dueling weapon. Used for attacking at range and closing the gap.";
		this.m.IconLarge = "weapons/melee/legend_swordstaff_01.png";
		this.m.Icon = "weapons/melee/legend_swordstaff_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_swordstaff_01";
		this.m.Value = 2750;
		this.m.ShieldDamage = 0;
		this.m.Condition = 65.0;
		this.m.ConditionMax = 65.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsStaffSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}

});

