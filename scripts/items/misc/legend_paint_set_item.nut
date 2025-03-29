this.legend_paint_set_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_set_shields";
		this.m.Name = "Paint Set";
		this.m.Description = "A palette of several vibrant colors and a set of brushes. An ideal gift for any aspiring painter to use before completely losing interest halfway through.";
		this.m.Icon = "consumables/paint_set_shields.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 760;
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
