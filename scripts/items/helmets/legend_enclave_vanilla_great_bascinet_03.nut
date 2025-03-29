this.legend_enclave_vanilla_great_bascinet_03 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.enclave_vanilla_great_bascinet_03";
		this.m.Name = "Great Bascinet With Visor";
		this.m.Description = "A great bascinet that is formed of a single encompassing plate, covering the head completely, aswell as the neck and a bit of the shoulders too. Includes a pig-faced visor for added face-protection.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3200;
		this.m.Condition = 365;
		this.m.ConditionMax = 365;
		this.m.StaminaModifier = -26;
		this.m.Vision = -3;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_great_bascinet_03";
		this.m.SpriteDamaged = "enclave_vanilla_great_bascinet_03_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_great_bascinet_03_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_great_bascinet_03.png";
	}

});

