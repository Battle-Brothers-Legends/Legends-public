this.perk_legend_barter_trustworthy <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 0.02
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBarterTrustworthy);
	}

	function getModifier()
	{
		return this.m.Amount;
	}

	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateBarterMult();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateBarterMult();
	}

});
