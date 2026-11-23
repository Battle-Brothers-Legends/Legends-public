this.legend_silver_ingot_05_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_silver_ingot_05";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/trade/legend_silver_ingots_item");
		this.m.Cost = 900;
		local ingredients = [
			{
				Script = "scripts/items/loot/goblin_minted_coins_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/silver_bowl_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/backgrounds/legend_blacksmith_background"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/trade/legend_silver_ingots_item"));
	}

});

