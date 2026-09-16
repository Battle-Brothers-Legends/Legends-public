this.legend_katar <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_katar";
		this.m.Name = "Katar";
		this.m.Description = "An H-shaped horizontal blade sitting above the knuckles. Has a thickened tip that is particularily effective at piercing armor but its construction prevents it from being gripped with two hands.";
		this.m.IconLarge = "weapons/melee/legend_katar_01.png";
		this.m.Icon = "weapons/melee/legend_katar_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Dagger;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_katar_01";
		this.m.Condition = 75.0;
		this.m.ConditionMax = 75.0;
		this.m.Value = 1250;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.3;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow, function (_skill) {
			_skill.m.DeathblowBonus = true;
			_skill.m.IsIgnoredAsAOO = false;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendGut);
	}

});

