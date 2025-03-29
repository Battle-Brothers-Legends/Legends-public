this.legend_food_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.Type = this.Const.Items.ItemType.Food;
		this.m.Cost = 40;
		this.m.CraftMultiplier = 0.3;
	}
});