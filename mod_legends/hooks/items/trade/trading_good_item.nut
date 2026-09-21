::Legends.LastCraftedTradeGood <- null;

::mods_hookBaseClass("items/trade/trading_good_item", function ( o ) {
	
	o.m.IsCraftedTradeGood <- false;
	o.m.CraftedPrice <- 0;

	o.setBoughtAtPrice <- function( _price ) {
		this.m.BoughtAtPrice = _price;
	}

	o.setCraftedTradeGood <- function( _price ) {
		this.m.BoughtAtPrice = 0;
		this.m.IsCraftedTradeGood = true;
		this.m.CraftedPrice = _price;
	}

	o.setCraftedPrice <- function( _price ) {
		this.m.CraftedPrice = _price;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function() {
		local result = getTooltip();

		if (this.m.IsCraftedTradeGood) {
			result.push({
				id = 7,
				type = "text",
				text = "Crafted %craftHistory%",
				param = [
					["craftHistory", this.m.CraftedPrice > 0 ? "for [img]gfx/ui/tooltips/money.png[/img]" + this.m.CraftedPrice : " in camp"] // Assumes that 0 crafted price means it was crafted in camp instead of at a settlement taxidermist
				]
			});
		}

		return result;
	}
});