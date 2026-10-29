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
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_limb_lopper_01";
		this.m.Value = 1900;
		this.m.ShieldDamage = 32;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -32;
		this.m.RegularDamage = 100;
		this.m.RegularDamageMax = 115;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.35;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew);
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.setFatigueCost(::Math.round(_skill.getFatigueCostRaw() + 5));
		}.bindenv(this));
	}

});
