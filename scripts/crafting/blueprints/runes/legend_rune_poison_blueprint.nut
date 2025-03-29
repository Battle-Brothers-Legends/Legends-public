this.legend_rune_poison_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},
	function create()
	{
		this.m.Rune = ::Legends.Rune.LegendRswPoison;
		this.legend_rune.create();
		this.m.ID = "blueprint.legend_rune_poison";
		this.m.Type = this.Const.Items.ItemType.Misc;
	}

});
