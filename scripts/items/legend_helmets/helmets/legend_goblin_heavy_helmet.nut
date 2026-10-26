this.legend_goblin_heavy_helmet <- this.inherit("scripts/items/helmets/greenskins/goblin_heavy_helmet", {
	m = {},
	function create()
	{
		this.goblin_heavy_helmet.create();
		this.m.ID = "armor.head.legend_goblin_heavy_helmet";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		return [::Legends.Items.pickHelmet([[1, ::Legends.Helmet.Greenskin.legend_goblin_heavy_helmet]])];
	}

});

