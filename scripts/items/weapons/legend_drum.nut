this.legend_drum <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_drum";
		this.m.Name = "Drum";
		this.m.Description = "A musical instrument, can produce inspiring rythms, if you have the skill. The drum sticks make weak maces in a pinch.";
		this.m.IconLarge = "weapons/melee/drum_01.png";
		this.m.Icon = "weapons/melee/drum_01_70x70.png";
		this.m.BreakingSound = "sounds/combat/bash_hit_03.wav";
		this.m.WeaponType = this.Const.Items.WeaponType.Musical | this.Const.Items.WeaponType.Staff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_drum";
		this.m.Value = 100;
		this.m.Condition = 20.0;
		this.m.ConditionMax = 20.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 5;
		this.m.RegularDamageMax = 10;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = -0.2;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.IsDrumBash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut);
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrumsOfWar);
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrumsOfLife);
		::Legends.Actives.grant(this, ::Legends.Active.LegendMartialMarch);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
