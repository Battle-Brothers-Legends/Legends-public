this.perk_legend_return_favor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendReturnFavor);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.return_favor"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/return_favor"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.return_favor");
	}

});

