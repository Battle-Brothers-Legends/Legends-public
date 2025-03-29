::mods_hookExactClass("entity/world/settlements/situations/mustering_troops_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.01);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push("retired_soldier_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");

		if (this.World.Assets.getOrigin().getID() == "scenario.militia") {
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}

	}
});
