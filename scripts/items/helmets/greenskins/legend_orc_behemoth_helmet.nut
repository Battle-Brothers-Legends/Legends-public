this.legend_orc_behemoth_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.updateVariant();
		this.m.ID = "armor.head.legend_orc_behemoth_helmet";
		this.m.Name = "Behemoth Helm";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "";
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -18;
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_orc_behemoth_helmet_01";
		this.m.SpriteDamaged = "legend_orc_behemoth_helmet_01_damaged";
		this.m.SpriteCorpse = "legend_orc_behemoth_helmet_01_dead";
	}

});
