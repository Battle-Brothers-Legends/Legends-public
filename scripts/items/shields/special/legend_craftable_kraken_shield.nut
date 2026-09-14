this.legend_craftable_kraken_shield <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {},

	function create() {
		this.named_shield.create();
		this.m.ID = "shield.legend_craftable_kraken";
		this.m.Name = "Kraken Shield";
		this.m.NameList = this.Const.Strings.ShieldNames;
		this.m.Description = "This shield, carved out of a horn plate taken from a giant kraken, is stronger than any common shield.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 9;
		this.updateVariant();
		this.m.Value = 1200;
		this.m.MeleeDefense = 24;
		this.m.RangedDefense = 24;
		this.m.StaminaModifier = -15;
		this.m.Condition = 65;
		this.m.ConditionMax = 65;
		this.m.Block = 20;
		this.m.RegularDamage = 20;
		this.m.RegularDamage = 40;
		this.randomizeValues();
	}

	function resetStats() {
		this.m.MeleeDefense = 24;
		this.m.RangedDefense = 24;
		this.m.StaminaModifier = -15;
		this.m.Condition = 65;
		this.m.ConditionMax = 65;
		this.m.Block = 20;
		this.m.RegularDamage = 20;
		this.m.RegularDamage = 40;
	}

	function updateVariant() {
		this.m.Sprite = "shield_named_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_named_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_named_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_named_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_named_shield_0" + this.m.Variant + ".png";
	}

	function onEquip() {
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Shieldwall);
		::Legends.Actives.grant(this, ::Legends.Active.KnockBack);
	}
});
