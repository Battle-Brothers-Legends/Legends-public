this.legend_anatomist_creeps_out_locals_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_anatomist_creeps_out_locals_encounter";
        this.m.Name = "anatomist_creeps_out_locals_encounter";
		this.m.Event = "event.event.anatomist_creeps_out_locals";
    }
})
