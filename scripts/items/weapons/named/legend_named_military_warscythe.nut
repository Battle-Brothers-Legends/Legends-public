this.legend_named_military_warscythe <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		PossibleEffects = ["scripts/skills/effects/legend_named_cleaver_effect"],
		EffectBounds = [ [10, 20] ]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_military_warscythe";
		this.m.NameList = this.Const.Strings.WarscytheNames;
		this.m.Description = "A heavy cleaver blade on top of a long shaft, used to deliver deep sweeping strikes over some distance. It might be confused for a simple and crude from weapon a layman, but the artisan who crafted this knew how to balance it perfectly.";
		this.m.Variant = this.Math.rand(4, 5);
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4800;
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
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/warscythe_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/warscythe_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_warscythe_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendScytheCleave);
		::Legends.Actives.grant(this, ::Legends.Active.Reap);
	}

});

