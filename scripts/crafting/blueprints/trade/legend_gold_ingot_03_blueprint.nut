this.legend_gold_ingot_03_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_gold_ingot_03";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/trade/legend_gold_ingots_item");
		this.m.Cost = 3600;
		local ingredients = [
			{
				Script = "scripts/items/loot/golden_chalice_item",
				Num = 2
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
		_stash.add(this.new("scripts/items/trade/legend_gold_ingots_item"));
	}

});

