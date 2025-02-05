this.legend_military_goedendag <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_military_goedendag";
		this.m.Name = "Military Goedendag";
		this.m.Description = "A military grade metal-reinforced club with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission.";
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_military_goedendag_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_military_goedendag_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_military_goedendag_0" + this.m.Variant;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/active_128.png";
		thrust.m.IconDisabled = "skills/active_128_sw.png";
		thrust.m.Overlay = "active_128";
		thrust.setFatigueCost(15);
		thrust.m.ActionPointCost = 6;
		this.addSkill(thrust);
		local skill;
		skill = this.new("scripts/skills/actives/cudgel_skill");
		skill.m.Icon = "skills/active_131.png";
		skill.m.IconDisabled = "skills/active_131_sw.png";
		skill.m.Overlay = "active_131";
		this.addSkill(skill);
		local skill;
		skill = this.new("scripts/skills/actives/strike_down_skill");
		skill.m.Icon = "skills/active_132.png";
		skill.m.IconDisabled = "skills/active_132_sw.png";
		skill.m.Overlay = "active_132";
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

});

