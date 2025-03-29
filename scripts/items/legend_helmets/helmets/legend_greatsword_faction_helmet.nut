this.legend_greatsword_faction_helmet <- this.inherit("scripts/items/legend_helmets/hood/legend_helmet_padded_hood", {
	m = {},
	function create()
	{
		this.legend_helmet_padded_hood.create();
	}

	function setupArmor( _variant ) {
		local helm = this.new("scripts/items/legend_helmets/helm/legend_helmet_sallet");
		helm.setVariant(1);
		this.setUpgrade(helm);

		local flair = this.new("scripts/items/legend_helmets/vanity/legend_helmet_faction_helmet_2");
		flair.setVariant(_variant);
		this.setUpgrade(flair);
	}

});

