this.perk_legend_zombie_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendZombieBite);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.ZombieBite))
		{
			::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.ZombieBite);
	}



});

