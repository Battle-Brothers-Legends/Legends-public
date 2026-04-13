this.legend_decorated_crypt_cleaver <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		Bravery = 10
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_decorated_crypt_cleaver";
		this.m.Name = "Decorated Crypt Cleaver";
		this.m.Description = "A light, ceremonial version of a two-handed cleaver with a curved end, adorned with gold inlay and odd motifs.";
		this.m.IconLarge = "weapons/melee/legend_decorated_crypt_cleaver_01.png";
		this.m.Icon = "weapons/melee/legend_decorated_crypt_cleaver_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_decorated_crypt_cleaver_01";
		this.m.Value = 2500;
		this.m.ShieldDamage = 12;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.StaminaModifier = -13;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.15;
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
		::Legends.Actives.grant(this, ::Legends.Active.Cleave, function (_skill) {
			_skill.m.FatigueCost = 15;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.m.FatigueCost = 5;
		}.bindenv(this));
	}
});
