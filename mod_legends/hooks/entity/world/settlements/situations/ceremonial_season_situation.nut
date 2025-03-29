::mods_hookExactClass("entity/world/settlements/situations/ceremonial_season_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.01);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push("monk_background");
		_draftList.push("monk_background");
		_draftList.push("cultist_background");
		_draftList.push("flagellant_background");

		if ( this.World.Assets.getOrigin().getID() == "scenario.cultists") {
			_draftList.push("legend_husk_background");
			_draftList.push("legend_husk_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_lurker_background");
			_draftList.push("legend_magister_background");
		}
		else if ( this.World.Assets.getOrigin().getID() == "scenario.legends_crusader") {
			for (local i = 0; i < 17; ++i)
			{
				_draftList.push("legend_pilgrim_background");
			}
		}
	}
});
