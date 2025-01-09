this.legend_wine_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.legend_wine";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/wine_item");
		local ingredients = [
			{
				Script = "scripts/items/supplies/legend_fresh_fruit_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendAlcoholBrewing)
		];
		this.initSkills(skills);

	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/wine_item"));
	}

});

