::mods_hookExactClass("ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function(o) {
	o.m.IsAutoUpdateTimeButtonState <- false;

	local showMessage = o.showMessage;
	o.showMessage = function( _primary, _secondary )
	{
		if (_primary == "ENCAMPED" && _secondary.len() == 0)
			_secondary = [];
		else if (_primary == "PAUSED" && _secondary == "(Press Spacebar)") {
			_secondary = [_secondary];
			if (::World.Camp.isCamping()) {
				_secondary.extend(::World.Camp.getLastCampingUpdateText());
				_primary = "ENCAMPED\n(PAUSED)";
			}
		}

		showMessage(_primary, _secondary);
	}

	local updateTimeButtons = o.updateTimeButtons;
	o.updateTimeButtons = function ( _state )
	{
		if (m.IsAutoUpdateTimeButtonState) {
			if (::World.State.m.IsGamePaused)
				_state = 0;
			else if (::World.getSpeedMult() == 1.0)
				_state = 1;
			else if (::World.getSpeedMult() == 4.0)
				_state = 3;
			else if (::World.getSpeedMult() == 8.0)
				_state = 4;
			else
				_state = 2;
		}

		updateTimeButtons(_state);
	}

});
