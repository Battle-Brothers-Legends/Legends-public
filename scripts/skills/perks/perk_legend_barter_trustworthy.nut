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
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateHaggleMult();
	}

	function onRemoved()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateHaggleMult();
	}

});
