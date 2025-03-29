::mods_hookExactClass("entity/world/settlements/situations/arena_tournament_situation", function(o)
{
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
