this.legend_heartwood_sap_flask_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_heartwood_sap_flask";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_heartwood_sap_flask_item");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_ancient_green_wood_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/glowing_resin_item",
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
		_stash.add(this.new("scripts/items/accessory/legend_heartwood_sap_flask_item"));
	}

});

