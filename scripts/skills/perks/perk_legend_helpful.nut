this.perk_legend_helpful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendHelpful);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPass))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPass);
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendAllyReloadBolt))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendAllyReloadBolt);
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendAllyReloadHandgonne))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendAllyReloadHandgonne);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPass);
		::Legends.Actives.remove(this, ::Legends.Active.LegendAllyReloadBolt);
		::Legends.Actives.remove(this, ::Legends.Active.LegendAllyReloadHandgonne);
	}

});

