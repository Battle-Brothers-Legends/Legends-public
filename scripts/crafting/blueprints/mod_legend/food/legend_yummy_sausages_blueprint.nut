this.legend_yummy_sausages_blueprint <- this.inherit("scripts/crafting/food_blueprint", {
	m = {},
	function create()
	{
		this.food_blueprint.create();
		this.m.ID = "blueprint.yummy_sausages";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/legend_yummy_sausages");
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/legend_dog_meat_item",
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
		_stash.add(this.new("scripts/items/supplies/legend_yummy_sausages"));
	}

});