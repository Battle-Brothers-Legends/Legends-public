this.legend_smoked_ham_02_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.legend_smoked_ham_02";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/smoked_ham_item");
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/legend_boar_meat_item",
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
		_stash.add(this.new("scripts/items/supplies/smoked_ham_item"));
	}

});
