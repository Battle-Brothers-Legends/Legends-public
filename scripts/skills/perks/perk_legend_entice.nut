this.perk_legend_entice <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendEntice);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendEntice))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendEntice);
		}
	}
	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendEntice);
	}

});
