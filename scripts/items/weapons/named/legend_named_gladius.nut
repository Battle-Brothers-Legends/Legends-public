this.legend_named_gladius <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		PossibleEffects = ["scripts/skills/effects/legend_named_sword_riposte_effect"],
		EffectBounds = [ [8, 13] ]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_gladius";
		this.m.NameList = this.Const.Strings.SwordNames;
		this.m.Description = "A straight blade of ancient origin. The grip and pommel are ornate and most likely from a nobleman.";
		this.m.IconLarge = "weapons/melee/legend_gladius_named_01.png";
		this.m.Icon = "weapons/melee/legend_gladius_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_gladius_named_01";
		this.m.Value = 3200;
		this.m.Condition = 54.0;
		this.m.ConditionMax = 54.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 43;
		this.m.RegularDamageMax = 48;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.2;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Chance to Riposte on Turn Start"
			});
		}
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash);
		::Legends.Actives.grant(this, ::Legends.Active.Riposte);
	}

	function onUpdateProperties( _properties )
	{
		this.named_weapon.onUpdateProperties(_properties);
	}

});

