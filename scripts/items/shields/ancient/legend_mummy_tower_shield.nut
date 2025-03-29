this.legend_mummy_tower_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_mummy_tower_shield";
		this.m.Name = "Ancient Southern Tower Shield";
		this.m.Description = "A tall and heavy southern tower shield that offers good protection at the cost of being very bulky to handle. Covers a whole man with ease despite being tall and narrow.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 850;
		this.m.MeleeDefense = 15;
		this.m.RangedDefense = 30;
		this.m.StaminaModifier = -30;
		this.m.Condition = 52;
		this.m.ConditionMax = 52;
	}

	function updateVariant()
	{
		this.m.Sprite = "mummy_towershield_0" + this.m.Variant;
		this.m.SpriteDamaged = "mummy_towershield_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "mummy_towershield_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_mummy_towershield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_mummy_towershield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendFortify);
		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	}

});

