this.legend_enclave_vanilla_great_helm_01 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.enclave_vanilla_great_helm_01";
		this.m.Name = "Great Helm";
		this.m.Description = "A closed metal helm with breathing holes. Great in the way of protection but hard to breathe in and limiting the field of view.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3500;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -20;
		this.m.Vision = -3;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_great_helm_01";
		this.m.SpriteDamaged = "enclave_vanilla_great_helm_01_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_great_helm_01_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_great_helm_01.png";
	}

});

