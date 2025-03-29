this.legend_arena_tournament_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.createScreens();
        this.m.Type = "encounter.legend_arena_tournament_encounter";
        this.m.Name = "Arena tournament";
		this.m.Event = "event.arena_tournament";
    }
})
