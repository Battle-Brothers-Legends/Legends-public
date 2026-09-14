this.legend_reinforced_flail <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_reinforced_flail";
		this.m.Name = "Reinforced Improvised Warflail";
		this.m.Description = "A farmer\'s flail that has been bolstered with thicker sections of wood and bound with iron. Sharp spikes protrude from its frame, as if to mockingly imitate it\'s military counterpart.";
		this.m.IconLarge = "weapons/melee/legend_reinforced_flail_01.png";
		this.m.Icon = "weapons/melee/legend_reinforced_flail_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.IsAoE = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_reinforced_flail_01";
		this.m.Value = 1050;
		this.m.ShieldDamage = 0;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.95;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Pound, function (_skill) {
			_skill.m.Icon = "skills/active_129.png";
			_skill.m.IconDisabled = "skills/active_129_sw.png";
			_skill.m.Overlay = "active_129";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Thresh, function (_skill) {
			_skill.m.Icon = "skills/active_130.png";
			_skill.m.IconDisabled = "skills/active_130_sw.png";
			_skill.m.Overlay = "active_130";
		}.bindenv(this));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

