this.legend_meat_hacker <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_meat_hacker";
		this.m.Name = "Meat Hacker";
		this.m.Description = "A long shard of sharpened rock firmly wedged into a massive bone. Designed to be held by one much larger hand but not well suited for human hands. Cannot be double gripped.";
		this.m.IconLarge = "weapons/melee/legend_meat_hacker_01.png";
		this.m.Icon = "weapons/melee/legend_meat_hacker_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_meat_hacker_01";
		this.m.Value = 900;
		this.m.ShieldDamage = 14;
		this.m.Condition = 42.0;
		this.m.ConditionMax = 42.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.3;
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
		::Legends.Actives.grant(this, ::Legends.Active.SplitMan, function (_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult; //Sets Split Man's Direct Damage Mult to Meat Hacker's Direct Damage Mult
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
