this.perk_legend_gruesome_feast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendGruesomeFeast);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendGruesomeFeast))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendGruesomeFeast);
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendGruesomeFeast))
		{
			::Legends.Actives.remove(this, ::Legends.Active.LegendGruesomeFeast);
		}
	}

});
