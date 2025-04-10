this.perk_legend_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPerfectFocus);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.PerfectFocus))
		{
			::Legends.Actives.grant(this, ::Legends.Active.PerfectFocus);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.PerfectFocus);
	}

});
