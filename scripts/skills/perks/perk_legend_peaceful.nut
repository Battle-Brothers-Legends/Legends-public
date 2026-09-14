this.perk_legend_peaceful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPeaceful);
	}


	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
		_properties.Bravery += 20;
		_properties.MeleeSkill += -20;
		_properties.RangedSkill += -20;
		_properties.XPGainMult *= 1.05;

	}

	function onCombatStarted()
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		foreach( a in actors )
		{
			if (a.getFaction() == this.getContainer().getActor().getFaction() && !a.getSkills().hasEffect(::Legends.Effect.LegendPeacefulReassured))
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendPeacefulReassured);
			}
		}
	}


});
