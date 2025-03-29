this.legend_frogmouth_helm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_frogmouth_helm";
		this.m.Name = "Frogmouth Helm";
		this.m.Description = "A closed metal helm with a breathing hole in the shape of a frog mouth. Great in the way of protection but hard to breathe in and limiting the field of view.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 330;
		this.m.ConditionMax = 330;
		this.m.StaminaModifier = -24;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_frogmouth_01";
		this.m.SpriteDamaged = "legend_frogmouth_01_damaged";
		this.m.SpriteCorpse = "legend_frogmouth_01_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_frogmouth_01.png";
	}

});

