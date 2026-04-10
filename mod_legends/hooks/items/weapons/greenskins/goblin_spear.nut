::mods_hookExactClass("items/weapons/greenskins/goblin_spear", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.Description = "A long shaft with a sharp metal blade at the top.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.setCategories("Sword/Polearm, Two-Handed");
		this.m.IsDoubleGrippable = false;
		this.m.IsAoE = true;
		this.m.Value = 700;
		this.m.StaminaModifier = -10;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.RangeMin = 1;
		this.m.RangeMax = 1;
		this.m.RangeIdeal = 1;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 60;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/goblin_spear_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/goblin_spear_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_goblin_spear_0" + this.m.Variant;
	}

	o.getAmmo <- function() {
		return this.m.Ammo;
	}

	o.getAmmoMax <- function() {
		return this.m.AmmoMax;
	}

	o.onEquip = function ()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsGreatBreachSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Rupture, function (_skill) {
			_skill.m.IsMeleeRupture = true;
		}.bindenv(this));
		::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendSkewer, function (_skill)
		{
			_skill.m.Icon = "skills/skewer_general.png";
			_skill.m.IconDisabled = "skills/skewer_general_bw.png";
			_skill.m.Overlay = "skewer_general";
		}.bindenv(this));
	}
});
