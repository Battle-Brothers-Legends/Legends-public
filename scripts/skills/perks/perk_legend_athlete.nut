this.perk_legend_athlete <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendAthlete);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendClimb))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_climb_skill"));
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendSprint))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_sprint_skill_5"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendClimb);
	}

});

