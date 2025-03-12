this.legend_rune_power_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRswPower;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_power";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
