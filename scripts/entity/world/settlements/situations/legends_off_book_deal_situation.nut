this.legends_off_book_deal_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {
		Stacks = 1,	// 1 Stack = 1 Brother with 'Off-Book-Deal' perk
		BuyPriceMultPerStack = 0.1,
		RarityMultPerStack = 0.1
	},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.legends.off_book_deal";
		this.m.Name = "Off-Book Deal";
		this.m.Description = "Your peddler went around and talked every merchant into revealing their exotic goods. This obvious demand shown by your company has also led to an increase in all prices.";
		this.m.Icon = "ui/perks/perk_20.png";
		this.m.Rumors = [];
		this.m.IsStacking = false;
	}

	function setStacks( _stacks )	// sets how many brothers with this perk exist in the party
	{
		this.m.Stacks = _stacks;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.0 + (this.m.Stacks * this.m.BuyPriceMultPerStack);
		_modifiers.RarityMult *= 1.0 + (this.m.Stacks * this.m.RarityMultPerStack);
	}
});

