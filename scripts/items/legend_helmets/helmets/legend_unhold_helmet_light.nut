this.legend_unhold_helmet_light <- this.inherit("scripts/items/helmets/barbarians/unhold_helmet_light", {
	m = {},
	function create()
	{
		this.unhold_helmet_light.create();
		this.m.ID = "armor.head.legend_unhold_helmet_light";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/top/legend_helmet_unhold_head_chain")];
	}

});

