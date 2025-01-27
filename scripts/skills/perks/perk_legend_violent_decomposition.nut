this.perk_legend_violent_decomposition <- this.inherit("scripts/skills/skill", {
	m = {
		LootChance = 30
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendViolentDecomposition);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendViolentDecomposition))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_violent_decomposition_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendViolentDecomposition);
	}


});
