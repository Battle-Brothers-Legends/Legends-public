this.legend_named_glaive <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_glaive";
		this.m.NameList = this.Const.Strings.BillNames;
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.Description = "A masterfully crafted glaive that feels surprisingly light, yet sturdy.";
		this.m.WeaponType = this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 6000;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.3;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_glaive_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_glaive_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_named_glaive_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Strike, function (_skill) {
			_skill.m.IsGlaiveStrike = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}
});

