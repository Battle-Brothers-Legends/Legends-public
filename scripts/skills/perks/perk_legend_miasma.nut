this.perk_legend_miasma <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendMiasma);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMiasma))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMiasma);
		}
	}
		function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMiasma);
	}

});
