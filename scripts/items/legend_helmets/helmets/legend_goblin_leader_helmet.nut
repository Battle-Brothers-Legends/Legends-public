this.legend_goblin_leader_helmet <- this.inherit("scripts/items/helmets/greenskins/goblin_leader_helmet", {
	m = {},
	function create()
	{
		this.goblin_leader_helmet.create();
		this.m.ID = "armor.head.legend_goblin_leader_helmet";
		this.m.IsDroppedAsLoot = false;
	}

	function getLootLayers()
	{
		return [this.new("scripts/items/legend_helmets/top/legend_helmet_goblin_spiked_helm")];
	}


});

