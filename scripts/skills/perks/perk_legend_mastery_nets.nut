this.perk_legend_mastery_nets <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryNets);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInNets = true;
	}

	function onAfterUpdate( _properties )
	{
		local skills = this.getContainer().getSkillsByFunction(@(_skill) _skill.getID() == ::Legends.Actives.getID(::Legends.Active.BreakFree) || _skill.getID() == ::Legends.Actives.getID(::Legends.Active.BreakAllyFree));
		foreach (s in skills)
		{
			s.m.ActionPointCost -= 1;
			s.m.FatigueCostMult *= 0.33;
		}
	}

});
