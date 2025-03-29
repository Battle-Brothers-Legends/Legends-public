this.legend_named_heavy_southern_mace <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.legend_named_heavy_southern_mace";
		this.m.NameList = this.Const.Strings.MaceNames;
		this.m.Description = "A heavy winged mace from the south. The smith who forged this weapon certainly knew what he was doing.";
		this.m.WeaponType = this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.4;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/heavy_southern_mace_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/heavy_southern_mace_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_heavy_southern_mace_01_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Bash);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut);
	}

});

