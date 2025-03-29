this.legend_helm_breathed <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_breathed";
		this.m.Name = "Breathed Helm";
		this.m.Description = "A closed metal helm with many breaths. Sacrifices a small amount of protection for increased breathing and sight, and cost.";
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.IsDroppedAsLoot = true;
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 4000;
		this.m.Condition = 320;
		this.m.ConditionMax = 320;
		this.m.StaminaModifier = -20;
		this.m.Vision = -4;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_breaths";
		this.m.SpriteDamaged = "bust_helmet_04_breaths_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_breaths_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_breaths.png";
		this.m.Icon = "helmets/inventory_helmet_04_breaths.png";
	}

});

