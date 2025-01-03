this.perk_legend_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPerfectFocus);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.perfect_focus"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/perfect_focus"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.perfect_focus");
	}

});
