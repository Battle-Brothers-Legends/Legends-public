::mods_hookExactClass("ui/screens/tactical/modules/topbar/tactical_screen_topbar_round_information", function(o) {

	local update = o.update;
	o.update = function (){
		update();
		this.updateSpeedButtons(::Const.Tactical.Settings.AnimationSpeed);
	}

	o.onSpeedButtonClicked <- function(_speed) {
        ::Tactical.State.setTacticalSpeed(_speed);
    }

	o.updateSpeedButtons <- function (_speed){
		this.m.JSHandle.asyncCall("updateSpeedButtons", _speed);
	}
});
