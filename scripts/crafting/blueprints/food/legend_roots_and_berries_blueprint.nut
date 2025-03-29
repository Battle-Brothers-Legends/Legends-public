this.legend_roots_and_berries_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.legend_roots_and_berries";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/roots_and_berries_item");
		local ingredients = [
			{
				Script = "scripts/items/supplies/legend_fresh_roots_and_berries_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendCampCook)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/roots_and_berries_item"));
	}

});
