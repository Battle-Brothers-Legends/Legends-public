this.perk_legend_spawn_skeleton_high <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpawnSkeletonHigh);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
		stash.add(this.new("scripts/items/spawns/skeleton_item"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSpawnSkeletonHigh))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnSkeletonHigh);
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnSkeletonHighArcher);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnSkeletonHigh);
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnSkeletonHighArcher);
	}

});
