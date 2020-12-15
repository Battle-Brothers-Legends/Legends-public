this.legend_helm_curved <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_curved";
		this.m.Name = "Curved Great Helm";
		this.m.Description = "A closed metal helm with a smooth surface. Great protection at the expense of breathing and sight.";
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
		this.m.Value = 3200;
		this.m.Condition = 325;
		this.m.ConditionMax = 325;
		this.m.StaminaModifier = -21;
		this.m.Vision = -4;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_curved";
		this.m.SpriteDamaged = "bust_helmet_04_curved_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_curved_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_curved.png";
		this.m.Icon = "helmets/inventory_helmet_04_curved.png";
	}

});

