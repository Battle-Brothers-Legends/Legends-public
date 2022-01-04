this.paint_orange_red_blueprint_dye <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.paint_orange_red_dye";
		this.m.Type = this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/misc/paint_orange_red_item");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/trade/dies_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/paint_orange_red_item"));
	}

		function isQualified()
	{
		return (!this.LegendsMod.Configs().LegendArmorsEnabled()) && this.blueprint.isQualified();
	}

});

