this.perk_legend_skillful_stacking <- this.inherit("scripts/skills/skill", {
	m = {
		StashSize = 12
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSkillfulStacking);
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
		_properties.Stamina += 9;
	}

});
