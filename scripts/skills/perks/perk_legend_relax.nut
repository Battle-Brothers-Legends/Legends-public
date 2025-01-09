this.perk_legend_relax <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendRelax);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_relax"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_relax_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_relax");
	}

});
