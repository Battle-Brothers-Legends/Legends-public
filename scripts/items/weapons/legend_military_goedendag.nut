this.legend_military_goedendag <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_military_goedendag";
		this.m.Name = "Military Goedendag";
		this.m.Description = "A military grade metal-reinforced club with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission.";
		this.m.Variants = [1,2];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2000;
		this.m.ShieldDamage = 32;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_military_goedendag_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_military_goedendag_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_military_goedendag_0" + this.m.Variant;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Thrust, function (_skill) {
			_skill.m.IsGoedendagThrust = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.StrikeDown, function (_skill) {
			_skill.m.Icon = "skills/active_132.png";
			_skill.m.IconDisabled = "skills/active_132_sw.png";
			_skill.m.Overlay = "active_132";
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}

});

