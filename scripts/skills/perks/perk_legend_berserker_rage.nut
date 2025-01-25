this.perk_legend_berserker_rage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBerserkerRage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasEffect(::Legends.Effect.LegendBerserkerRage))
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendBerserkerRage);
		}
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendBerserkerRage);
	}

});
