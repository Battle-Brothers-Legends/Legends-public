foreach(event in [
	"anatomist_creeps_out_locals_event",
	"captured_oathbringer_event",
	"lindwurm_slayer_event",
	"oathtakers_skull_cracked_event",
	"strange_scribe_event",
	"volunteers_event"
]) {
	::mods_hookExactClass("events/events/dlc8/" + event, function(o) {
		o.m.isValidForEncounter <- false;

		local onUpdateScore = o.onUpdateScore;
		o.onUpdateScore = function() {
			onUpdateScore();
			this.m.isValidForEncounter = this.m.Score > 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil;
			this.m.Score = 0; // this disables event from happening normally
		}
	})
}
