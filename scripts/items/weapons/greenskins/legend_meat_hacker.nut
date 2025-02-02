this.legend_meat_hacker <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_meat_hacker";
		this.m.Name = "Meat Hacker";
		this.m.Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands. ";
		this.m.IconLarge = "weapons/melee/legend_meat_hacker_01.png";
		this.m.Icon = "weapons/melee/legend_meat_hacker_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_meat_hacker_01";
		this.m.Value = 1500;
		this.m.ShieldDamage = 32;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can use [color=" + ::Const.UI.Color.Active + "]Split Man[/color] when [color=" + ::Const.UI.Color.Status + "]Double Gripped[/color] and [color=" + ::Const.UI.Color.Active + "]Chop[/color] if not"
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/split_man");
		skill.setApplyOrcWeapon(true);
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/chop");
		skill.setApplyOrcWeapon(true);
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		skill.setApplyOrcWeapon(true);
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
