this.legend_barbdiche <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_barbdiche";
		this.m.Name = "Heavy Rusty Battleaxe";
		this.m.Variants = [1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.Description = "A slab of sharpened metal placed on a long haft that can be brought down for devastating effect.";
		this.m.Categories = "Axe, Two-Handed";
		this.m.IconLarge = "weapons/melee/bardiche_01.png";
		this.m.Icon = "weapons/melee/bardiche_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_bardiche_01";
		this.m.Value = 2600;
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
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/barbdiche_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/barbdiche_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_barbdiche_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitMan);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitAxe);
		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield, function (_skill) {
			_skill.setApplyAxeMastery(true);
			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}

});
