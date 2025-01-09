this.legend_cured_rations_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.legend_cured_rations";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/legend_cured_rations_item");
		local ingredients = [
			{
				Script = "scripts/items/supplies/dried_fruits_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/cured_venison_item",
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
		_stash.add(this.new("scripts/items/supplies/legend_cured_rations_item"));
	}

});

