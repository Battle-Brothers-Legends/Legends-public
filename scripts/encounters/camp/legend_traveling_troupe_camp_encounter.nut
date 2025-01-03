this.legend_traveling_troupe_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_traveling_troupe_camp_encounter";
        this.m.Name = "traveling_troupe_camp_encounter";
		this.m.Event = "event.traveling_troupe";
	}
})
