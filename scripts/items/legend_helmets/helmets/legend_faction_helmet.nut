this.legend_faction_helmet <- this.inherit("scripts/items/legend_helmets/hood/legend_helmet_chain_hood", {
	m = {},
	function create()
	{
		this.legend_helmet_chain_hood.create();
		this.m.ID = "armor.head.legend_faction_helmet";
		this.m.Name = "Chain Hood";
		this.m.Description = "A sturdy chain hood of military grade.";
		this.m.Variants = [1, 2, 3, 4];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -4;
		this.m.Vision = 0;
	}

	function setupArmor( _variant ) {
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_great_helm");
		helm.setVariant(1);
		this.setUpgrade(helm);

		local flair = this.new("scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet");
		flair.setVariant(_variant);
		this.setUpgrade(flair);
	}

});

