this.legend_master_no_use_apprentice_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},//very eloquent naming
    function create() {
        this.m.Type = "encounter.legend_master_no_use_apprentice";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.master_no_use_apprentice";
    }
})
