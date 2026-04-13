this.legend_rune_blazing_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRswBlazing;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_blazing";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
