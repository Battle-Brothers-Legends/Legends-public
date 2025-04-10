this.perk_legend_darkflight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendDarkflight);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendDarkflight))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDarkflight);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendDarkflight);
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});
