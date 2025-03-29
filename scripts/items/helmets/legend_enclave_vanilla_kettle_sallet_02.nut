this.legend_enclave_vanilla_kettle_sallet_02 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.enclave_vanilla_kettle_sallet_02";
		this.m.Name = "Kettle Sallet With Coif";
		this.m.Description = "A sallet composed of one plate with a thin slit as a visor. This one has a mail coif attached adding protection to slashing attacks.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2700;
		this.m.Condition = 270;
		this.m.ConditionMax = 270;
		this.m.StaminaModifier = -18;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_kettle_sallet_02";
		this.m.SpriteDamaged = "enclave_vanilla_kettle_sallet_02_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_kettle_sallet_02_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_kettle_sallet_02.png";
	}

});

