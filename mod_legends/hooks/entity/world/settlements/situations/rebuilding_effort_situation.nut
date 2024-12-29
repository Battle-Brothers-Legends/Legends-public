::mods_hookExactClass("entity/world/settlements/situations/rebuilding_effort_situation", function(o)
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
		if (this.m.IsSouthern) { // Necro: "this.m.IsSouthern" is always false, i don't get how this would work
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");

		}
		else {
			_draftList.push("lumberjack_background");
			_draftList.push("lumberjack_background");
			_draftList.push("mason_background");
			_draftList.push("mason_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
			_draftList.push("legend_inventor_background");
		}

		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
	}
});
