this.legend_uncut_gems_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_uncut_gems";
		this.m.PreviewCraftable = this.new("scripts/items/trade/uncut_gems_item");
		this.m.Cost = 500;
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.Enchanter = true;
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_gem_shards_item",
				Num = 5
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/legend_vala_background"]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/trade/uncut_gems_item"));
	}

});

