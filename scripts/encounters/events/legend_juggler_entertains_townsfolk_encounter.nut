this.legend_juggler_entertains_townsfolk_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_juggler_entertains_townsfolk";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.juggler_entertains_townsfolk";
    }
})
