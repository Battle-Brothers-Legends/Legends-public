this.encounter_event <- this.inherit("scripts/encounters/encounter", {
	/** Base convenience class for encounters that fire event. */
	m = {
		Event = null
	}

	function isVisible() {
		// there's some bug that crashes it in 1st day when you don't have ambition
		// this is supposed to be temporary fix i think...
		return ::World.Ambitions.hasActiveAmbition() || ::World.getTime().Time >= ::World.getTime().SecondsPerDay * 5
	}

	function isValid(_settlement) {
		local event = ::World.Events.getEvent(this.m.Event);
		if (event == null) {
			return false;
		}
		event.m.Score = 0;
		event.onUpdateScore();
		return event.m.isValidForEncounter;
	}
});
