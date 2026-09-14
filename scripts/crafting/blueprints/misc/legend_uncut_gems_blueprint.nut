this.legend_uncut_gems_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_uncut_gems";
		this.m.PreviewCraftable = this.new("scripts/items/trade/uncut_gems_item");
		this.m.Cost = 500;
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.BlueprintType = "Enchanting";
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_gem_shards_item",
				Num = 5
			}
		];
		this.init(ingredients);
		this.initSkills([::Legends.Backgrounds.new(::Legends.Background.LegendVala)]);
	}

	function onCraft(_stash) {
		_stash.add(this.new("scripts/items/trade/uncut_gems_item"));
	}

});
