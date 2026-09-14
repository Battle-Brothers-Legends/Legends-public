this.legend_tin_ingots_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_tin_ingots";
		this.m.Name = "Tin Ingot";
		this.m.Description = "Tin smolten and cast into an ingot for easy transportation. Used together with Copper to make Bronze.";
		this.m.Icon = "trade/inventory_trade_tin_bars.png";
		this.m.Culture = this.Const.World.Culture.Northern;
		this.m.ProducingBuildings = [
			"attached_location.surface_iron_vein"
		];
		this.m.Value = 420;
		this.m.ResourceValue = 2;
	}

});

