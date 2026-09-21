this.legend_trading_good_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
		ItemScript = null
	},

	function onCraft(_stash) {
		local item = this.new(this.m.ItemScript);
		_stash.add(item);
		item.setCraftedTradeGood(this.m.Cost);
		::Legends.LastCraftedTradeGood = item;
	}
});