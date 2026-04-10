this.legend_named_goblin_axe_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_goblin_axe_2h";
		this.m.Name = "Manfeller";
		this.m.PrefixList = this.Const.Strings.GoblinWeaponPrefix;
		this.m.Description = "As some of the goblins grew to nearly human size, they took the time to recreate their greenskin cousin\'s huge axe, but with a well crafted slim edge. Suited for human hands, it can easily cut a man in two .";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5100;
		this.m.ShieldDamage = 36;
		this.m.Condition = 66.0;
		this.m.ConditionMax = 66.0;
		this.m.StaminaModifier = -20;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.4;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
		// this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/named_two_handed_goblin_axe_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/named_two_handed_goblin_axe_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_two_handed_goblin_axe_0" + this.m.Variant;
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

