this.legend_sack_hood_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_sack_hood_blueprint";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/vanity/legend_helmet_sack");
		this.m.Cost = 75;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			::Legends.Perks.blueprint(::Legends.Perk.LegendSpecCultHood)
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_helmets/vanity/legend_helmet_sack");
		_stash.add(item);
		item = this.new("scripts/items/legend_helmets/vanity/legend_helmet_sack");
		_stash.add(item);
		item = this.new("scripts/items/legend_helmets/vanity/legend_helmet_sack");
		_stash.add(item);
	}
});
