this.legend_witch_being_burned_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_witch_being_burned";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.witch_being_burned";
    }
})
