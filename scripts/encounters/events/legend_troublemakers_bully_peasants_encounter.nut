this.legend_troublemakers_bully_peasants_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_troublemakers_bully_peasants";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.troublemakers_bully_peasants";
    }
})
