this.legend_basilisk_trophy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_basilisk_trophy";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_basilisk_trophy_item"); 
		this.m.Cost = 1500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_basilisk_eye_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_basilisk_feathers_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_basilisk_trophy_item"));
	}

});

