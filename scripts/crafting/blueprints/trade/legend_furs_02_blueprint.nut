this.legend_furs_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_furs_02";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/trade/furs_item");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/misc/hyena_fur_item",
				Num = 3
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/backgrounds/legend_taxidermist_background"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/trade/furs_item"));
	}

});

