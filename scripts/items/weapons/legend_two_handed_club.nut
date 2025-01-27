this.legend_two_handed_club <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_two_handed_club";
		this.m.Name = "Two-Handed Club";
		this.m.Description = "A massive wooden club with a spiked head. Receiving a blow from this weapon will leave anyone dazed and gasping for air.";
		this.m.IconLarge = "weapons/melee/legend_two_handed_club_01.png";
		this.m.Icon = "weapons/melee/legend_two_handed_club_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_two_handed_club_01";
		this.m.Value = 400;
		this.m.ShieldDamage = 20;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.5;
		this.m.DirectDamageAdd = -0.05;
		this.m.ChanceToHitHead = 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cudgel, function (_skill) {
			_skill.m.Icon = "skills/active_131.png";
			_skill.m.IconDisabled = "skills/active_131_sw.png";
			_skill.m.Overlay = "active_131";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.StrikeDown, function (_skill) {
			_skill.m.Icon = "skills/active_132.png";
			_skill.m.IconDisabled = "skills/active_132_sw.png";
			_skill.m.Overlay = "active_132";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}

});

