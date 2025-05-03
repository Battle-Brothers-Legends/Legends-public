this.legend_belly_dancer_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.belly_dancer_encounter";
        this.m.Name = "Dancing Woman";
		this.m.Event = "event.belly_dancer_event";
    }
})
