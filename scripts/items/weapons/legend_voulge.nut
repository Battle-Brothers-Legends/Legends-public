this.legend_voulge <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_voulge";
		this.m.Name = "Voulge";
		this.m.Description = "A polearm with a heavy knife blade, reminiscent of a butcher\'s cleaver on a stick.";
		this.m.Variant = 1
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2500;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_voulge_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_voulge_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_voulge_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendVoulgeCleave);
		::Legends.Actives.grant(this, ::Legends.Active.LegendVoulgeDecapitate);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

