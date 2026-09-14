this.legend_beggar_begs_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_beggar_begs_camp";
        this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Event = "event.beggar_begs";
    }
})
