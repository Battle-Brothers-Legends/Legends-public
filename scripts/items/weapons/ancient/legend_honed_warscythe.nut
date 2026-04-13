this.legend_honed_warscythe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_honed_warscythe";
		this.m.Name = "Ancient Honed Warscythe";
		this.m.Description = "A warscythe with a leaner, more curved blade that is ideal against single targets. What it lacks in stopping power it makes up for in weight and accuracy.";
		this.m.IconLarge = "weapons/melee/legend_honed_warscythe_01.png";
		this.m.Icon = "weapons/melee/legend_honed_warscythe_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_honed_warscythe_01";
		this.m.Value = 1800;
		this.m.ShieldDamage = 10;
		this.m.Condition = 45.0;
		this.m.ConditionMax = 45.0;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.05;
		this.m.ChanceToHitHead = 15;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Strike);
		::Legends.Actives.grant(this, ::Legends.Active.LegendScytheCleave);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield);
	}

});