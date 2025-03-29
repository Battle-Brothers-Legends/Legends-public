this.legend_pack_large_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_pack_large";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_pack_large");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_pack_large"));
	}

});
