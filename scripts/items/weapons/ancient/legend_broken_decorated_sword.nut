this.legend_broken_decorated_sword <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		Bravery = 5
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_broken_decorated_sword";
		this.m.Name = "Broken Ancient Decorated Sword";
		this.m.Description = "A broken ceremonial sword with few sharp edges outside of the breakpoint. It is, however, still more than a lethal weapon in the hands of a cunning fighter.";
		this.m.IconLarge = "weapons/melee/legend_broken_decorated_sword_01.png";
		this.m.Icon = "weapons/melee/legend_broken_decorated_sword_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Dagger;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_broken_decorated_sword_01";
		this.m.Value = 400;
		this.m.Condition = 32.0;
		this.m.ConditionMax = 32.0;
		this.m.StaminaModifier = -2;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.4;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.1;
	}

	function onUpdateProperties ( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		if (::World.Assets.getOrigin() != null && ::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			_properties.Bravery += this.m.Bravery;
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
});

