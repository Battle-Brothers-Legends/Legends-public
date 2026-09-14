this.legend_skin_flayer <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_skin_flayer";
		this.m.Name = "Skin Flayer";
		this.m.Description = "A razor sharp length of crude metal with a wrapped grip. Not well suited for human hands.";
		this.m.IconLarge = "weapons/melee/legend_skin_flayer_01.png";
		this.m.Icon = "weapons/melee/legend_skin_flayer_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_skin_flayer_01";
		this.m.Value = 1100;
		this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.2;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.Icon = "skills/active_78.png";
			_skill.m.IconDisabled = "skills/active_78_sw.png";
			_skill.m.Overlay = "active_78";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.setApplySwordMastery(true);
		}.bindenv(this));
	}

});
