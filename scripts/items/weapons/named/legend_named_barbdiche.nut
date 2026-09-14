this.legend_named_barbdiche <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.ID = "weapon.legend_named_barbdiche";
		this.m.NameList = this.Const.Strings.AxeNames;
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.SuffixList = this.Const.Strings.BarbarianSuffix;
		this.m.Description = "This ornamented battleaxe betrays a certain care for the weapon that is uncharacteristic to the northern tribes.";
		this.m.Categories = "Axe, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5200;
		this.m.ShieldDamage = 36;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -21;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 95;
		this.m.ArmorDamageMult = 1.4;
		this.m.DirectDamageMult = 0.4;
		this.m.DirectDamageAdd = 0.1;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/named_barbdiche_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/named_barbdiche_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_barbdiche_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitMan);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitAxe);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}

});

