::mods_hookExactClass("items/weapons/oriental/nomad_sling", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "A leather sling on a metal-reinforced staff, used to hurl stones at the enemy. It features a bigger pouch for heavier rocks, but trades off precision for damage and range. With rocks abundant everywhere it will never run out of ammunition.";
		this.m.Categories = "Sling/Staff, Two-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.WeaponType = this.Const.Items.WeaponType.Sling | this.Const.Items.WeaponType.Staff;
		this.m.Value = 800;
		this.m.RangeMin = 2;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.7;
		this.m.StaminaModifier = -10;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/warriors_sling_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/warriors_sling_01" + v + ".png";
		this.m.ArmamentIcon = "icon_sling_02" + v;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendSlingHeavyStone);
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendSlingCenterMass);
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
