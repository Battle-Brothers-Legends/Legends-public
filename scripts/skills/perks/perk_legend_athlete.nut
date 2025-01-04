this.perk_legend_athlete <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendAthlete);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_climb"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_climb_skill"));
		}
		if (!this.m.Container.hasSkill("actives.legend_sprint"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_sprint_skill_5"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_climb");
	}

});

