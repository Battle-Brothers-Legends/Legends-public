::mods_hookExactClass("ui/screens/world/modules/topbar/world_screen_topbar_options_module", function (o) {

	o.onCampButtonPressed = function () {
		if (!::World.State.m.MenuStack.hasBacksteps()) {
			::World.State.showCampScreen();
		}
	}
});
