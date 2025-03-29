this.legend_named_military_goedendag <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		PossibleEffects = ["scripts/skills/effects/legend_named_mace_stagger_effect"],
		EffectBounds = [ [15, 25] ]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_military_goedendag";
		this.m.NameList = this.Const.Strings.MaceNames;
		this.m.Description = "An ornate military grade metal-reinforced club with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission.";
		this.m.Variant = 1;
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 90.0;
		this.m.ConditionMax = 90.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.PossibleEffectIdx == 0)
		{
			result.push({
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.EffectChanceOrBonus + "%[/color] Stagger Chance"
			});
		}
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_military_goedendag_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_military_goedendag_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_military_goedendag_named_0" + this.m.Variant;
	}


	function onEquip()
	{
		this.named_weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Thrust, function (_skill) {
			_skill.m.Icon = "skills/active_128.png";
			_skill.m.IconDisabled = "skills/active_128_sw.png";
			_skill.m.Overlay = "active_128";
			_skill.setFatigueCost(15);
			_skill.m.ActionPointCost = 6;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Cudgel, function (_skill) {
			_skill.m.Icon = "skills/active_131.png";
			_skill.m.IconDisabled = "skills/active_131_sw.png";
			_skill.m.Overlay = "active_131";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.StrikeDown, function (_skill) {
			_skill.m.Icon = "skills/active_132.png";
			_skill.m.IconDisabled = "skills/active_132_sw.png";
			_skill.m.Overlay = "active_132";
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}

});

