this.legend_vampire_lord_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.legend_vampire_lord_armor";
		this.m.Name = "Vampire Lord Armor";
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
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_body_vampire_lord_armor_" + variant;
		this.m.SpriteDamaged = "bust_body_vampire_lord_armor_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_body_vampire_lord_armor_" + variant + "_dead";
		// this.m.IconLarge = "armor/inventory_body_armor_" + variant + ".png";
		// this.m.Icon = "armor/icon_body_armor_" + variant + ".png";
	}

});

