this.legend_blowgun <- this.inherit("scripts/items/weapons/weapon", {
	m = {},

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_blowgun";
		this.m.Name = "Blowgun";
		this.m.Description = "A hollowed out reed used to shoot (toxic) darts. ";
		this.m.IconLarge = "weapons/ranged/blowgun_01.png";
		this.m.Icon = "weapons/ranged/blowgun_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Crossbow;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_blowgun_01";
		this.m.Value = 30;
		this.m.RangeMin = 1;
		this.m.RangeMax = 5;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.Condition = 20.0;
		this.m.ConditionMax = 20.0;
		this.m.RegularDamage = 5;
		this.m.RegularDamageMax = 15;
		this.m.ArmorDamageMult = 0.2;
		this.m.DirectDamageMult = 0.1;
	}

	function getAmmoID()
	{
		return "ammo.legend_darts";
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();

		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendShootDart);

	}

	function onCombatFinished()
	{
		this.weapon.onCombatFinished();
	}

});

