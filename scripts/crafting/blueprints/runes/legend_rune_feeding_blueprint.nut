this.legend_rune_feeding_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRswFeeding;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_feeding";
		this.m.Type = ::Const.Items.ItemType.Misc;
	}

});
