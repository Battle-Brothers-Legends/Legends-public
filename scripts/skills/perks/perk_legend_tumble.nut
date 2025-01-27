this.perk_legend_tumble <- this.inherit("scripts/skills/skill", {
	m = {
		Skills = [
			::Legends.Actives.getID(::Legends.Active.Lunge),
			::Legends.Actives.getID(::Legends.Active.Footwork),
			::Legends.Actives.getID(::Legends.Active.Rotation),
			::Legends.Actives.getID(::Legends.Active.LegendTumble),
			::Legends.Actives.getID(::Legends.Active.LegendLeap),
			::Legends.Actives.getID(::Legends.Active.LegendHorsePirouette)
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendTumble);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(skill.getID()) != null)
			{
				skill.m.FatigueCostMult *= 0.5;

				if (skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendLeap))
				{
					skill.m.ActionPointCost /= 2;
				}
			}
		}
	}
});

