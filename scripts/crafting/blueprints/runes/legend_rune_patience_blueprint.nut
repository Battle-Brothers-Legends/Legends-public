this.legend_rune_patience_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRshPatience;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_patience";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
