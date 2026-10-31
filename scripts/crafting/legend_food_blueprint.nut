this.legend_food_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.Type = ::Const.Items.ItemType.Food; //tbd
		this.m.CraftMultiplier = 0.3;
	}
});
