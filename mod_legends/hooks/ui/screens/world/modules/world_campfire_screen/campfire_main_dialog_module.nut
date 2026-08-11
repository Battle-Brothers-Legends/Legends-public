::mods_hookExactClass("ui/screens/world/modules/world_campfire_screen/campfire_main_dialog_module", function(o) {
	local queryData = o.queryData;
	o.queryData = function() {
		local ret = queryData();
		ret.Title = "Camping Tools";
		ret.SubTitle = "Manage your camping tools";
		return ret;
	}
});
