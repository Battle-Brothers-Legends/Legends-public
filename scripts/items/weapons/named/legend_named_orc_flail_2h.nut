this.legend_named_orc_flail_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_orc_flail_2h";
		this.m.Name = "Brutal Chain";
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.Description = "A massive iron chain with a heavy piece at the end. Too heavy to be used effectively by the average human.";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2100;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -30;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/named_two_handed_orc_flail_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/named_two_handed_orc_flail_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_two_handed_orc_flail_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Pound);
		::Legends.Actives.grant(this, ::Legends.Active.Thresh);
	}
});

