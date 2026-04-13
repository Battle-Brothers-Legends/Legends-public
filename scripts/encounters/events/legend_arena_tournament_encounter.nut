this.legend_arena_tournament_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_arena_tournament";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.arena_tournament";
    }
})
