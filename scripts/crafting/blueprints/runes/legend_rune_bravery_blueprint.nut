this.legend_rune_bravery_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRshBravery;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_bravery";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
