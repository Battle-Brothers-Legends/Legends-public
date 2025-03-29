this.legend_paint_remover_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_paint_remover";
		this.m.Name = "Paint Remover";
		this.m.Description = "A bucket of paint remover. Everyone makes mistakes, and this is a good way for those with shakey hands to cover up their mistakes without looking like a charlatan.";
		this.m.Icon = "consumables/paint_remover.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsDroppedAsLoot = true;
		this.m.ProducingBuildings = [
			"attached_location.dye_maker"
		];
		this.m.Value = 150;
		this.m.ResourceValue = 1;
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
