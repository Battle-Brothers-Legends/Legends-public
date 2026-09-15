this.legend_chain <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_chain";
		this.m.Name = "Chain";
		this.m.Description = "A length of intertwined metal links. As a weapon it's ungainly and rather unpredictable but useful to spin, strike around shield cover and pull in enemies.";
		this.m.IconLarge = "weapons/melee/legend_chain_01.png";
		this.m.Icon = "weapons/melee/legend_chain_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Flail;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded | ::Const.Items.ItemType.Cultist;
		this.m.ItemProperty = ::Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_chain_01";
		this.m.Value = 400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.StaminaModifier = -12;
		this.m.RangeMin = 1;
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 1;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.2;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Flail, function (_skill) {
			_skill.m.IsChain = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Thresh, function (_skill) {
			_skill.m.IsChain = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hook, function (_skill) {
			_skill.m.IsChain = true;
		}.bindenv(this));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
