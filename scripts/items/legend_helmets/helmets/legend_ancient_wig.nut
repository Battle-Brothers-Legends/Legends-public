this.legend_ancient_wig <- this.inherit("scripts/items/helmets/ancient/ancient_wig", {
	m = {},
	function create()
	{
		this.ancient_wig.create();
		this.m.ID = "armor.head.legend_ancient_wig";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/vanity/legend_helmet_ancient_wig")];
	}

});

