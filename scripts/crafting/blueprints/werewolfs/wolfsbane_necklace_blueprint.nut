this.wolfsbane_necklace_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.wolfsbane_necklace";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_wolfsbane_necklace_item");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_wolfsbane_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_wolfsbane_necklace_item"));
	}

	function isValid()
	{
		return false;
	}

});