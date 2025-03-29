this.legend_rune_bleeding_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRswBleeding;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_bleeding";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
