this.perk_legend_mastery_poison <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecPoison);
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPoisonWeapon))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPoisonWeapon);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPoisonWeapon);
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});
