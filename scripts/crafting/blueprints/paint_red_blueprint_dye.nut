this.paint_red_blueprint_dye <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.paint_red_dye";
		this.m.PreviewCraftable = this.new("scripts/items/misc/paint_red_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/trade/dies_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/paint_red_item"));
	}

});

