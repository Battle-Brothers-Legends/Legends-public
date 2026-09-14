this.legend_named_rusty_greatsword <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.legend_named_rusty_greatsword";
		this.m.NameList = this.Const.Strings.GreatswordNames;
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.SuffixList = this.Const.Strings.BarbarianSuffix;
		this.m.Description = "This massive and exceptionally well-crafted warblade is built like a cleaver, but has a surprisingly light blade that allows wielding it like a sword.";
		this.m.Categories = "Sword, Two-Handed";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4600;
		this.m.ShieldDamage = 32;
		this.m.Condition = 76.0;
		this.m.ConditionMax = 76.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.1;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_named_rusty_greatsword_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_named_rusty_greatsword_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_named_rusty_greatsword_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.OverheadStrike, function (_skill) {
			_skill.setStunChance(this.m.StunChance);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Split);
		::Legends.Actives.grant(this, ::Legends.Active.Swing);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}
});
