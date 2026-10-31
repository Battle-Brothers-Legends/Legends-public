this.legend_trading_good_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function onCraft(_stash) {
		local item = ::new(this.m.ItemScript);
		_stash.add(item);
		item.setCraftedTradeGood(this.m.Cost);
		::Legends.LastCraftedTradeGood = item;
	}
});