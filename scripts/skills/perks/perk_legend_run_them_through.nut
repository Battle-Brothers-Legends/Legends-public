this.perk_legend_run_them_through <- this.inherit("scripts/skills/skill", {
	m = {
		TargetInjuriesBeforeAttack = [],
		ValidAttack = false,
		ApplicableSkills = [
			::Legends.Active.LegendSkewer,
			::Legends.Active.Thrust,
			::Legends.Active.Impale,
			::Legends.Active.Rupture,
			::Legends.Active.Prong,
			::Legends.Active.Strike
		],
		PrevTile = null,
		HasMoved = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendRunThemThrough);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeTargetHit(_skill, _targetEntity, _hitInfo)
	{
		local validSkill = false;
		foreach (skill in this.m.ApplicableSkills)
		{
			if (_skill.getID == ::Legends.Actives.getID(skill))
			{
				validSkill = true;
				break;
			}
		}

		if (!validSkill)
			return;

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.LegendSkewer) && !_skill.m.IsSecondAttack) // having skewer do double attacks on each target hit will be bad
			return;

		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Strike) && !_skill.m.IsGlaiveStrike) // just glaive strike
			return;

		this.m.ValidAttack = true;
		this.m.TargetInjuriesBeforeAttack = _targetEntity.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.m.ValidAttack)
			return cleanup();

		if (_targetEntity.isDying() || _damageInflictedHitpoints > _targetEntity.m.Hitpoints) // enemy knows his star sign, he's been ran through
			return this.attackTargetBehind(_targetEntity);

		foreach (injury in _targetEntity.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury))
		{
			if (this.m.TargetInjuriesBeforeAttack.find(injury) == null && this.Math.rand(1, 4) == 1) // injury is new and 25% chance
			{
				return this.attackTargetBehind(_targetEntity);
			}
		}

		return cleanup();
	}

	function cleanup()
	{
		this.m.TargetInjuriesBeforeAttack = [];
		this.m.ValidAttack = false;
	}

	function attackTargetBehind(_targetEntity)
	{
		this.cleanup()

		local actor = this.getContainer().getActor();
		if (!actor || actor.isDying())
		{
			return ret;
		}

		local ownTile = actor.getTile();
		local targetTile = _targetEntity.getTile();
		local dir = ownTile.getDirectionTo(targetTile);

		if (targetTile.hasNextTile(dir))
		{
			local forwardTile = targetTile.getNextTile(dir);

			if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().isAttackable() && this.Math.abs(forwardTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(actor, forwardTile.getEntity()) || ret;
			}
		}

		return ret;
	}

	function onAfterUpdate(_properties)
	{
		if (this.m.HasMoved)
			return;
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.ApplicableSkills.find(skill.getID()) != null)
			{
				skill.m.FatigueCostMult *= 1.2;
			}
		}
	}

	function onTurnEnd()
	{		
		this.m.HasMoved = false;
	}

	function onWaitTurn()
	{
		this.m.HasMoved = false;
	}

	function onMovementStarted(_tile, _numTiles)
	{
		this.m.PrevTile = _tile;
	}

	function onMovementFinished (_tile) 
	{	
		if (_tile.getDistanceTo(this.m.PrevTile) > 0)
			this.m.HasMoved = true;
	}
});
