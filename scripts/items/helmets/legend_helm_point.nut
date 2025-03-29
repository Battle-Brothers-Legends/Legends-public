this.legend_helm_point <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_helm_point";
		this.m.Name = "Snouted Helm";
		this.m.Description = "A closed metal helm with pointed snout. Good defense against lances";
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
		this.m.Value = 3500;
		this.m.Condition = 350;
		this.m.ConditionMax = 350;
		this.m.StaminaModifier = -23;
		this.m.Vision = -4;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_04_point";
		this.m.SpriteDamaged = "bust_helmet_04_point_damaged";
		this.m.SpriteCorpse = "bust_helmet_04_point_dead";
		this.m.IconLarge = "helmets/inventory_helmet_04_point.png";
		this.m.Icon = "helmets/inventory_helmet_04_point.png";
	}

});

