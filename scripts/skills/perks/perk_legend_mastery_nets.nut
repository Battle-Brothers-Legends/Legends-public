this.perk_legend_mastery_nets <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendMasteryNets);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInNets = true;
	}

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
