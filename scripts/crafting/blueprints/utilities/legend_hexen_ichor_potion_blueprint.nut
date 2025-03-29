this.legend_hexen_ichor_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_hexen_ichor_potion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_hexen_ichor_potion_item");
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_witch_leader_hair_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/poisoned_apple_item",
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
		_stash.add(this.new("scripts/items/accessory/legend_hexen_ichor_potion_item"));
	}

});

