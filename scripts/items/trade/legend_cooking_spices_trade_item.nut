this.legend_cooking_spices_trade_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {
		Uses = 0
	},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.legend_cooking_spices";
		this.m.Name = "Cooking Spices";
		this.m.Description = "Combining salts, dried herbs and roots. Can be combined with other food in the crafting tent to cook recipes";
		this.m.Icon = "supplies/legend_cooking_spices.png";
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.Value = 380;
		this.m.Uses = 8;
		this.m.ProducingBuildings = [
			"attached_location.gatherers_hut"
		];
	}

	function getTooltip()
	{
		local result = this.trading_good_item.getTooltip();

		if (this.m.Uses == 8)
		{
			result.push({
				id = 4,
				type = "text",
				text = "Can be used in recipes 8 times"
			});	
		}
		else
		{
			result.push({
				id = 4,
				type = "text",
				text = "Uses remaining: " + this.m.Uses + "/8"
			});
		}

		return result;
	}

	function getValue()
	{
		return this.Math.floor(this.m.Value * (this.m.Uses / (8 * 1.0)));
	}

	function onSerialize( _out )
	{
		this.trading_good_item.onSerialize(_out);
		_out.writeU8(this.m.Uses);
	}

	function onDeserialize( _in )
	{
		this.trading_good_item.onDeserialize(_in);
		this.m.Uses = _in.readU8();
	}
});

