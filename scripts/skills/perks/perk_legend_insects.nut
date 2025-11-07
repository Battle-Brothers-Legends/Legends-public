this.perk_legend_insects <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendInsects);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.Insects))
		{
			::Legends.Actives.grant(this, ::Legends.Active.Insects);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.Insects);
	}

});
