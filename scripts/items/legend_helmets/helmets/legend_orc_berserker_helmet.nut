this.legend_orc_berserker_helmet <- this.inherit("scripts/items/helmets/greenskins/orc_berserker_helmet", {
	m = {},
	function create()
	{
		this.orc_berserker_helmet.create();
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/vanity/legend_helmet_orc_bones")];
	}

});

