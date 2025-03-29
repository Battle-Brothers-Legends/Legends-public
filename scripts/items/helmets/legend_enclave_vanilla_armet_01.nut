this.legend_enclave_vanilla_armet_01 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.armet_1";
		this.m.Name = "Armet with Visor";
		this.m.Description = "A closed helm covering the entirety of the head, with a visor attached to protect the face. It also has a small aventail of mail attached.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = false;
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
		this.m.Sprite = "enclave_vanilla_armet_01";
		this.m.SpriteDamaged = "enclave_vanilla_armet_01_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_armet_01_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_armet_01.png";
	}

});

