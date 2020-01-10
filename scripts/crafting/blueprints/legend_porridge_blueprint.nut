this.legend_porridge_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_porridge";
		this.m.Type = this.Const.Items.ItemType.Food;
		this.m.PreviewCraftable = this.new("scripts/items/supplies/legend_porridge_item");
		this.m.Cost = 10;
		local ingredients = [
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/legend_cooking_spices_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/ground_grains_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_camp_cook"]
			}
		]
		this.initSkills(skills);		

	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/legend_porridge_item"));
	}

});

