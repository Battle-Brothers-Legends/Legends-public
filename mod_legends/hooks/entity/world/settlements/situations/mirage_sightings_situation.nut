::mods_hookExactClass("entity/world/settlements/situations/mirage_sightings_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		
		onAdded( _settlement );
	}

	o.onResolved <- function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		if ( this.World.Assets.getOrigin().getID() == "scenario.legends_seer" && this.Math.rand(0, 5) == 1)
			_draftList.push("legend_illusionist_background");
		else if (this.Math.rand(0, 9) == 1)
			_draftList.push("legend_illusionist_background");
	}
});
