this.legend_rune_defense_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRssDefense;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_defense";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
