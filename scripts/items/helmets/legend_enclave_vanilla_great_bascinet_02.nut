this.legend_enclave_vanilla_great_bascinet_02 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.enclave_vanilla_great_bascinet_02";
		this.m.Name = "Visorless Great Bascinet";
		this.m.Description = "A great bascinet that is formed of a single encompassing plate, covering the head completely, aswell as the neck and a bit of the shoulders too. Excellent protection.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2800;
		this.m.Condition = 340;
		this.m.ConditionMax = 340;
		this.m.StaminaModifier = -25;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_great_bascinet_02";
		this.m.SpriteDamaged = "enclave_vanilla_great_bascinet_02_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_great_bascinet_02_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_great_bascinet_02.png";
	}

});

