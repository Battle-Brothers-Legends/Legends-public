this.legend_yummy_sausages_03_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.yummy_sausages_03";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/legend_yummy_sausages");
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/strange_meat_item",
				Num = 3
			}
		];
		this.init(ingredients);
		this.initSkills([
			::Legends.Professions.new(::Legends.Profession.LegendMealPreparation),
			::Legends.Traits.new(::Legends.Trait.LegendCannibalistic)
		]);
	}

	function onCraft(_stash) {
		_stash.add(this.new("scripts/items/supplies/legend_yummy_sausages"));
	}

});
