this.legend_rune_durability_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRssDurability;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_durability";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
