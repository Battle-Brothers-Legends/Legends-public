this.legend_hoe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_hoe";
		this.m.Name = "Hoe";
		this.m.Description = "An agricultural tool with a thin, flat blade attached to a long handle used to till soil and harvest root crops. The blade has been sharpened as to fashion it into a crude and oddly shaped chopping weapon.";
		this.m.IconLarge = "weapons/melee/legend_hoe_01.png";
		this.m.Icon = "weapons/melee/legend_hoe_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Pitchfork;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_hoe_01";
		this.m.Value = 55;
		this.m.ShieldDamage = 20;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = -0.05;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Chop);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
		}.bindenv(this));
	}

});

