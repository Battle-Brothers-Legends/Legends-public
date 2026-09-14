this.ancient_wig <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create() {
		this.helmet.create();
		this.m.ID = "armor.head.ancient_wig";
		this.m.Name = "";
		this.m.Description = "";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		local variants = [
			1
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 400;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -2;
		this.m.Vision = 0;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_ancient_wig" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_ancient_wig" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_ancient_wig" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_ancient_wig" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/vanity/legend_helmet_ancient_wig")];
	}
});

