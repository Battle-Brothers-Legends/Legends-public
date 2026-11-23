this.root_state <- this.inherit("scripts/states/state", {
	m = {},
	function onInit()
	{
		local globalTable = this.getroottable();
		globalTable.Root <- this;
		globalTable.LoadingScreen <- this.new("scripts/ui/screens/loading/loading_screen");
		globalTable.TooltipScreen <- this.new("scripts/ui/screens/tooltip/tooltip_screen");
		globalTable.UIDataHelper <- this.new("scripts/ui/global/data_helper");
		globalTable.Cursor <- this.new("scripts/ui/global/cursor");
		globalTable.MapGen <- this.new("scripts/mapgen/map_generator");
		globalTable.DialogScreen <- this.new("scripts/ui/screens/dialog_screen");
		::mods_callHook("root_state.onInit", this);
		this.add("MainMenuState", "scripts/states/main_menu_state");
	}

});

