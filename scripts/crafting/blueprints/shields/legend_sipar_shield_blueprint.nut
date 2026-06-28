this.legend_sipar_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_sipar_shield";
		this.m.Type = this.Const.Items.ItemType.Shield;
		this.m.PreviewCraftable = this.new("scripts/items/shields/metal_round_shield");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_iron_ingots_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendWoodworking)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/shields/metal_round_shield");
		_stash.add(item);
	}

});

