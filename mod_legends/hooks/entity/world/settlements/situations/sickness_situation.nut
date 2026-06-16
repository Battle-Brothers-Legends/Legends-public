::mods_hookExactClass("entity/world/settlements/situations/sickness_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.05);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Cripple);
		_draftList.push(::Legends.Background.Beggar);
		_draftList.push(::Legends.Background.Beggar);
		_draftList.push(::Legends.Background.Monk);
		_draftList.push(::Legends.Background.LegendHerbalist);
		
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro" || this.World.Assets.getOrigin().getID() == "scenario.legends_solo_necro") {
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
			_draftList.push(::Legends.Background.LegendPuppet);
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
			_draftList.push(::Legends.Background.LegendLeechPeddler);
		}
	}
});
