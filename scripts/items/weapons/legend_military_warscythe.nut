this.legend_military_warscythe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_military_warscythe";
		this.m.Name = "Warscythe";
		this.m.Description = "A sharp curved blade attached to a long pole, used to deliver deep sweeping strikes over some distance. Mass produced for militias and noble armies, the sturdy design still betrays its farming origin.";
		this.m.Categories = "Cleaver/Polearm, Two-Handed";
		this.m.Variant = this.Math.rand(2, 3);
		this.updateVariant();
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 1350;
		this.m.ShieldDamage = 0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.RegularDamage = 65;
		this.m.RegularDamageMax = 85;
		this.m.ArmorDamageMult = 1.05;
		this.m.DirectDamageMult = 0.3;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/warscythe_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/warscythe_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_warscythe_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendScytheCleave);
		::Legends.Actives.grant(this, ::Legends.Active.Reap);
	}

});

