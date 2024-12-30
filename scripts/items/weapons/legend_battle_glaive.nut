this.legend_battle_glaive <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_battle_glaive";
		this.m.Name = "Battle Glaive";
		this.m.Description = "A long and sturdy glaive built for heavy combat.";
		this.m.IconLarge = "weapons/melee/legend_battle_glaive_01.png";
		this.m.Icon = "weapons/melee/legend_battle_glaive_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Spear;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Defensive;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_battle_glaive_01";
		this.m.Value = 3200;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.0;
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

