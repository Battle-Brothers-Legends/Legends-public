this.legend_eunuch_ladies_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_eunuch_ladies";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.eunuch_ladies";
    }
})
