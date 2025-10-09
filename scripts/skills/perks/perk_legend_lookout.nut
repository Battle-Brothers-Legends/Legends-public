this.perk_legend_lookout <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendLookout);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
	}

	function onAdded()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendMarkTarget) && this.getContainer().getActor().isPlayerControlled())
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMarkTarget);
	}


});

