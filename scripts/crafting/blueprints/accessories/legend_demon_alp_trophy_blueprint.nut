this.legend_demon_alp_trophy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_demon_alp_trophy";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_demonalp_trophy_item");
		this.m.Cost = 3000;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_demon_alp_skin_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_demon_third_eye_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/petrified_scream_item",
				Num = 2
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
		_stash.add(this.new("scripts/items/accessory/legend_demonalp_trophy_item"));
	}

});

