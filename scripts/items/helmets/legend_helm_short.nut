this.legend_helm_short <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_short";
		this.m.Name = "Full Helm With Neckplate";
		this.m.Description = "A closed metal helm with neckplate. Provides more protection at the cost of breathing";
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
		this.m.Value = 3250;
		this.m.Condition = 330;
		this.m.ConditionMax = 330;
		this.m.StaminaModifier = -22;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_short";
		this.m.SpriteDamaged = "bust_helmet_04_short_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_short_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_short.png";
		this.m.Icon = "helmets/inventory_helmet_04_short.png";
	}

});

