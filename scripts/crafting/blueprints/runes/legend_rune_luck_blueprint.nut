this.legend_rune_luck_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRshLuck;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_luck";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
