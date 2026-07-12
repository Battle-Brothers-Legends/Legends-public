this.legend_sipar_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_sipar_shield";
		this.m.Type = this.Const.Items.ItemType.Shield;
		this.m.PreviewCraftable = this.new("scripts/items/shields/oriental/metal_round_shield");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_iron_ingots_item",
				Num = 2
			}
		];
		this.init(ingredients);
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendMetalworking)]);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/shields/oriental/metal_round_shield");
		_stash.add(item);
	}

});

