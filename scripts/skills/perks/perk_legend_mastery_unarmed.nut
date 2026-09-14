this.perk_legend_mastery_unarmed <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecUnarmed);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInFists = true;
	}

	function onAdded()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendTackle) && this.getContainer().getActor().isPlayerControlled())
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendTackle);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendTackle);
	}

});
