this.perk_legend_barter_paymaster <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPaymaster);
	}


	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
			return;
		this.World.State.getPlayer().calculateHaggleMult();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
			return;
		this.World.State.getPlayer().calculateHaggleMult();
	}
});
