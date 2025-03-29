this.legend_ancient_priest_diadem <- this.inherit("scripts/items/helmets/ancient/ancient_priest_diadem", {
	m = {},
	function create()
	{
		this.ancient_priest_diadem.create();
		this.m.ID = "armor.head.legend_ancient_priest_diadem";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		local L = [this.new("scripts/items/legend_helmets/top/legend_helmet_ancient_crown")];
		switch (this.m.Variant)
		{
			case 79:
				L.push(this.new("scripts/items/legend_helmets/vanity_lower/legend_helmet_wings"));
				break;
			case 80:
				L.push(this.new("scripts/items/legend_helmets/vanity_lower/legend_helmet_feather_crest"));
				break;
			case 81:
				L.push(this.new("scripts/items/legend_helmets/vanity/legend_helmet_metal_bird"));
				break;
		}
		return L;
	}



});

