this.perk_legend_lookout <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendLookout);
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
	}

	function onAdded()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendMarkTarget) && this.getContainer().getActor().isPlayerControlled())
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMarkTarget);
	}


});

