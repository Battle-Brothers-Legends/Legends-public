::mods_hookExactClass("entity/world/settlements/situations/ambushed_trade_routes_situation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "The roads leading here are unsafe of late, and many a caravan has been ambushed and plundered. With little successful trade, the selection of goods is lower and the prices higher. Former traders and caravan hands may be looking for new jobs. Upon resolution this will refresh the hiring roster in town.";
	}

	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		onAdded( _settlement );

		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);

		if (::Math.rand(1,10)==1)
			_settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_militant_townsfolk_situation"), this.getDefaultDays() + ::Math.rand(1,3));
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _modifiers )
	{
		onUpdate(_modifiers);
		_modifiers.SellPriceMult *= 1.2 / 1.1;
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		if  (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro") {
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("thief_background");
		_draftList.push("thief_background");
	}
});
