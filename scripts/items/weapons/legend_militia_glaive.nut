this.legend_militia_glaive <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_militia_glaive";
		this.m.Name = "Militia Glaive";
		this.m.Description = "A simple glaive improvised from a scramasax.";
		this.m.IconLarge = "weapons/melee/legend_militia_glaive_01.png";
		this.m.Icon = "weapons/melee/legend_militia_glaive_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Defensive;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_militia_glaive_01";
		this.m.Value = 350;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/slash");
		skillToAdd.m.isGlaiveSlash = true;
		this.addSkill(skillToAdd);
		local spearwall = this.new("scripts/skills/actives/spearwall");
		spearwall.m.BaseAttackName = "Glaive Slash";
		this.addSkill(spearwall);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

