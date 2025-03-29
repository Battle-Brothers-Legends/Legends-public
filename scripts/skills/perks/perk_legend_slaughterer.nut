this.perk_legend_slaughterer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSlaughterer);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _targetEntity.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_targetEntity.getTile().getDistanceTo(killer.getTile()), this.Const.Morale.EnemyKilledDistancePow);

			if (killer != null && killer.isAlive() && killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}

			killer.checkMorale(1, difficulty);
		}
	}
});

