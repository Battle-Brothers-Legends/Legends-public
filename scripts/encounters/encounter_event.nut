this.encounter_event <- this.inherit("scripts/encounters/encounter", {
	/** Base convenience class for encounters that fire event. */
	m = {
		Event = null,
		OldEvent = null
	}

	function isVisible() {
		// there's some bug that crashes it in 1st day when you don't have ambition
		// this is supposed to be temporary fix i think...
		return ::World.Ambitions.hasActiveAmbition() || ::World.getTime().Time >= ::World.getTime().SecondsPerDay * 5;
	}

	function isValid(_settlement, _forceUpdate = false) {
		if (this.m.OldEvent != null) {
			this.m.Event = this.m.OldEvent;
			this.m.OldEvent = null;
		}
		local event = ::World.Events.getEvent(this.m.Event);
		if (event == null) {
			return false;
		}
        if ((::World.Encounters.m.ActiveEvent == null && ::World.Encounters.m.ActiveCampEvent == null) || _forceUpdate) {
            event.clear();
            event.onUpdateScore();
        }
		return event.m.isValidForEncounter;
	}

	// override the event with missed opportunity if it became illegal between spawning and clicking
	function fire() {
		if (!this.isValid(::Legends.S.getClosestSettlement(), true)) {
			this.m.OldEvent = this.m.Event;
			this.m.Event = "event.legend_missed_opportunity";
            this.getEncounterEvent().fire();
			return;
		}

		local event = this.getEncounterEvent();
        if (event != null) {
            event.fire();
        }

        this.m.CooldownUntil = this.Time.getVirtualTimeF() + this.m.Cooldown;
	}

	function getEncounterEvent() {
        return ::World.Events.getEvent(this.m.Event);
    }

	function getUITitle() {
        return this.getEncounterEvent().getUITitle();
    }

    function getUIButtons() {
        return this.getEncounterEvent().getUIButtons();
    }

    function getUIContent() {
        return this.getEncounterEvent().getUIContent();
    }

    function getUIList() {
        return this.getEncounterEvent().getUIList();
    }

    function getUIImage() {
        return this.getEncounterEvent().getUIImage();
    }

    function getUICharacterImage( _index = 0 ) {
        return this.getEncounterEvent().getUICharacterImage(_index);
    }

    function getUIMiddleOverlay() {
        return this.getEncounterEvent().getUIMiddleOverlay();
    }

    function hasBigButtons() {
        return this.getEncounterEvent().hasBigButtons();
    }

    function processInput( _option ) {
        return this.getEncounterEvent().processInput(_option);
    }

    function clear() {
        local event = this.getEncounterEvent();
        if (event != null) {
            event.clear();
        }
        this.onClear();
    }
});
