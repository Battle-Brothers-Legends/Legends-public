this.legend_strange_scribe_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_strange_scribe_encounter";
        this.m.Name = "strange_scribe_encounter";
		this.m.Event = "event.strange_scribe";
    }
})
