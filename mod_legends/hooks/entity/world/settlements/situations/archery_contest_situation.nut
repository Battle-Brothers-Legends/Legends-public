::mods_hookExactClass("entity/world/settlements/situations/archery_contest_situation", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");

		// if (_gender)
		// {
		// 	_draftList.push("female_adventurous_noble_background");
		// 	_draftList.push("female_adventurous_noble_background");
		// 	_draftList.push("female_disowned_noble_background");

		// }

		onUpdateDraftList(_draftList);
	}
});
