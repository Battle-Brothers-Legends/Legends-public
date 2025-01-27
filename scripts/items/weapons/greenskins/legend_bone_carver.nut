this.legend_bone_carver <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_bone_carver";
		this.m.Name = "Bone Carver";
		this.m.Description = "A sharpened stone head secured to a large bone. Not well suited for human hands.";
		this.m.IconLarge = "weapons/melee/legend_bone_carver_01.png";
		this.m.Icon = "weapons/melee/legend_bone_carver_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_bone_carver_01";
		this.m.Value = 900;
		this.m.ShieldDamage = 0;
		this.m.Condition = 42.0;
		this.m.ConditionMax = 42.0;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueOnSkillUse = 5;
	}

	// function getTooltip() //Already pulls tooltip below from skill!
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
		::Legends.Actives.grant(this, ::Legends.Active.Cleave);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate);
	}

});
