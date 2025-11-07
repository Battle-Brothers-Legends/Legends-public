this.perk_legend_boondock_blade <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBoondockBlade);
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isHidden())
		{
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 10;
			_properties.MeleeSkill += 10;
			_properties.RangedSkill += 10;
		}
	}

});

