this.perk_legend_summon_cat <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSummonCat);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendUnleashCat))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_unleash_cat_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendUnleashCat);
	}


});
