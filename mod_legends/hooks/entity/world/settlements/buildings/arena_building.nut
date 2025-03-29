::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list)
	{
		onUpdateDraftList(_list);
		_list.push("legend_gladiator_prizefighter_background");
		_list.push("legend_gladiator_prizefighter_background");
	}
});
