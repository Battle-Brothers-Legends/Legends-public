this.legend_named_orc_axe_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_orc_axe_2h";
		this.m.Name = "Unhold Splitter";
		this.m.Description = "A huge and sturdy double headed battleaxe too heavy to be used effectively by the average human.";
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = ::Const.Items.WeaponType.Axe;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5000;
		this.m.ShieldDamage = 42;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -34;
		this.m.RegularDamage = 90;
		this.m.RegularDamageMax = 120;
		this.m.ArmorDamageMult = 1.6;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/named_two_handed_orc_axe_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/named_two_handed_orc_axe_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_two_handed_orc_axe_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.SplitMan);
		::Legends.Actives.grant(this, ::Legends.Active.RoundSwing);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}

});

