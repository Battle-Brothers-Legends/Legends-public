this.legend_rune_clarity_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRshClarity;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_clarity";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
