this.legend_surefooted_saves_damsel_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_surefooted_saves_damsel";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.surefooted_saves_damsel";
    }
})
