this.perk_legend_spawn_zombie_low <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpawnZombieLow);
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
		if (!this.m.Container.hasActive(::Legends.Active.LegendSpawnZombieLow))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnZombieLow);
			//::Legends.Actives.grant(this, ::Legends.Active.LegendSpawnZombieLowXbow);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnZombieLow);
		//::Legends.Actives.remove(this, ::Legends.Active.LegendSpawnZombieLowXbow);
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 20;
	}

});
