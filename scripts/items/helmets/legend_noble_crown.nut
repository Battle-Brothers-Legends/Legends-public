this.legend_noble_crown <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.noble_crown";
		this.m.Name = "Noble Crown";
		this.m.Description = "A fine crown made of excellent materials";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 500;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = 0;
	}

		function updateVariant()
	{

		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_crown" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_crown" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_crown" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_crown" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
	}

});

