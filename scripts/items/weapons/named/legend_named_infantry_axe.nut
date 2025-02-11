this.legend_named_infantry_axe <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_infantry_axe";
		this.m.NameList = this.Const.Strings.LongaxeNames;
		this.m.Description = "A long, exceptionally well crafted two-handed axe used by footmen in the noble wars";
		this.m.Variants = [2,3,4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4600;
		this.m.ShieldDamage = 24;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.35;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_footman_axe_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_footman_axe_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_footman_axe_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Chop, function (_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult; //Sets Chop's Direct Damage Mult to Infantry Axes's Direct Damage Mult
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitMan, function (_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult; //Sets Split Man's Direct Damage Mult to Infantry Axes's Direct Damage Mult
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.m.ActionPointCost = 4;
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}
});
