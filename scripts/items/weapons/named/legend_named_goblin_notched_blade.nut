this.legend_named_goblin_notched_blade <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_goblin_notched_blade";
		this.m.NameList = this.Const.Strings.DaggerNames;
		this.m.PrefixList = this.Const.Strings.GoblinWeaponPrefix;
		this.m.Description = "The goblins crafted this curved sax into a wavy pattern, making the blade particularly good for slitting throats and puncturing weak spots.";
		this.m.Categories = "Sword/Dagger, One-Handed";
		this.m.IconLarge = "weapons/melee/named_goblin_notched_blade_01.png";
		this.m.Icon = "weapons/melee/named_goblin_notched_blade_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_named_goblin_notched_blade_01";
		this.m.Value = 1900;
		this.m.Condition = 44.0;
		this.m.ConditionMax = 44.0;
		this.m.StaminaModifier = -1;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.2;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill)
		{
			_skill.m.Icon = "skills/active_77.png";
			_skill.m.IconDisabled = "skills/active_77_sw.png";
			_skill.m.Overlay = "active_77";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Puncture);
	}
});

