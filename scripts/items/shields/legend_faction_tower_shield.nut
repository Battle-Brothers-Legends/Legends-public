this.legend_faction_tower_shield <- this.inherit("scripts/items/shields/shield", {
	m = {
		Faction = 1
	},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_faction_tower_shield";
		this.m.Name = "Noble Tower Shield";
		this.m.Description = "A large square shield that offers excellent protection for yourself and others, very heavy and hard to maneuver";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 1000;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = -30;
		this.m.Condition = 96;
		this.m.ConditionMax = 96;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.Sprite = "towershield_noble_" + variant;
		this.m.SpriteDamaged = "towershield_noble_" + variant + "_damaged";
		this.m.ShieldDecal = "towershield_noble_" + variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_faction_towershield_" + variant + ".png";
		this.m.Icon = "shields/icon_faction_towershield_" + variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendFortify);
		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	}

	function setFaction( _f )
	{
		this.m.Faction = _f;
		this.m.Variant = _f;
		this.updateVariant();
	}

});

