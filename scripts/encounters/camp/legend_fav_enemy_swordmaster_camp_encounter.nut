this.legend_fav_enemy_swordmaster_camp_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_fav_enemy_swordmaster_camp_encounter";
        this.m.Name = "fav_enemy_swordmaster_camp_encounter";
		this.m.Event = "event.legend_swordmaster_fav_enemy";
	}
})
