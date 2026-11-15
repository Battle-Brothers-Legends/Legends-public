::mods_hookExactClass("ui/screens/tactical/modules/topbar/tactical_screen_topbar_round_information", function(o) {

	local update = o.update;
	o.update = function (){
		update();
		// a new battle starts at normal speed, this brings back the speed picked in the last one
		if (::Legends.S.isNull(::Tactical.State)) {
			this.updateSpeedButtons(::Const.Tactical.Settings.AnimationSpeed);
		} else {
			::Tactical.State.setTacticalSpeed(::Const.Tactical.Settings.AnimationSpeed);
		}
	}

	o.onSpeedButtonClicked <- function(_speed) {
        ::Tactical.State.setTacticalSpeed(_speed);
    }

	o.updateSpeedButtons <- function (_speed){
		this.m.JSHandle.asyncCall("updateSpeedButtons", _speed);
	}
});
