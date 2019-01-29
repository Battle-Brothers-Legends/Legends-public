this.well_supplied_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.well_supplied";
		this.m.Name = "Well Supplied";
		this.m.Description = "This place has been recently supplied with fresh wares, and many of those can now be bought for the right price.";
		this.m.Icon = "ui/settlement_status/settlement_effect_03.png";
		this.m.IsStacking = false;
	}

	function getAddedString( _s )
	{
		return _s + " now is " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer is " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.removeSituationByID("situation.ambushed_trade_routes");
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.PriceMult *= 0.899999976;
		_modifiers.RarityMult *= 1.14999998;
	}

});
