::mods_hookExactClass("entity/world/settlements/buildings/alchemist_building", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.UIImage = "ui/settlements/southern_kennel";
		this.m.UIImageNight = "ui/settlements/southern_kennel";
	}
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _list)
	{
		onUpdateDraftList(_list);
		_list.push("legend_alchemist_background");
		_list.push("legend_alchemist_background");
	}
});
