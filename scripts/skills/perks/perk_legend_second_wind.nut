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

				actor.getSkills().add(this.new("scripts/skills/effects/legend_second_wind_effect"));
				actor.getSkills().add(this.new("scripts/skills/effects/recovery_potion_effect"));
				if (this.m.Container.hasEffect(::Legends.Effect.Stunned))
				{
				this.m.Container.removeByID("effects.stunned");
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Dazed))
				{
				this.m.Container.removeByID("effects.dazed");
				}
				if (this.m.Container.hasEffect(::Legends.Effect.LegendDazed))
				{
				this.m.Container.removeByID("effects.legend_dazed");
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Staggered))
				{
				this.m.Container.removeByID("effects.staggered");
				}
				if (this.m.Container.hasEffect(::Legends.Effect.LegendBaffled))
				{
				this.m.Container.removeByID("effects.legend_baffled");
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Charmed))
				{
				this.m.Container.removeByID("effects.charmed");
				}
				if (this.m.Container.hasEffect(::Legends.Effect.Sleeping))
				{
				this.m.Container.removeByID("effects.sleeping");
				}
			}
		}
	}

});
