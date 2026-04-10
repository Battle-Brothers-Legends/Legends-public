this.legend_scroll_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_experience_scroll_blueprint";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/legend_scroll_preview_item");
		this.m.Cost = 2000;
		// this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/dies_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendScrollIngredients)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/misc/legend_scroll_item");
		local r = this.Math.rand(0, 100);
		if (r < 50)
			item.m.Selection = 0;
		if (r < 55)
			item.m.Selection = 1;
		if (r < 70)
			item.m.Selection = 2;
		if (r < 85)
			item.m.Selection = 3;
		if (r <= 100)
			item.m.Selection = 4;
		_stash.add(item);
	}

});
