this.perk_legend_grappler <- this.inherit("scripts/skills/skill", {
	m = {
		GrappleChance = 25,
		DisarmChance = 50
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendGrappler);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendChoke))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendChoke);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendChoke);
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() != ::Legends.Actives.getID(::Legends.Active.HandToHand))
			return;

		if (this.Math.rand(1, 100) > this.m.GrappleChance) {
			return
		}

		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) {
			return;
		}

		::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendGrappled);

		local actor = this.getContainer().getActor();
		if (!_targetEntity.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " has grappled " + this.Const.UI.getColorizedEntityName(_targetEntity) + " for two turns");
		}

		if ((this.Math.rand(1, 100) > this.m.DisarmChance || actor.getCurrentProperties().IsSpecializedInFists) && !_targetEntity.getCurrentProperties().IsImmuneToDisarm) {
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.Disarmed);
		}
	}
});
