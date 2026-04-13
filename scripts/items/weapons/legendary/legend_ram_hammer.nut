this.legend_ram_hammer <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_ram_hammer"; //unique to risen legion origin
		this.m.Name = "The Ram\'s Head"; //
		this.m.Description = "A massive ancient hammer with two ram heads making up both faces of the weapon. It is deceptively heavy and somehow increases in weight between each swing.";
		this.m.IconLarge = "weapons/melee/named_hammer_04.png";
		this.m.Icon = "weapons/melee/named_hammer_04_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_named_hammer_04";
		this.m.Value = 4700;
		this.m.ShieldDamage = 50;
		this.m.Condition = 78.0;
		this.m.ConditionMax = 78.0;
		this.m.StaminaModifier = -30;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 2.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Smite);
		::Legends.Actives.grant(this, ::Legends.Active.Shatter);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.m.IsHammer = true;
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5); // 10 because 2h weapons should get +5 on split shield (see 2h mace), and then +5 because of being orc weapon.
		}.bindenv(this));
		::Legends.Effects.get(_target, ::Legends.Effect.LegendRamHammer); //grants special effect
	}

});