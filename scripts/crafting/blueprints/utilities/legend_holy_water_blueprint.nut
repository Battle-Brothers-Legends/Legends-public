this.legend_holy_water_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_holy_water";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/tools/holy_water_item");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/supplies/wine_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_mistletoe_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/holy_water_item"));
	}

});

