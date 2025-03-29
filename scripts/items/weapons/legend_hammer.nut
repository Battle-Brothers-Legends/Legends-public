this.legend_hammer <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_hammer";
		this.m.Name = "Blacksmith\'s hammer";
		this.m.Description = "A simple hammer, now everything looks like a nail";
		this.m.IconLarge = "weapons/melee/legend_hammer_01.png";
		this.m.Icon = "weapons/melee/legend_hammer_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_hammer_01";
		this.m.Value = 50;
		this.m.Condition = 44.0;
		this.m.ConditionMax = 44.0;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.5;
		this.m.DirectDamageAdd = -0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Hammer);
		::Legends.Actives.grant(this, ::Legends.Active.CrushArmor);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestRock);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
