this.perk_legend_kick <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendKick);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_kick"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_kick_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_kick");
	}



});

