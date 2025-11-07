this.perk_legend_unarmed_lunge <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendUnarmedLunge);
	}

	function onAdded()
	{
		::Legends.Actives.grant(this, ::Legends.Active.LegendUnarmedLunge);
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendUnarmedLunge);
	}

});

