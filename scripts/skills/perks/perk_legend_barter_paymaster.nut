this.perk_legend_barter_paymaster <- this.inherit("scripts/skills/skill", {

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPaymaster);
	}


	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
			return;
		this.World.State.getPlayer().calculateBarterMult();
		this.World.State.getPlayer().calculateWageModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
			return;
		this.World.State.getPlayer().calculateWageModifier();
		this.World.State.getPlayer().calculateBarterMult();
	}
});
