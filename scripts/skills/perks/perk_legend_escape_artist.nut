this.perk_legend_escape_artist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendEscapeArtist);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	// Note: As of Legends 18.2.0, this perk is no longer purchaseable by players (its effects have been merged into by Net Mastery)
	// The perk will continue to exist so that it can be used by non-player actors

	function onAfterUpdate( _properties )
	{
		local skills = this.getContainer().getSkillsByFunction(@(_skill) _skill.getID() == "actives.break_free" || _skill.getID() == "actives.break_ally_free");
		foreach (s in skills)
		{
			s.m.ActionPointCost -= 1;
			s.m.FatigueCostMult *= 0.33;
		}
	}

});
