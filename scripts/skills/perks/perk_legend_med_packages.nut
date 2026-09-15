this.perk_legend_med_packages <- this.inherit("scripts/skills/skill", {
	m = {
		Amount = 30
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMedPackages);
	}

	function getModifier()
	{
		return this.m.Amount;
	}

	function onAdded()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateMedsModifier();
	}

	function onRemoved()
	{
		if (::World.State.getPlayer() == null)
		{
			return;
		}
		::World.State.getPlayer().calculateMedsModifier();
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 1.05;
	}

});
