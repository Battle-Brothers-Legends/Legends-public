this.legend_creepy_guy_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_creepy_guy";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.creepy_guy";
    }
})
