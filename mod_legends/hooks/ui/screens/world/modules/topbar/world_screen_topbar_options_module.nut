::mods_hookExactClass("ui/screens/world/modules/topbar/world_screen_topbar_options_module", function(o) {

	o.onCampButtonPressed = function ()
	{
		::World.State.showCampScreen();
	}
});
