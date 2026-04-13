::mods_hookExactClass("items/weapons/staff_sling", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A simple leather sling on a staff, used to hurl stones at the enemy. It features a bigger pouch for heavier rocks, but trades off precision for damage and range. With rocks being everywhere it will never run out of ammunition.";
		this.m.Categories = "Sling/Staff, Two-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.WeaponType = this.Const.Items.WeaponType.Sling | this.Const.Items.WeaponType.Staff;
		this.m.StaminaModifier = -8;
		this.m.RangeMin = 2;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
		this.m.Condition = 65.0;
		this.m.ConditionMax = 65.0;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.4;
		this.m.DirectDamageMult = 0.65;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendSlingHeavyStone);
		::Legends.Actives.grant(this, ::Legends.Active.LegendSlingstaffBash);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchAcidFlask);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchDazeBomb);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchFireBomb);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchHolyWater);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchSmokeBomb);
	}

	o.onUpdateProperties <- function (_properties)
	{
		this.weapon.onUpdateProperties(_properties);
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag)) {
			item.onSlingUpdateProperties();
		}
	}
});
