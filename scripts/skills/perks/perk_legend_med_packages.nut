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
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateMedsModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}
		this.World.State.getPlayer().calculateMedsModifier();
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 1.05;
	}

});
