this.legend_named_heavy_throwing_axe <- inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_heavy_throwing_axe";
		this.m.Variant = 1;
		this.m.Variants = [1];
		this.updateVariant();
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.SuffixList = this.Const.Strings.BarbarianPrefix;
		this.m.NameList = this.Const.Strings.ThrowingAxeNames;
		this.m.Description = "While you wouldn\'t use these for juggling, the craftsmanship is astounding for heavy barbarian axes. Difficult to throw and hit with, but deadly.";
		this.m.Categories = "Throwing Weapon/Axe, One-Handed";
		this.m.SlotType = Const.ItemSlot.Mainhand;
		this.m.WeaponType = this.Const.Items.WeaponType.Throwing | this.Const.Items.WeaponType.Axe;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.OneHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 1800;
		this.m.Ammo = 4;
		this.m.AmmoMax = 4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.4;
		this.m.DirectDamageMult = 0.3;
		this.m.ShieldDamage = 0;
		this.m.ChanceToHitHead = 5;
		this.m.IsDroppedAsLoot = true;
		this.m.AdditionalAccuracy = -5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		if (this.m.Ammo > 0) {
			this.m.IconLarge = "weapons/ranged/throwing_axes_heavy_01_named_0" + this.m.Variant + ".png";
			this.m.Icon = "weapons/ranged/throwing_axes_heavy_01_named_0" + this.m.Variant + "_70x70.png";
			this.m.ArmamentIcon = "icon_named_throwing_axes_heavy_0" + this.m.Variant;
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.IconLarge = "weapons/ranged/throwing_axes_01_bag.png";
			this.m.Icon = "weapons/ranged/throwing_axes_01_bag_70x70.png";
			this.m.ArmamentIcon = "icon_named_throwing_axes_heavy_0" + this.m.Variant;
			this.m.ShowArmamentIcon = false;
		}
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/throw_axe"));
	}

	function setAmmo(_a)
	{
		this.weapon.setAmmo(_a);
		this.updateVariant();
		this.updateAppearance();
	}

})
