this.legend_frogmouth_helm_crested_painted <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_frogmouth_helm_crested_painted";
		this.m.Name = "Crested Painted Frogmouth Helm";
		this.m.Description = "A painted closed metal helm with a metal crest and a breathing hole in the shape of a frog mouth. Great in the way of protection but hard to breathe in and limiting the field of view.";
		this.m.NameList = [
			"Stechhelm",
			"Newt Helm",
			"Triturus Sallet",
			"Helm of the Treefrog",
			"Ranid Helm"
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
		this.m.Value = 10000;
		this.m.Condition = 345;
		this.m.ConditionMax = 345;
		this.m.StaminaModifier = -25;
		this.m.Vision = -2;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "legend_frogmouth_04";
		this.m.SpriteDamaged = "legend_frogmouth_04_damaged";
		this.m.SpriteCorpse = "legend_frogmouth_04_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_frogmouth_04.png";
	}

});

