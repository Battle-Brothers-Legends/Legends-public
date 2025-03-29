this.legend_enclave_vanilla_kettle_sallet_01 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.enclave_vanilla_kettle_sallet_01";
		this.m.Name = "Kettle Sallet With Bevor";
		this.m.Description = "A sallet composed of one plate with a thin slit as a visor. This sallet has a bevor attached to protect the mouth and throat.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3000;
		this.m.Condition = 280;
		this.m.ConditionMax = 280;
		this.m.StaminaModifier = -19;
		this.m.Vision = -3;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_kettle_sallet_01";
		this.m.SpriteDamaged = "enclave_vanilla_kettle_sallet_01_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_kettle_sallet_01_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_kettle_sallet_01.png";
	}

});

