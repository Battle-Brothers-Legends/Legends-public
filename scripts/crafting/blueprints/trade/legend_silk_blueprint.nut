this.legend_silk_blueprint <- this.inherit("scripts/crafting/legend_trading_good_blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
		this.m.ID = "blueprint.legend_silk";
		this.m.Type = ::Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/trade/silk_item");
		this.m.Cost = 180;
		this.m.ItemScript = "scripts/items/trade/silk_item";
		local ingredients = [
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 6
			},
		];
		this.init(ingredients);
		this.initSkills([::Legends.Professions.new(::Legends.Profession.LegendTailoring)]);
	}

});
