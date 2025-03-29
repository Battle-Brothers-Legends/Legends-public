this.legend_greenwood_schrat_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_greenwood_schrat";
		this.m.Name = "Greenwood Schrat\'s Shield";
		this.m.Description = "";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.Variant = 1;
		this.updateVariant();
		this.m.Value = 0;
		this.m.MeleeDefense = 40;
		this.m.RangedDefense = 40;
		this.m.StaminaModifier = 0;
		this.m.Condition = 128;
		this.m.ConditionMax = 128;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_schrat_green_shield_0" + this.m.Variant;
		this.m.SpriteDamaged = "bust_schrat_green_shield_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
	}

});

