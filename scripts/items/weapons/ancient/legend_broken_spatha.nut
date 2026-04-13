this.legend_broken_spatha <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_broken_spatha";
		this.m.Name = "Broken Ancient Royal Sword";
		this.m.Description = "A broken and heavy sword that has snapped despite it\'s durability. The damage of this blade has only converted it into a killing tool of a different form.";
		this.m.IconLarge = "weapons/melee/legend_broken_spatha_01.png";
		this.m.Icon = "weapons/melee/legend_broken_spatha_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_broken_spatha";
		this.m.Value = 800;
		this.m.Condition = 42.0;
		this.m.ConditionMax = 42.0;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.2;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Stab, function (_skill) {
			_skill.m.Icon = "skills/active_198.png";
			_skill.m.IconDisabled = "skills/active_198_sw.png";
			_skill.m.Overlay = "active_198";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow, function (_skill) {
			_skill.m.DeathblowBonus = true;
		}.bindenv(this));
	}


	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

