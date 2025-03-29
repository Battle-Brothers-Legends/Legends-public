this.legend_paint_red_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_red";
		this.m.Name = "Red Paint";
		this.m.Description = "A bucket of red paint. This is a common but much needed colour that is used from shields to the finest artwork. It is colourful but easy to make.";
		this.m.Icon = "consumables/paint_red.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 270;
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
