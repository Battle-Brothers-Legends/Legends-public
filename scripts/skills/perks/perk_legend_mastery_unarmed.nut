this.perk_legend_mastery_unarmed <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecUnarmed);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInFists = true;
	}

	function onAdded()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendKick) && this.getContainer().getActor().isPlayerControlled())
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendKick);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendKick);
	}

});
