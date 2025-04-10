this.perk_legend_peaceful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPeaceful);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
