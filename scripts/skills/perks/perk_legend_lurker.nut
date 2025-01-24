//Author: WNTR Jimmy
this.perk_legend_lurker <- this.inherit("scripts/skills/skill", {
    m = {},

	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendLurker);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
	   	this.skill.onUpdate(_properties);
	   	local actor = this.getContainer().getActor();

		if (actor.getSkills().hasSkill("terrain.hidden"))
		{
			_properties.RangedSkill *= 1.25;
			_properties.FatigueRecoveryRate += 10;
		}

		if (actor.getSkills().hasEffect(::Legends.Effect.Smoke))
		{
			_properties.ActionPoints += 2
		}

	}

	function onAdded()
	{
		if (!this.m.Container.hasEffect(::Legends.Effect.LegendLurker))
		{
			this.m.Container.add(this.new("scripts/skills/effects/legend_lurker_effect"));
		}
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendLurker);
	}

	function onAfterUpdate( _properties )
    {
       	if(this.getContainer().hasEffect(::Legends.Effect.LegendHidden))
       	{
			if(this.getContainer().get(::Legends.Effect.LegendHidden).isActive())
			{
				_properties.FatigueRecoveryRate += 10;
			}
		}
    }

});




