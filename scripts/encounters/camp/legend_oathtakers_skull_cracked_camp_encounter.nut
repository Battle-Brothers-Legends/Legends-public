this.legend_oathtakers_skull_cracked_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_oathtakers_skull_cracked_camp_encounter";
        this.m.Name = "oathtakers_skull_cracked_camp_encounter";
		this.m.Event = "event.oathtakers_skull_cracked";
	}
})
