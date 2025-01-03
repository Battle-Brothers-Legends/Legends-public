::mods_hookExactClass("entity/world/settlements/situations/hunting_season_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.02);
		}
		onAdded( _settlement );
	}

	o.onUpdateDraftList <- function ( _draftList )
	{
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("legend_taxidermist_background");
		_draftList.push("legend_taxidermist_background");
		_draftList.push("houndmaster_background");
		_draftList.push("houndmaster_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
	}
});
