this.legend_orc_behemoth_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.updateVariant();
		this.m.ID = "armor.body.legend_orc_behemoth_armor";
		this.m.Name = "Looted Reinforced Mail";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ShowOnCharacter = true;
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -22;
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_orc_behemoth_armour_01";
		this.m.SpriteDamaged = "legend_orc_behemoth_armour_01_damaged";
		this.m.SpriteCorpse = "legend_orc_behemoth_armour_01_dead";
	}

});
