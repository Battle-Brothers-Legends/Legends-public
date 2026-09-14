this.legend_melon_thief_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_melon_thief";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.melon_thief";
    }
})
