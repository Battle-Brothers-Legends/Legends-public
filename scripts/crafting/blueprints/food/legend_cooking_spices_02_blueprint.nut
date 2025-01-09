this.legend_cooking_spices_02_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.legend_cooking_spices_02";
		this.m.Type = this.Const.Items.ItemType.TradeGood | this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/trade/legend_cooking_spices_trade_item");
		local ingredients = [
			{
				Script = "scripts/items/trade/spices_item",
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
		_stash.add(this.new("scripts/items/trade/legend_cooking_spices_trade_item"));
	}

});

