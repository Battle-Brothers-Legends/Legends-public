this.perk_legend_quartermaster <- this.inherit("scripts/skills/skill", {

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendQuartermaster);
	}


	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateFoodModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateFoodModifier();
	}


});
