this.legend_spatha <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_spatha";
		this.m.Name = "Ancient Royal Sword";
		this.m.Description = "A simple yet deadly straight sword held by Centurions for the purpose of cutting through several attackers in a single day. It\'s durability lies in the weight whilst lacking armour piercing advantages.";
		this.m.IconLarge = "weapons/melee/legend_spatha_01.png";
		this.m.Icon = "weapons/melee/legend_spatha_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_spatha_01";
		this.m.Value = 1550;
		this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.0;
		this.m.DirectDamageMult = 0.2;
		this.m.ShieldDamage = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash);
		::Legends.Actives.grant(this, ::Legends.Active.Riposte);
		::Legends.Actives.grant(this, ::Legends.Active.Puncture, function (_skill) {
			_skill.m.IsHalfsword = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Hammer, function (_skill) {
			_skill.m.IsMordhau = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

