this.legend_helm_wings <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_wings";
		this.m.Name = "Winged Great Helm";
		this.m.Description = "A closed metal helm with winged neckplate. Provides more protection at the cost of breathing";
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
		this.m.Value = 3300;
		this.m.Condition = 335;
		this.m.ConditionMax = 335;
		this.m.StaminaModifier = -22;
		this.m.Vision = 0;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_wings";
		this.m.SpriteDamaged = "bust_helmet_04_wings_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_wings_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_wings.png";
		this.m.Icon = "helmets/inventory_helmet_04_wings.png";
	}

});

