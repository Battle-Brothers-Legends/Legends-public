this.perk_legend_second_wind <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSecondWind);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
		}
		else
		{
			return;
		}
		local actor = this.getContainer().getActor();
		local percHP = actor.getHitpointsPct();
		if (!actor.getSkills().hasEffect(::Legends.Effect.LegendSecondWind))
		{
			if (percHP < 0.5)
			{
				actor.setFatigue(actor.getFatigue() - 0.5 * actor.getFatigue() );

				::Legends.Effects.grant(actor, ::Legends.Effect.LegendSecondWind);
				::Legends.Effects.grant(actor, ::Legends.Effect.RecoveryPotion);
				if (this.m.Container.hasEffect(::Legends.Effect.Stunned))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.Stunned);
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Dazed))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.Dazed);
				}
				if (this.m.Container.hasEffect(::Legends.Effect.LegendDazed))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.LegendDazed);
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Staggered))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.Staggered);
				}
				if (this.m.Container.hasEffect(::Legends.Effect.LegendBaffled))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.LegendBaffled);
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Charmed))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.Charmed);
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Sleeping))
				{
				::Legends.Effects.remove(this, ::Legends.Effect.Sleeping);
				}
			}
		}
	}

});
