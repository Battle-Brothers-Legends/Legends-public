this.legend_volunteers_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_volunteers_camp_encounter";
        this.m.Name = "Volunteers";
		this.m.Event = "event.volunteers";
	}
})
