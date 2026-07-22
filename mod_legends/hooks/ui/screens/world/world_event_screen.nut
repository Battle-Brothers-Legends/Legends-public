::mods_hookExactClass("ui/screens/world/world_event_screen", function(o) {
	/** Adds variable to the event screen controller, that indicates encounter*/
	o.m.IsEncounter <- false;

	/** Setter */
	o.setIsEncounter <- function ( _c ) {
		this.m.IsEncounter = _c;
	}

	/**
	 * Reroutes input handler for encounter to proper manager
	 */
	local onButtonPressed = o.onButtonPressed;
	o.onButtonPressed = function (_buttonID) {
		if (this.m.IsEncounter) {
			this.World.Encounters.processInput(_buttonID);
		} else {
			onButtonPressed(_buttonID);
		}
	}

	local hide = o.hide;
	o.hide = function(_withSlideAnimation = false) {
		hide(_withSlideAnimation);
		if (::Legends.Mod.ModSettings.getSetting("PauseOnEvents").getValue() && !::World.State.isInLoadingScreen()){
			::World.State.setPause(true);
		}
	}
});
