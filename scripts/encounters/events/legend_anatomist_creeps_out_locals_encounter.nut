this.legend_anatomist_creeps_out_locals_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_anatomist_creeps_out_locals_encounter";
        this.m.Name = "Anatomist creeps locals";
		this.m.Event = "event.anatomist_creeps_out_locals";
    }
})
