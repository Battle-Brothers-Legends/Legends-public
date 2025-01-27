this.legend_skullsmasher <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_skullsmasher";
		this.m.Name = "Skull Smasher";
		this.m.Description = "A massive crude hammer with a head fashioned from a chunk of solid iron. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/legend_skullsmasher_01.png";
		this.m.Icon = "weapons/melee/legend_skullsmasher_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IsDoubleGrippable = true;
		this.m.ArmamentIcon = "icon_legend_skullsmasher_01";
		this.m.Value = 1200;
		this.m.ShieldDamage = 32;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -20;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 2.25;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
	}

	// function getTooltip()
	// {
	// 	local ret = this.weapon.getTooltip();
	// 	ret.push({
	// 		id = 18,
	// 		type = "text",
	// 		icon = "ui/icons/fatigue.png",
	// 		text = "Builds up additional [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] Fatigue with every skill use"
	// 	});
	// 	return ret;
	// }

	function onEquip()
	{
		this.weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/hammer");
		this.addSkill(skillToAdd);

		skillToAdd = this.new("scripts/skills/actives/crush_armor");
		this.addSkill(skillToAdd);

		// skillToAdd = this.new("scripts/skills/actives/legend_harvest_rock_skill");
		// skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		// this.addSkill(skillToAdd);

	}

});
