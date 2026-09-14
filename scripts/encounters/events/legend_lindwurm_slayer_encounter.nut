this.legend_lindwurm_slayer_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_lindwurm_slayer_encounter";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.crisis.lindwurm_slayer";
	}

    function isValid(_settlement) {
		if (!_settlement.hasBuilding("building.tavern"))
			return false;
		return this.encounter_event.isValid(_settlement);
    }
});
