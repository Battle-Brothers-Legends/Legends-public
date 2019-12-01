this.legend_ranged_wooden_flail <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_ranged_wooden_flail";
		this.m.Name = "Peasant Flail";
		this.m.Description = "A large stick attached with a short chain to a long pole, the Peasant Flail is an agricultural tool used to strike piles of grain to loosen the husks. As an improvised weapon it\'s rather unpredictable but useful to strike over or around shield cover.";
		this.m.Categories = "Flail, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_ranged_flail_01.png";
		this.m.Icon = "weapons/melee/legend_ranged_flail_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_ranged_flail_01";
		this.m.Value = 40;
		this.m.ShieldDamage = 0;
		this.m.Condition = 32.0;
		this.m.ConditionMax = 32.0;
		this.m.StaminaModifier = -8;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local flail = this.new("scripts/skills/actives/legend_ranged_flail_skill");
		this.addSkill(flail);
		local lash = this.new("scripts/skills/actives/legend_ranged_lash_skill");
		this.addSkill(lash);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

