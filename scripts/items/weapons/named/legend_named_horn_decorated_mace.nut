this.legend_named_horn_decorated_mace <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_horn_decorated_mace";
		this.m.NameList = this.Const.Strings.MaceNames;
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.SuffixList = this.Const.Strings.BarbarianSuffix;
		this.m.Description = "A huge club decorated with skulls and horns, woven in patterns that betray strange meaning. For the average mercenary you just need to know that a blow will leave a person reeling and struggling for breath.";
		this.m.Categories = "Mace, Two-Handed";
		this.m.IconLarge = "weapons/melee/horn_decorated_mace_01.png";
		this.m.Icon = "weapons/melee/horn_decorated_mace_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_named_horn_decorated_mace_01";
		this.m.Value = 4400;
		this.m.ShieldDamage = 26;
		this.m.Condition = 126.0;
		this.m.ConditionMax = 126.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.2;
		this.m.DirectDamageMult = 0.5;
		this.m.DirectDamageAdd = 0.05;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Cudgel, function (_skill) {
			_skill.m.Icon = "skills/active_178.png";
			_skill.m.IconDisabled = "skills/active_178_sw.png";
			_skill.m.Overlay = "active_178";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.StrikeDown, function (_skill) {
			_skill.m.Icon = "skills/active_179.png";
			_skill.m.IconDisabled = "skills/active_179_sw.png";
			_skill.m.Overlay = "active_179";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}
});
