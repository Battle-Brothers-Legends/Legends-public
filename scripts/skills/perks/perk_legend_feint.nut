this.perk_legend_feint <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendFeint);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!_targetEntity.isAttackable())
			return;
		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.floor(_skill.getFatigueCost() * 0.2)));

		if (::Legends.S.skillEntityAliveCheck(_targetEntity))
			return;

		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.LegendParried))
			return;

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendParried);

		if (!actor.isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " feinted " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them exposed!");
		}
	}


});

