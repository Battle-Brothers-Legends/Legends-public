this.legend_fav_enemy_swordmaster_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_fav_enemy_swordmaster_encounter";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.legend_swordmaster_fav_enemy";
    }
})
