this.legend_frogmouth_helm_crested <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_frogmouth_helm_crested";
		this.m.Name = "Crested Frogmouth Helm";
		this.m.Description = "A closed metal helm with a metal crest and a breathing hole in the shape of a frog mouth. Great in the way of protection but hard to breathe in and limiting the field of view.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 8000;
		this.m.Condition = 345;
		this.m.ConditionMax = 345;
		this.m.StaminaModifier = -25;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_frogmouth_03";
		this.m.SpriteDamaged = "legend_frogmouth_03_damaged";
		this.m.SpriteCorpse = "legend_frogmouth_03_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_frogmouth_03.png";
	}

});

