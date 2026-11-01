this.legend_food_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.CraftMultiplier = 0.3;
	}
});
