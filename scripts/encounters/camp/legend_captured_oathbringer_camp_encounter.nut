this.legend_captured_oathbringer_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_captured_oathbringer_camp";
        this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Event = "event.captured_oathbringer";
    }
})
