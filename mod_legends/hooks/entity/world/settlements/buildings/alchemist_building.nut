::mods_hookExactClass("entity/world/settlements/buildings/alchemist_building", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list)
	{
		onUpdateDraftList(_list);
		_list.push("legend_alchemist_background");
		_list.push("legend_alchemist_background");
	}
});
