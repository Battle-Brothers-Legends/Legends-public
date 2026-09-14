this.perk_legend_summon_bear <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSummonBear);
	}

	function onAdded()
	{
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/legend_warbear_item"));
	}
});
