::mods_hookExactClass("entity/world/settlements/situations/bread_and_games_situation", function(o)
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

	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		onUpdateDraftList(_draftList);
		_draftList.push("legend_gladiator_prizefighter_background");
		_draftList.push("legend_gladiator_prizefighter_background");
		_draftList.push("legend_gladiator_prizefighter_background");
		_draftList.push("legend_gladiator_prizefighter_background");
	}

});
