this.legend_helm_full_named <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_helm_full_named";
		this.m.Name = "Full Great Helm";
		this.m.NameList = [
			"Bullwark",
			"Bastion",
			"Breakers End",
			"The Summit",
			"The Wall",
			"The Halo"
		];
		this.m.Description = "An exquisite closed metal helm with reinforced face plates. Outstanding protection at the expense of breathing and sight.";
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
		this.m.Condition = 370;
		this.m.ConditionMax = 370;
		this.m.StaminaModifier = -25;
		this.m.Vision = -4;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_full_named";
		this.m.SpriteDamaged = "bust_helmet_04_full_named_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_full_named_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_full_named.png";
		this.m.Icon = "helmets/inventory_helmet_04_full_named.png";
	}

});

