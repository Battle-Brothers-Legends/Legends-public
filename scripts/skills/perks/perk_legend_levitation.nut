this.perk_legend_levitation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendLevitate);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_levitate_person"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_levitate_person_skill"));
		}
	}

	function onRemoved()
	{
		if (this.m.Container.hasSkill("actives.legend_levitate_person"))
		{
			this.m.Container.removeByID("actives.legend_levitate_person");
		}
	}

});
