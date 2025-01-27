this.legend_longsword <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_longsword";
		this.m.Name = "Longsword";
		this.m.Description = "A long two-handed blade that makes for a versatile weapon, this longsword is the smaller and lighter of it\'s town cousins but is much more versatile.";
		this.m.IconLarge = "weapons/melee/longsword_01.png";
		this.m.Icon = "weapons/melee/longsword_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_longsword_01";
		this.m.Value = 2000;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.isGreatSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.OverheadStrike);
		::Legends.Actives.grant(this, ::Legends.Active.Riposte);
	}
});

