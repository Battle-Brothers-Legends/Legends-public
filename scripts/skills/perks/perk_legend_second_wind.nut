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
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;

		if (!actor.isAlive() || actor.isDying())
			return;

		if (!actor.getSkills().hasEffect(::Legends.Effect.LegendSecondWind) && actor.getHitpointsPct() < 0.5)
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendSecondWind);
		}
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendSecondWind))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendSecondWind);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendSecondWind);
	}
});
