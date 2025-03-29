this.legend_helm_bearded <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_bearded";
		this.m.Name = "Bearded Helm";
		this.m.Description = "A closed metal helm with beard. Great in the way of protection and beauty but hard to breathe in and limiting the field of view.";
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
		this.m.Value = 3600;
		this.m.Condition = 350;
		this.m.ConditionMax = 350;
		this.m.StaminaModifier = -23;
		this.m.Vision = -5;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_bearded";
		this.m.SpriteDamaged = "bust_helmet_04_bearded_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_bearded_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_bearded.png";
		this.m.Icon = "helmets/inventory_helmet_04_bearded.png";
	}

});

