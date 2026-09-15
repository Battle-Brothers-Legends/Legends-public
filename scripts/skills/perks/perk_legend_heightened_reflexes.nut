this.perk_legend_heightened_reflexes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHeightenedReflexes);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.DamageTotalMult += ::Math.floor(this.getContainer().getActor().getInitiative() * 0.15) * 0.01;
	}
});

