this.legend_limb_lopper <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_limb_lopper";
		this.m.Name = "Limb Lopper";
		this.m.Description = "A colossal cleaving weapon made of several overlapping crude blades wedged into a tree limb. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/legend_limb_lopper_01.png";
		this.m.Icon = "weapons/melee/legend_limb_lopper_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_limb_lopper_01";
		this.m.Value = 1600;
		this.m.ShieldDamage = 32;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -26;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cleave);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.setFatigueCost(::Math.round(_skill.getFatigueCostRaw() + 10)); // 10 because 2h weapons should get +5 on split shield (see 2h mace), and then +5 because of being orc weapon.
		}.bindenv(this));
	}

});
