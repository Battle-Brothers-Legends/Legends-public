this.perk_legend_inspire <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendInspire);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_inspire"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_inspire_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_inspire");
	}



});

