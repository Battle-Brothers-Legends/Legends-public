this.legend_mummy_royal_plate <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.legend_mummy_royal_plate";
		this.m.Name = "Ancient Southern Royal Plate";
		this.m.Description = "";
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 0;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "mummy_royal_plate_" + variant;
		this.m.SpriteDamaged = "mummy_royal_plate_" + variant + "_damaged";
		this.m.SpriteCorpse = "mummy_royal_plate_" + variant + "_dead";
		// this.m.IconLarge = "armor/inventory_body_armor_" + variant + ".png";
		// this.m.Icon = "armor/icon_body_armor_" + variant + ".png";
	}

});

