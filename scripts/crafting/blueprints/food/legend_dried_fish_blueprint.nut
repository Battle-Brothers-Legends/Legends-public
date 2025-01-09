this.legend_dried_fish_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.legend_dried_fish";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/dried_fish_item");
		local ingredients = [
			{
				Script = "scripts/items/supplies/legend_fresh_fish_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
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
		_stash.add(this.new("scripts/items/supplies/dried_fish_item"));
	}

});

