::mods_hookExactClass("ui/screens/world/modules/topbar/world_screen_topbar_ambition_module", function (o) {
	local onCancelAmbition = o.onCancelAmbition;
	o.onCancelAmbition = function () {
		onCancelAmbition();
		::World.State.setPause(false);
	}
});
