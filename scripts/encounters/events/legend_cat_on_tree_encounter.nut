this.legend_cat_on_tree_encounter <- this.inherit("scripts/encounters/encounter_event", {
    m = {},
    function create() {
        this.m.Type = "encounter.legend_cat_on_tree";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Event = "event.cat_on_tree";
    }
})
