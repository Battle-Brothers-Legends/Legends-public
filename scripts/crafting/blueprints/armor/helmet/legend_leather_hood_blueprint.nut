this.legend_leather_hood_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_leather_hood_blueprint";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/top/legend_helmet_cult_hood");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 2
			}
		];
		this.init(ingredients);
		this.initSkills([
			::Legends.Perks.new(::Legends.Perk.LegendSpecCultHood),
			::Legends.Professions.new(::Legends.Profession.LegendLeatherworking)
		]);
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_helmets/top/legend_helmet_cult_hood");
		_stash.add(item);
		item = this.new("scripts/items/legend_helmets/top/legend_helmet_cult_hood");
		_stash.add(item);
	}

});

