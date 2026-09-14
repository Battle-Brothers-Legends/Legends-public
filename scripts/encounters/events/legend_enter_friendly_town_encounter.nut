this.legend_enter_friendly_town_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_enter_friendly_town";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.enter_friendly_town";
    }
})
