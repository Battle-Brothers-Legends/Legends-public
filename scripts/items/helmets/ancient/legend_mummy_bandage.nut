this.legend_mummy_bandage <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_mummy_bandage";
		this.m.Name = "";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.HideHair = false;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		local variants = [
			1,
			2
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5;
		this.m.Condition = 15;
		this.m.ConditionMax = 5;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
	}


	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "mummy_bandage_" + variant;
		this.m.SpriteDamaged = "mummy_bandage_" + variant + "_damaged";
		this.m.SpriteCorpse = "mummy_bandage_" + variant + "_dead";
		this.m.IconLarge = "armor/inventory_mummy_bandage_" + variant + ".png";
		// this.m.Icon = "armor/icon_mummy_bandage_" + variant + ".png";
	}

});

