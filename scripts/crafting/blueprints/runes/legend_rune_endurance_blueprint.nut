this.legend_rune_endurance_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRsaEndurance;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_endurance";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
