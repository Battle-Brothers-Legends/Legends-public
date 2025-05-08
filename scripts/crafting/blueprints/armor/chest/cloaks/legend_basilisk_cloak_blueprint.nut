this.legend_basilisk_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_basilisk_cloak";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/cloak/legend_basilisk_cloak");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_basilisk_feathers_item",
				Num = 4
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/cloak/legend_basilisk_cloak"));
	}
});

