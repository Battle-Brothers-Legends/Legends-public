this.encounter_event <- this.inherit("scripts/encounters/encounter", {
	/** Base convenience class for encounters that fire event. */
	m = {
		Event = null,
		OldEvent = null
	}

	function isVisible() {
		// there's some bug that crashes it in 1st day when you don't have ambition
		// this is supposed to be temporary fix i think...
		if (!::World.Events.canFireEvent()) {
			return false;
		}
		return ::World.Ambitions.hasActiveAmbition() || ::World.getTime().Time >= ::World.getTime().SecondsPerDay * 5;
	}

	function isValid(_settlement) {
		if (this.m.OldEvent != null) {
			this.m.Event = this.m.OldEvent;
			this.m.OldEvent = null;
		}
		local event = ::World.Events.getEvent(this.m.Event);
		if (event == null) {
			return false;
		}
		event.clear();
		event.onUpdateScore();
		return event.m.isValidForEncounter;
	}

	// override the event with missed opportunity if it became illegal between spawning and clicking
	function fire() {
		if (!this.isValid(::Legends.S.getClosestSettlement())) {
			this.m.OldEvent = this.m.Event;
			this.m.Event = "event.legend_missed_opportunity";
			return;
		}

		this.encounter.fire();
	}
});
