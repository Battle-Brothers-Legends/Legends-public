this.perk_legend_horrify <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendHorrify);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendHorrificScream))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendHorrificScream);
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasPerk(::Legends.Perk.LegendHorrify))
		{
			::Legends.Actives.remove(this, ::Legends.Active.LegendHorrificScream);
		}
	}

});
