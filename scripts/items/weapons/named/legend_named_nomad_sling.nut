this.legend_named_nomad_sling <- this.inherit("scripts/items/weapons/named/named_weapon", { // credit to Emo
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_nomad_sling";
		this.m.NameList = this.Const.Strings.SlingNames;
		this.m.Categories = "Sling/Staff, Two-Handed";
		this.m.Description = "A reinforced sling on a metal staff of the highest craftsmanship. It features a bigger pouch for heavier rocks, but trades off precision for damage and range. With rocks being everywhere it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/legend_named_slingstaff_02.png";
		this.m.Icon = "weapons/ranged/legend_named_slingstaff_02_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling | this.Const.Items.WeaponType.Staff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType =  this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_named_slingstaff_02";
		this.m.Value = 3700;
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
		this.randomizeValues();
	}

	function onEquip()
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

	function onUpdateProperties (_properties)
	{
		this.weapon.onUpdateProperties(_properties);
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag)) {
			item.onSlingUpdateProperties();
		}
	}

});

