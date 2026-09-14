this.legend_meat_hacker <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_meat_hacker";
		this.m.Name = "Meat Hacker";
		this.m.Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands. ";
		this.m.IconLarge = "weapons/melee/legend_meat_hacker_01.png";
		this.m.Icon = "weapons/melee/legend_meat_hacker_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_meat_hacker_01";
		this.m.Value = 2100;
		this.m.ShieldDamage = 32;
		this.m.Condition = 78.0;
		this.m.ConditionMax = 78.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Chop, function (_skill) {
			_skill.m.IsHack = true;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.m.ActionPointCost = 4;
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
	}
});
