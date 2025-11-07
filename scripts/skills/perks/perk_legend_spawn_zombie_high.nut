this.perk_legend_spawn_zombie_high <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpawnZombieHigh);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSpawnZombieHigh))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnZombieHigh);
			//::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnZombieHighXbow);

		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnZombieHigh);
		//::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnZombieHighXbow);
	}

});
