
this.legend_jewelry <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.legend_jewelry";
		this.m.Name = "Southern Coin Veil";
		this.m.Description = "A southern veil made of coins threaded togther";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 500;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
		this.m.HideBeard = true;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_legend_jewelry" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_legend_jewelry" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_legend_jewelry" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/legend_jewelry" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
	}
});
