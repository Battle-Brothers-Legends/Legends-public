this.legend_southern_veil_coin <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_southern_veil";
		this.m.Name = "Southern Coin Veil";
		this.m.Description = "A southern veil made of delicate metal chains";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.HideHair = false;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		local variants = [
			1,
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 30;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
	}


	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "southern_veil_coin_" + variant;
		this.m.SpriteDamaged = "southern_veil_coin_" + variant + "_damaged";
		this.m.SpriteCorpse = "southern_veil_coin_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/icon_southern_veil_" + variant + ".png";
	}

});

