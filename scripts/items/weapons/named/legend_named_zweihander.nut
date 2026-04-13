this.legend_named_zweihander <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 0
	},
	function create() {
		this.named_weapon.create();
		this.m.Variants = [1, 2, 3, 4];
		this.m.ID = "weapon.legend_named_zweihander";
		this.m.NameList = this.Const.Strings.GreatswordNames;
		this.m.Description = "This zweihander is a true masterpiece, with a blade that is both flexible and easy to swing, but also delivers devastating blows to whoever is unlucky enough to get in range.";
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
		this.m.ShieldDamage = 16;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
		this.randomizeValues();
	}

	function updateVariant() {
		this.m.Icon = "weapons/melee/named_zweihander_0" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/named_zweihander_0" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_named_zweihander_0" + this.m.Variant;
	}

	function onEquip() {
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

