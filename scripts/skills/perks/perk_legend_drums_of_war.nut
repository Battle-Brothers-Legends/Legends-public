this.perk_legend_drums_of_war <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendDrumsOfWar);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_drums_of_war"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_drums_of_war_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_drums_of_war");
	}

});

