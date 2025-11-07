this.legend_named_lute <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.legend_named_lute";
		this.m.NameList = this.Const.Strings.LuteNames;
		this.m.Description = "A beautiful lute with a ornate body and strong neck. The artisan who made this instrument certainly knew what they were doing.";
		this.m.WeaponType = this.Const.Items.WeaponType.Musical | this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 1000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.4;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/lute_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/lute_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_lute_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.IsLuteBash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsFromLute = true;
			_skill.m.Icon = "skills/active_88.png";
			_skill.m.IconDisabled = "skills/active_88_sw.png";
			_skill.m.Overlay = "active_88";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrumsOfWar);
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrumsOfLife);
		::Legends.Actives.grant(this, ::Legends.Active.LegendMartialMarch);
	}

});

