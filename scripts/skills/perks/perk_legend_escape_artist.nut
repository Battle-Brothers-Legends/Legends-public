this.perk_legend_escape_artist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendEscapeArtist);
	}

	// Note: As of Legends 18.2.0, this perk is no longer purchaseable by players (its effects have been merged into by Net Mastery)
	// The perk will continue to exist so that it can be used by non-player actors

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
