this.legend_paint_white_green_yellow_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_white_green_yellow";
		this.m.Name = "White, Green and Yellow Paint";
		this.m.Description = "Buckets of white, green and yellow paint. This collection of paint can be used on just about anything and aside from red form the basis of most art.";
		this.m.Icon = "consumables/paint_green_white_yellow.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 520;
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
