this.legend_ancient_lich_headpiece <- this.inherit("scripts/items/helmets/ancient/ancient_lich_headpiece", {
	m = {},
	function create()
	{
		this.ancient_lich_headpiece.create();
		this.m.ID = "armor.head.legend_ancient_lich_headpiece";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/vanity/legend_helmet_ancient_priest_hat")];
	}

});

