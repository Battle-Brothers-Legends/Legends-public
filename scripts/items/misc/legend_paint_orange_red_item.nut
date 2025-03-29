this.legend_paint_orange_red_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_orange_red";
		this.m.Name = "Orange and Red Paint";
		this.m.Description = "Buckets of orange and red paint. Both colours in high demand for artists and painters. These paints will fetch good coin.";
		this.m.Icon = "consumables/paint_yellow_red.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 380;
		this.m.ResourceValue = 2;
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
	}
	
});
