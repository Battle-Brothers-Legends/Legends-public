this.legend_named_voulge <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.legend_named_voulge";
		this.m.NameList = this.Const.Strings.BillNames;
		this.m.Description = "A polearm with a large, sharpened metal blade designed to deal devastating blows.";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -14;
		this.m.Value = 3500;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_voulge_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_voulge_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_voulge_01_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_voulge_cleave_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_voulge_decapitate_skill"));
	}

});

