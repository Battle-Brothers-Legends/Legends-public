::mods_hookExactClass("items/weapons/named/named_goblin_spear", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A masterfully crafted goblin glaive. Accurate, fast and deadly in the hands of any skilled fighter.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.setCategories("Sword/Polearm, Two-Handed");
		this.m.IsAoE = true;
		this.m.Value = 3000;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
	}

	o.randomizeValues <- function ()
	{
		this.m.StaminaModifier = -10;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 65;

		named_weapon.randomizeValues();
	}

	o.onEquip = function ()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsStaffSlash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendSkewer);
	}

});
