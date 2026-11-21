this.legend_rock_unhold_frost <- this.inherit("scripts/entity/tactical/enemies/legend_rock_unhold", {
	m = {},

	function create() {
		this.legend_rock_unhold.create();
		this.m.Biome = "winter";
	}

});
