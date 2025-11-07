this.perk_legend_pugilist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPugilist);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.HandToHand))
		{
			_properties.DamageTotalMult *= 1.25;
		}
	}
});
