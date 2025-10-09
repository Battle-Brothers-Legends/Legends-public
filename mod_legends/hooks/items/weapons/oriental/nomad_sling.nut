::mods_hookExactClass("items/weapons/oriental/nomad_sling", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Categories = "Sling, Two-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.WeaponType = this.Const.Items.WeaponType.Sling | this.Const.Items.WeaponType.Staff;
		this.m.Value = 800;
		this.m.RangeMin = 2;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 1.5;
		this.m.StaminaModifier = -10;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/ranged/warriors_sling_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/warriors_sling_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_sling_02_" + this.m.Variant;
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
