this.preparing_feast_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.preparing_feast";
		this.m.Name = "Preparing Feast";
		this.m.Description = "The nobles are preparing for a feast. Cook houses and kitchens are buying food in bulk.";
		this.m.Icon = "ui/settlement_status/settlement_effect_29.png";
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
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
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.25;
		_modifiers.FoodPriceMult *= 2.0;
	}

});
