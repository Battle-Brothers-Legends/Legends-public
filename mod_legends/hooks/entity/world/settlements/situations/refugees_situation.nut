::mods_hookExactClass("entity/world/settlements/situations/refugees_situation", function(o)
{
	local onAdded = o.onAdded;
	o.onAdded = function ( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.1);
		
		onAdded( _settlement );
	}

	o.onUpdateDraftList = function ( _draftList )
	{
		for (local i = 0; i < 30; ++i)
		{
			_draftList.push("refugee_background");
		}
		
		_draftList.push("slave_background");
		_draftList.push("beggar_background");
	}
});
