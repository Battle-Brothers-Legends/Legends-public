::mods_hookExactClass("entity/world/settlements/situations/public_executions_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.025);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList, _gender = null)
	{
		// _draftList.push("legend_executioner_background"); to be added
	}
});
