this.perk_legend_true_believer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendTrueBeliever);
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByFleeingAllies = false;
		_properties.IsAffectedByDyingAllies = false;
		local bonus = this.getFleeing() * 0.05;
		_properties.BraveryMult += bonus;

	}

	function getFleeing()
	{
		if (!("Entities" in this.Tactical))
		{
			return 0;
		}
		if (this.Tactical.Entities == null)
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local fleeing = 0;

		local actors = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
		{
			if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				fleeing += 1;

			}

		}
		return fleeing;
	}

	function onAdded()
	{
		if (this.m.Container.hasTrait(::Legends.Trait.Superstitious))
		{
			::Legends.Traits.remove(this, ::Legends.Trait.Superstitious);
		}
		if (this.m.Container.hasTrait(::Legends.Trait.Dastard))
		{
			::Legends.Traits.remove(this, ::Legends.Trait.Dastard);
		}
		if (this.m.Container.hasTrait(::Legends.Trait.Insecure))
		{
			::Legends.Traits.remove(this, ::Legends.Trait.Insecure);
		}
		if (this.m.Container.hasTrait(::Legends.Trait.Craven))
		{
			::Legends.Traits.remove(this, ::Legends.Trait.Craven);
		}
	}
});
