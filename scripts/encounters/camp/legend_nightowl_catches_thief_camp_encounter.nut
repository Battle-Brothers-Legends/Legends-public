this.legend_nightowl_catches_thief_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_nightowl_catches_thief_camp";
        this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Event = "event.nightowl_catches_thief";
	}
})
