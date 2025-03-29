this.legend_helm_full <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_full";
		this.m.Name = "Full Great Helm";
		this.m.Description = "A closed metal helm with reinforced face plates. Outstanding protection at the expense of breathing and sight.";
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
		this.m.Value = 3750;
		this.m.Condition = 357;
		this.m.ConditionMax = 357;
		this.m.StaminaModifier = -24;
		this.m.Vision = -5;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_full";
		this.m.SpriteDamaged = "bust_helmet_04_full_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_full_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_full.png";
		this.m.Icon = "helmets/inventory_helmet_04_full.png";
	}

});

