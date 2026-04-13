this.legend_named_ranged_flail <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		PossibleEffects = ["scripts/skills/effects/legend_named_flail_effect"],
		EffectBounds = [ [100, 100] ]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_flail";
		this.m.NameList = this.Const.Strings.TwoHandedFlailNames;
		this.m.Description = "A metal weight attached with a short chain to a long pole, the War Flail is a brutal weapon. Deadly enough to fell most men with a good hit to the head, and useful to strike over or around shield cover.";
		this.m.IconLarge = "weapons/melee/legend_flail_ranged_02_named_01.png";
		this.m.Icon = "weapons/melee/legend_flail_ranged_02_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_flail_ranged_02_named_01";
		this.m.Value = 3000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.0;
		this.m.ChanceToHitHead = 10;
		this.m.DirectDamageMult = 0.3;
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
				icon = "ui/icons/armor_head.png",
				text = "Applies [color=%positive%]Daze[/color] to Targets Hit"
			});
		}
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendRangedFlail);
		::Legends.Actives.grant(this, ::Legends.Active.LegendRangedLash);
//		::Legends.Actives.grant(this, ::Legends.Active.LegendRangedFlail, function (_skill) {
//			_skill.m.Icon = "skills/active_65.png";
//			_skill.m.IconDisabled = "skills/active_65_sw.png";
//			_skill.m.Overlay = "active_65";
//		}.bindenv(this));
//		::Legends.Actives.grant(this, ::Legends.Active.LegendRangedLash, function (_skill) {
//			_skill.m.Icon = "skills/active_92.png";
//			_skill.m.IconDisabled = "skills/active_92_sw.png";
//			_skill.m.Overlay = "active_92";
//		}.bindenv(this));
	}

});

