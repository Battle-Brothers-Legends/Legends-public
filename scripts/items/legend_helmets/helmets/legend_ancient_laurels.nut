this.legend_ancient_laurels <- this.inherit("scripts/items/helmets/ancient/ancient_laurels", {
	m = {},
	function create()
	{
		this.ancient_laurels.create();
		this.m.ID = "armor.head.legend_ancient_laurels";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/vanity/legend_helmet_wreath")];
	}


});

