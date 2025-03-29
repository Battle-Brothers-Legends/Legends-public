this.legend_enclave_vanilla_armet_02 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.armet_2";
		this.m.Name = "Armet";
		this.m.Description = "A closed helm covering the entirety of the head. It also has a small aventail of mail attached.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2900;
		this.m.Condition = 270;
		this.m.ConditionMax = 270;
		this.m.StaminaModifier = -19;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_armet_02";
		this.m.SpriteDamaged = "enclave_vanilla_armet_02_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_armet_02_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_armet_02.png";
	}

});

