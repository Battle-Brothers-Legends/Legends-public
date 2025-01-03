::mods_hookExactClass("entity/world/settlements/buildings/temple_oriental_building", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		_draftList.push("legend_dervish_background");
		onUpdateDraftList(_draftList);
	}
});
