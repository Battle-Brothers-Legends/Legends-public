this.legend_bough <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_bough";
		this.m.Name = "Bough";
		this.m.Description = "Almost a whole tree uprooted, haphazardly reinforced with protruding iron rivets. Too heavy to be used effectively by the average human.";
		this.m.Categories = "Mace, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_bough_01.png";
		this.m.Icon = "weapons/melee/legend_bough_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_bough_01";
		this.m.Value = 1600;
		this.m.ShieldDamage = 32;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -32;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.35;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 18,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Builds up additional [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] Fatigue with every skill use"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cudgel_skill");
		skill.setFatigueCost(this.Math.round(skill.getFatigueCostRaw() + 5));
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/strike_down_skill");
		skill.setFatigueCost(this.Math.round(skill.getFatigueCostRaw() + 5));
		this.addSkill(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
