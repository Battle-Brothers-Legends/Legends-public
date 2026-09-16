this.perk_legend_efficient_packing <- this.inherit("scripts/skills/skill", {
	m = {
		StashSize = 8
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendEfficientPacking);
	}

	function onAdded()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateStashModifier();
	}

	function onRemoved()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateStashModifier();
	}

	function getModifier()
	{
		return this.m.StashSize;
	}

	function onUpdate( _properties )
	{
		_properties.Stamina += 6;
	}


});
