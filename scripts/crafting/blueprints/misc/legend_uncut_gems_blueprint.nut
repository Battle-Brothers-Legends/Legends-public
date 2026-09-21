this.legend_uncut_gems_blueprint <- this.inherit("scripts/crafting/legend_trading_good_blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_uncut_gems";
		this.m.PreviewCraftable = this.new("scripts/items/trade/uncut_gems_item");
		this.m.Cost = 500;
		this.m.Type = ::Const.Items.ItemType.Usable;
		this.m.ItemScript = "scripts/items/trade/uncut_gems_item";
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

});
