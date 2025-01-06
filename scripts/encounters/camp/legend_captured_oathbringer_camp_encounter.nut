this.legend_captured_oathbringer_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_captured_oathbringer_camp_encounter";
        this.m.Name = "Captured Oathbringer";
		this.m.Event = "event.captured_oathbringer";
    }
})
