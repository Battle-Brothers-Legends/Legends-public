this.legend_paint_black_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_black";
		this.m.Name = "Black Paint";
		this.m.Description = "A bucket of black paint. Highly sought after by artisans. It's dull appearance is a base for any fresco or artwork but alone is not interesting enough to be much much coin.";
		this.m.Icon = "consumables/paint_black.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 160;
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
