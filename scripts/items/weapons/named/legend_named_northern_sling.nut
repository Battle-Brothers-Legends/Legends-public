this.legend_named_northern_sling <- this.inherit("scripts/items/weapons/named/named_weapon", { // credit to Emo
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_northern_sling";
		this.m.NameList = ::Const.Strings.SlingNames;
		this.m.Categories = "Sling/Staff, Two-Handed";
		this.m.Description = "An exquisite slingstaff for true marksmen. It features a bigger pouch for heavier rocks, but trades off precision for damage and range. With rocks being everywhere it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/legend_named_slingstaff_01.png";
		this.m.Icon = "weapons/ranged/legend_named_slingstaff_01_70x70.png";
		this.m.WeaponType = ::Const.Items.WeaponType.Sling | ::Const.Items.WeaponType.Staff;
		this.m.SlotType = ::Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType =  ::Const.Items.ItemType.Named | ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.RangedWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.EquipSound = ::Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_named_slingstaff_01";
		this.m.Value = 4000;
		this.m.RangeMin = 2;
		this.m.RangeMax = 9;
		this.m.RangeIdeal = 9;
		this.m.StaminaModifier = -12;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.6;
		this.m.DirectDamageMult = 0.75;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendSlingHeavyStone);

		::Legends.Actives.grant(this, ::Legends.Active.Bash, function (_skill) {
			_skill.m.IsSlingBash = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchAcidFlask);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchDazeBomb);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchFireBomb);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchHolyWater);
		::Legends.Actives.grant(this, ::Legends.Active.LegendLaunchSmokeBomb);
	}

	function onUpdateProperties (_properties)
	{
		this.weapon.onUpdateProperties(_properties);
		foreach (item in this.getContainer().getActor().getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag)) {
			item.onSlingUpdateProperties();
		}
	}

});
