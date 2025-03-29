this.legend_paint_white_blue_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_white_blue";
		this.m.Name = "White and Blue Paint";
		this.m.Description = "Buckets of white and blue paint. Both highly sought after colours due to their rarity.";
		this.m.Icon = "consumables/paint_blue_white.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 645;
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
