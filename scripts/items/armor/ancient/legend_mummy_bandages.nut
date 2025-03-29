this.legend_mummy_bandages <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.legend_mummy_bandages";
		this.m.Name = "Ancient Southern Bandages";
		this.m.Description = "";
		this.m.IsDroppedAsLoot = false;
		this.m.ShowOnCharacter = true;
		local variants = [
			1,
			2
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 0;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "mummy_bandages_" + variant;
		this.m.SpriteDamaged = "mummy_bandages_" + variant + "_damaged";
		this.m.SpriteCorpse = "mummy_bandages_" + variant + "_dead";
		// this.m.IconLarge = "armor/inventory_body_armor_" + variant + ".png";
		// this.m.Icon = "armor/icon_body_armor_" + variant + ".png";
	}

});

