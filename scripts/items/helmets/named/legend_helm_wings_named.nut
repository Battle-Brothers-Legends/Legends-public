this.legend_helm_wings_named <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_helm_wings_named";
		this.m.Name = "Winged Great Helm";
		this.m.NameList = [
			"Faith",
			"Redemption",
			"Pennance",
			"Rapture",
			"Guardian",
			"Hope"
		];
		this.m.Description = "An exquisite closed metal helm with golden winged neck plate. Outstanding protection at the expense of breathing";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10000;
		this.m.Condition = 360;
		this.m.ConditionMax = 360;
		this.m.StaminaModifier = -25;
		this.m.Vision = -3;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_wings_named";
		this.m.SpriteDamaged = "bust_helmet_04_wings_named_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_wings_named_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_wings_named.png";
		this.m.Icon = "helmets/inventory_helmet_04_wings_named.png";
	}

});

