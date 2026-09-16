this.perk_legend_barter_paymaster <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPaymaster);
	}


	function onAdded()
	{
		if (::World.State.getPlayer() == null)
			return;
		::World.State.getPlayer().calculateHaggleMult();
	}

	function onRemoved()
	{
		if (::World.State.getPlayer() == null)
			return;
		::World.State.getPlayer().calculateHaggleMult();
	}
});
