this.legend_inadvertently_save_merchant_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_inadvertently_save_merchant";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.inadvertently_save_merchant";
    }
})
