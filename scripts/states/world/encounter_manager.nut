this.encounter_manager <- {
    m = {
        ActiveEvent = null,
        ActiveCampEvent = null,
        SettlementEncounters = [],
        CampEncounters = []
    },

    function onInit() {
        foreach(i, scriptFile in this.IO.enumerateFiles("scripts/encounters/events")) {
            this.m.SettlementEncounters.push(this.new(scriptFile));
        }
        foreach(i, scriptFile in this.IO.enumerateFiles("scripts/encounters/generic")) {
            this.m.SettlementEncounters.push(this.new(scriptFile));
        }
        foreach(i, scriptFile in this.IO.enumerateFiles("scripts/encounters/situation")) {
            this.m.SettlementEncounters.push(this.new(scriptFile));
        }

        foreach(i, scriptFile in this.IO.enumerateFiles("scripts/encounters/camp")) {
            this.m.CampEncounters.push(this.new(scriptFile));
        }
    }

    function clear() {
	    this.clearActiveEvent();
        foreach(e in this.m.SettlementEncounters) {
            e.clear();
        }
        foreach(e in this.m.CampEncounters) {
            e.clear();
        }
    }

	function clearActiveEvent() {
		if (this.m.ActiveEvent != null)
			this.m.ActiveEvent.clear();
		this.m.ActiveEvent = null;
	}

    function getEncounter(_typeID) {
        foreach (e in this.m.SettlementEncounters) {
            if (e.getType() == _typeID)
                return e;
        }
        foreach (e in this.m.CampEncounters) {
            if (e.getType() == _typeID)
                return e;
        }
        return null;
    }

    /**
     * Encounter click handler
     */
    function processInput(_buttonID) {
        if (this.m.ActiveEvent != null) {
            if (this.m.ActiveEvent.processInput(_buttonID)) {
                this.World.State.getEventScreen().show(this.m.ActiveEvent);
                return false;
            } else {
                this.m.ActiveEvent.clear();
                this.m.ActiveEvent = null;
                this.World.State.getMenuStack().pop(true);
                return true;
            }
        }
        if (this.m.ActiveCampEvent != null) {
            if (this.m.ActiveCampEvent.processInput(_buttonID)) {
                this.World.State.getEventScreen().show(this.m.ActiveCampEvent);
                return false;
            } else {
                this.m.ActiveCampEvent.clear();
                this.m.ActiveCampEvent = null;
                this.World.State.getMenuStack().pop(true);
                return true;
            }
        }
        return false;
    }

    function canFireEvent() {
        if (
            this.World.State.getMenuStack().hasBacksteps() ||
            this.LoadingScreen != null && (this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()) ||
            this.World.State.m.EventScreen.isVisible() ||
            this.World.State.m.EventScreen.isAnimating()
        ) {
            return false;
        }

        if (("State" in this.Tactical) && this.Tactical.State != null) {
            return false;
        }

        if (this.m.ActiveEvent != null) {
            return false;
        }

        if (this.m.ActiveCampEvent != null) {
            return false;
        }

        local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

        foreach(party in parties) {
            if (!party.isAlliedWithPlayer()) {
                return false;
            }
        }
        return true;
    }

    function fire( _id, _update = true )
    {
        if (this.m.ActiveEvent != null && this.m.ActiveEvent.getID() != _id)
        {
            this.logInfo("Failed to fire event - another event with id \'" + this.m.ActiveEvent.getID() + "\' is already queued.");
            return false;
        }

        local event = this.getEvent(_id);

        if (event != null)
        {
            if (_update)
            {
                event.update();
            }

            this.m.ActiveEvent = event;
            this.m.ActiveEvent.fire();

            if (this.World.State.showEventScreen(this.m.ActiveEvent))
            {
                return true;
            }
            else
            {
				this.clearActiveEvent();
                return false;
            }
        } else {
            this.logInfo("Failed to fire event - with id \'" + _id + "\' not found.");
            return false;
        }
    }

    function fireEncounter(_encounter, _update = true) {
        if (_encounter != null && this.m.ActiveEvent != null && this.m.ActiveEvent.getID() != _encounter.getID()) {
            this.logInfo("Failed to fire event - another event with id \'" + this.m.ActiveEvent.getID() + "\' is already queued.");
            return false;
        }

        this.m.ActiveEvent = _encounter;
        this.m.ActiveEvent.fire();

        ::World.State.showEncounterScreenFromTown(_encounter);
        return true;
    }

    function fireCampEncounter(_encounter, _update = true) {
        if (_encounter != null && this.m.ActiveCampEvent != null && this.m.ActiveCampEvent.getID() != _encounter.getID()) {
            this.logInfo("Failed to fire event - another event with id \'" + this.m.ActiveCampEvent.getID() + "\' is already queued.");
            return false;
        }

        this.m.ActiveCampEvent = _encounter;
        this.m.ActiveCampEvent.fire();

        ::World.State.showEncounterScreenFromCamp(_encounter);
        return true;
    }

    function onSerialize( _out )
    {
        _out.writeU32(this.m.SettlementEncounters.len() + this.m.CampEncounters.len());
        foreach(e in this.m.SettlementEncounters) {
            _out.writeString(e.getType());
            e.onSerialize(_out);
        }
	    foreach(e in this.m.CampEncounters) {
		    _out.writeString(e.getType());
		    e.onSerialize(_out);
	    }
    }

    function onDeserialize( _in )
    {
		local numEncounters = _in.readU32();
		for (local i = 0; i < numEncounters; i++) {
			local e = this.getEncounter(_in.readString());
			if (e != null) {
				e.onDeserialize(_in);
			} else {
				_in.readF32(); // this here has to be the same as encounter's onDeserialize, to skip all stored data
			}
		}
    }
};
