this.legend_ancient_legionary_helmet_restored <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_ancient_legionary_helmet_restored";
		this.m.Name = "Legionary Helmet";
		this.m.Description = "A well-crafted legionaire helmet of ancient design.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 700;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
		this.m.StaminaModifier = -8;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_ancient_legionaire_restored";
		this.m.SpriteDamaged = "legend_ancient_legionaire_restored_damaged";
		this.m.SpriteCorpse = "legend_ancient_legionaire_restored_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_ancient_legionary_restored.png";
	}
});

