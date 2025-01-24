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
			this.m.Container.add(this.new("scripts/skills/effects/legend_berserker_rage_effect"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.legend_berserker_rage");
	}

});
