this.legend_enclave_vanilla_kettle_sallet_03 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.enclave_vanilla_kettle_sallet_03";
		this.m.Name = "Kettle Sallet";
		this.m.Description = "A sallet composed of one plate with a thin slit as a visor.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1000;
		this.m.Condition = 170;
		this.m.ConditionMax = 170;
		this.m.StaminaModifier = -10;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_kettle_sallet_03";
		this.m.SpriteDamaged = "enclave_vanilla_kettle_sallet_03_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_kettle_sallet_03_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_kettle_sallet_03.png";
	}

});

