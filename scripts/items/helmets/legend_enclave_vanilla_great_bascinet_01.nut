this.legend_enclave_vanilla_great_bascinet_01 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.great_bascinet_1";
		this.m.Name = "Great Bascinet With Visor";
		this.m.Description = "A large bascinet covering the entirety of the head as well as the neck with plates. Offers great protection but makes it quite difficult to turn one's neck.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2600;
		this.m.Condition = 330;
		this.m.ConditionMax = 330;
		this.m.StaminaModifier = -24;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_great_bascinet_01";
		this.m.SpriteDamaged = "enclave_vanilla_great_bascinet_01_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_great_bascinet_01_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/enclave_vanilla_great_bascinet_01.png";
	}

});

