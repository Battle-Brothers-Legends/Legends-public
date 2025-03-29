::mods_hookExactClass("entity/world/settlements/situations/full_nets_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		for (local i = 0; i < 6; ++i)
		{
			_draftList.push("fisherman_background");
		}
	}
});
