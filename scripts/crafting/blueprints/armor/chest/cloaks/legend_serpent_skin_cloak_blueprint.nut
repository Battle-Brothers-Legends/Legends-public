this.legend_serpent_skin_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_serpent_skin_cloak";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/cloak/legend_serpent_skin_cloak");

		this.m.Cost = 300;
		local ingredients = [
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/cloak/legend_serpent_skin_cloak"));
	}
});

