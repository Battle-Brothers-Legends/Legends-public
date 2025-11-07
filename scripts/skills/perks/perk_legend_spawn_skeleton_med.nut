this.perk_legend_spawn_skeleton_med <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpawnSkeletonMed);
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
		if (!this.m.Container.hasActive(::Legends.Active.LegendSpawnSkeletonMed))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnSkeletonMed);
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnSkeletonMedArcher);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnSkeletonMed);
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnSkeletonMedArcher);
	}

});
