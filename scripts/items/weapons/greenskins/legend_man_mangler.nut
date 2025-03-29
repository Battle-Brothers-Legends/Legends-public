this.legend_man_mangler <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 0
		},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_man_mangler";
		this.m.Name = "Man Mangler";
		this.m.Description = "A massive, crudely sharpened shard of metal that makes up for its stunted length through sheer weight. So heavy no average human can use it effectively.";
		this.m.IconLarge = "weapons/melee/legend_man_mangler_01.png";
		this.m.Icon = "weapons/melee/legend_man_mangler_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_man_mangler_01";
		this.m.Value = 1600;
		this.m.ShieldDamage = 32;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -26;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 95;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.35;
		this.m.ChanceToHitHead = 5;
		this.m.FatigueOnSkillUse = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.OverheadStrike, function (_skill) {
			_skill.m.DirectDamageMult = this.m.DirectDamageMult; //Sets Overhead Strike's Direct Damage Mult to Man Mangler's Direct Damage Mult
			_skill.setStunChance(this.m.StunChance);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.Slash, function (_skill) {
			_skill.m.IsGreatSlash = true;
			_skill.m.DirectDamageMult = this.m.DirectDamageMult;
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5); // it's just 5 cause FatigueOnSkillUse is applied separately
		}.bindenv(this));
	}

});
