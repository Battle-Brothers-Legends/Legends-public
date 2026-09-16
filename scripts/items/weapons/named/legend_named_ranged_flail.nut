this.legend_named_ranged_flail <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		PossibleEffects = ["scripts/skills/effects/legend_named_flail_effect"],
		EffectBounds = [ [100, 100] ]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_flail";
		this.m.NameList = ::Const.Strings.TwoHandedFlailNames;
		this.m.Description = "A metal weight attached with a short chain to a long pole, the War Flail is a brutal weapon. Deadly enough to fell most men with a good hit to the head, and useful to strike over or around shield cover.";
		this.m.IconLarge = "weapons/melee/legend_flail_ranged_02_named_01.png";
		this.m.Icon = "weapons/melee/legend_flail_ranged_02_named_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Flail | ::Const.Items.WeaponType.Polearm;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Cultist;
		this.m.ItemProperty = ::Const.Items.Property.IgnoresShieldwall;
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
		::Legends.Actives.grant(this, ::Legends.Active.Flail, function (_skill) {
			_skill.m.IsRanged = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Lash, function (_skill) {
			_skill.m.IsRanged = true;
		}.bindenv(this));
	}

});

