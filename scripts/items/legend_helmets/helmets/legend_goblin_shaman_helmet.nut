this.legend_goblin_shaman_helmet <- this.inherit("scripts/items/helmets/greenskins/goblin_shaman_helmet", {
	m = {},
	function create()
	{
		this.goblin_shaman_helmet.create();
		this.m.ID = "armor.head.legend_goblin_shaman_helmet";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/vanity/legend_helmet_goblin_bones")];
	}



});

