this.legend_gold_ingot_01_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_gold_ingot_01";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/trade/legend_gold_ingots_item");
		this.m.Cost = 3600;
		local ingredients = [
			{
				Script = "scripts/items/loot/ancient_gold_coins_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Backgrounds.new(::Legends.Background.LegendBlacksmith)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/trade/legend_gold_ingots_item"));
	}

});

