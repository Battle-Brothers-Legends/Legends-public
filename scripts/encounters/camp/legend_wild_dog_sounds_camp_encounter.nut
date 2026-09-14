this.legend_wild_dog_sounds_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_wild_dog_sounds_camp";
        this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Event = "event.wild_dog_sounds";
	}
})
