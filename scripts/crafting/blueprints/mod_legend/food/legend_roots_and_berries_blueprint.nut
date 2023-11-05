this.legend_roots_and_berries_blueprint <- this.inherit("scripts/crafting/food_blueprint", {
	m = {},
	function create()
	{
		this.food_blueprint.create();
		this.m.ID = "blueprint.legend_roots_and_berries";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/roots_and_berries_item");
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_fresh_roots_and_berries_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_camp_cook"]
			}
		]
		this.initSkills(skills);		
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/roots_and_berries_item"));
	}

});