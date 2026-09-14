this.perk_legend_spawn_zombie_med <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpawnZombieMed);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
	}

	function onUnlocked()
	{
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
		this.World.Assets.addMedicine(30);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSpawnZombieMed))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnZombieMed);
			//::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnZombieMedXbow);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnZombieMed);
		//::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnZombieMedXbow);
	}

});
