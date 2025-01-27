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
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
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
		local s = this.new("scripts/skills/actives/stab");
		s.m.Icon = "skills/active_198.png";
		s.m.IconDisabled = "skills/active_198_sw.png";
		s.m.Overlay = "active_198";
		this.addSkill(s);
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow);
	}

});

