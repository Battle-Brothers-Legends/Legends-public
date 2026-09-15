this.perk_legend_slaughterer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSlaughterer);
	}

	function onUpdate( _properties )
	{
		_properties.FatalityChanceMult = 1000.0;
		_properties.FlatOnKillOtherActorModifier -= 5;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (!this.getContainer().hasTrait(::Legends.Trait.Bloodthirsty))
			return;

		local killer = this.getContainer().getActor();
		if (!_targetEntity.isAlliedWith(killer))
		{
			local difficulty = ::Const.Morale.EnemyKilledBaseDifficulty + _targetEntity.getXPValue() * ::Const.Morale.EnemyKilledXPMult - ::Math.pow(_targetEntity.getTile().getDistanceTo(killer.getTile()), ::Const.Morale.EnemyKilledDistancePow);

			if (killer != null && killer.isAlive() && killer.getID() == this.getID())
			{
				difficulty = difficulty + ::Const.Morale.EnemyKilledSelfBonus;
			}

			killer.checkMorale(1, difficulty);
		}
	}
});

