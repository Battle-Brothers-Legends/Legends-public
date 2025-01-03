this.perk_legend_tumble <- this.inherit("scripts/skills/skill", {
	m = {
		Skills = [
			"actives.lunge",
			"actives.footwork",
			"actives.rotation",
			"actives.legend_greatlunge",
			"actives.legend_tumble",
			"actives.legend_leap",
			"actives.legend_horse_pirouette"
		]
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendTumble);
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

				if (skill.getID() == "actives.legend_leap")
				{
					skill.m.ActionPointCost /= 2;
				}
			}
		}
	}
});

