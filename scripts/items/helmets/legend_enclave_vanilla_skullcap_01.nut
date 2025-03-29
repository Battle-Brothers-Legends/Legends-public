this.legend_enclave_vanilla_skullcap_01 <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.enclave_vanilla_skullcap_01";
		this.m.Name = "Skull Cap";
		this.m.Description = "A simple iron helmet covering the cranium just above eye-level. Also has a mail aventail attached.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2600;
		this.m.Condition = 245;
		this.m.ConditionMax = 245;
		this.m.StaminaModifier = -17;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "enclave_vanilla_skullcap_01";
		this.m.SpriteDamaged = "enclave_vanilla_skullcap_01_damaged";
		this.m.SpriteCorpse = "enclave_vanilla_skullcap_01_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_enclave_vanilla_skullcap_01.png";
	}

});

