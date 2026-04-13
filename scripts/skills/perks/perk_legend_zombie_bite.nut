this.perk_legend_zombie_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendZombieBite);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.ZombieBite))
		{
			::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.ZombieBite);
	}



});

