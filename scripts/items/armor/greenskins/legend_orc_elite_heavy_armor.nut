this.legend_orc_elite_heavy_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.legend_orc_elite_heavy_armor";
		this.m.Name = "Bloody Looted Plate Armor";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 600;
		this.m.ConditionMax = 600;
		this.m.StaminaModifier = -45;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_orc_elite_armor_01";
		this.m.SpriteDamaged = "bust_orc_elite_armor_01_damaged";
		this.m.SpriteCorpse = "bust_orc_elite_armor_01_dead";
	}

});
