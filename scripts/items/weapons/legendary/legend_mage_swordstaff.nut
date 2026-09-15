this.legend_mage_swordstaff <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_mage_swordstaff";
		this.m.Name = "Bladed Magestaff";
		this.m.Description = "While its origins remain shrouded in mystery, this unique swordstaff is permeated with magic. The blade hums as it slices through flesh and armor alike.";
		this.m.IconLarge = "weapons/melee/legend_swordstaff_01_legendary_01.png";
		this.m.Icon = "weapons/melee/legend_swordstaff_01_legendary_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Sword | ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.MagicStaff;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Legendary;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_swordstaff_legendary_01";
		this.m.Value = 20000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 1;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.3;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsGreatSlash = true;
			_skill.m.IsStaffSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Swing, function (_skill) {
			_skill.m.IsStaffSwing = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendRunThrough);
		::Legends.Actives.grant(this, ::Legends.Active.Lunge, function (_skill) {
			_skill.m.IsGreatLunge = true;
			_skill.m.IsStaffLunge = true;
		}.bindenv(this));
	}

});

