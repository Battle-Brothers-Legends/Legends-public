this.legend_frogmouth_helm_decorated <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_frogmouth_helm_decorated";
		this.m.Name = "Decorated Frogmouth Helm";
		this.m.Description = "A decorated closed metal helm with a breathing hole in the shape of a frog mouth. Great in the way of protection but hard to breathe in and limiting the field of view.";
		this.m.NameList = [
			"The Swan Toad",
			"Bufo Bufo",
			"Triturus Sallet",
			"Helm of the Treefrog",
			"Spadefoot Helm"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 7000;
		this.m.Condition = 330;
		this.m.ConditionMax = 330;
		this.m.StaminaModifier = -24;
		this.m.Vision = -2;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_frogmouth_02";
		this.m.SpriteDamaged = "legend_frogmouth_02_damaged";
		this.m.SpriteCorpse = "legend_frogmouth_02_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_frogmouth_02.png";
	}

});

