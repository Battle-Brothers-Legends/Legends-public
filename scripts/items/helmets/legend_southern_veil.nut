this.legend_southern_veil <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_southern_veil";
		this.m.Name = "Southern Veil";
		this.m.Description = "A translucent southern veil made of soft material";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.HideHair = false;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		local variants = [
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 10;
		this.m.Condition = 5;
		this.m.ConditionMax = 5;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
	}


	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "southern_veil_" + variant;
		this.m.SpriteDamaged = "southern_veil_" + variant + "_damaged";
		this.m.SpriteCorpse = "southern_veil_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/icon_southern_veil_" + variant + ".png";
	}

});

