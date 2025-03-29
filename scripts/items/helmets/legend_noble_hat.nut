this.legend_noble_hat <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.noble_hat";
		this.m.Name = "Noble Hat";
		this.m.Description = "A fine hat made of excellent materials";
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
		this.m.Value = 70;
		this.m.Condition = 32;
		this.m.ConditionMax = 32;
		this.m.StaminaModifier = 0;
	}
	
		function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "noble_hat_" + variant;
		this.m.SpriteDamaged = "noble_hat_" + variant + "_damaged";
		this.m.SpriteCorpse = "noble_hat_" + variant + "_dead";
		this.m.IconLarge = "legend_helmets/noble_hat_" + variant + ".png";
		this.m.Icon = "legend_helmets/noble_hat_" + variant + ".png";
	}

});

