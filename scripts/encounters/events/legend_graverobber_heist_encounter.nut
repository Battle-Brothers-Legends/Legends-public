this.legend_graverobber_heist_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_graverobber_heist";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.graverobber_heist";
    }
})
