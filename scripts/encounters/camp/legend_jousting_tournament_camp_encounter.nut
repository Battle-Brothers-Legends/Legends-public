this.legend_jousting_tournament_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_jousting_tournament_camp_encounter";
        this.m.Name = "jousting_tournament_camp_encounter";
		this.m.Event = "event.jousting_tournament_event";
	}
})
