this.legend_reinforced_flail <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_reinforced_flail";
		this.m.Name = "Reinforced Wooden Flail";
		this.m.Description = "A heavy two-handed wooden flail bound with metal that can strike over or around shield cover.";
		this.m.Categories = "Flail, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_reinforced_flail_01.png";
		this.m.Icon = "weapons/melee/legend_reinforced_flail_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_reinforced_flail_01";
		this.m.Value = 850;
		this.m.ShieldDamage = 0;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.95;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		skill.m.Icon = "skills/active_129.png";
		skill.m.IconDisabled = "skills/active_129_sw.png";
		skill.m.Overlay = "active_129";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
		skill.m.Icon = "skills/active_130.png";
		skill.m.IconDisabled = "skills/active_130_sw.png";
		skill.m.Overlay = "active_130";
		this.addSkill(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

