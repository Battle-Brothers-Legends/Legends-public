this.perk_legend_possess_undead <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPossessUndead);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.possess_undead"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/possess_undead_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.possess_undead");
	}

});
