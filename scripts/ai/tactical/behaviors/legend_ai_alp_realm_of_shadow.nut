this.legend_ai_alp_realm_of_shadow <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetScore = 0,
		PossibleSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendAlpRealmOfShadow)
		],
		Skill = null
	},
	function create()
	{
		// basically a clone of miasma 
		this.m.ID = ::Const.AI.Behavior.ID.Miasma;
		this.m.Order = ::Const.AI.Behavior.Order.Miasma;
		this.m.IsThreaded = false;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.TargetScore = 0;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		//score *= this.getFatigueScoreMult(this.m.Skill);
		this.selectBestTarget(_entity.getTile(), _entity, this.m.Skill);

		if (this.m.TargetTile == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		return ::Const.AI.Behavior.Score.Miasma * score + this.m.TargetScore;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;

			if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return false;
		}

		this.m.Skill.use(this.m.TargetTile);

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}

	function selectBestTarget( _myTile, _entity, _skill )
	{
		local bestScore = -9000.0;
		local bestTarget;
		local potentialTiles = [];
		local usedIDs = [];
		local opponents = this.getAgent().getKnownOpponents();

		foreach( o in opponents )
		{
			local opponentTile = o.Actor.getTile();

			if (_myTile.getDistanceTo(opponentTile) > _skill.getMaxRange() + 1)
				continue;

			if (usedIDs.find(opponentTile.ID) == null)
			{
				potentialTiles.push(opponentTile);
				usedIDs.push(opponentTile.ID);
			}

			for( local i = 0; i < 6; ++i )
			{
				if (!opponentTile.hasNextTile(i))
					continue;
				
				local adjacentTile = opponentTile.getNextTile(i);

				if (_myTile.getDistanceTo(adjacentTile) > _skill.getMaxRange() + 1)
					continue;

				if (usedIDs.find(adjacentTile.ID) != null)
					continue;
				
				potentialTiles.push(adjacentTile);
				usedIDs.push(adjacentTile.ID);
			}
		}

		if (potentialTiles.len() == 0)
			return 0.0;

		foreach( tile in potentialTiles )
		{
			if (!_skill.isInRange(tile, _myTile) || !_skill.onVerifyTarget(_myTile, tile))
				continue;

			local targets = [];

			if (tile.IsOccupiedByActor)
				targets.push(tile.getEntity());

			local score = 0.0;
			local numAffected = 0;

			for( local i = 0; i < 6; ++i )
			{
				if (!tile.hasNextTile(i))
					continue;
				
				local nextTile = tile.getNextTile(i);

				if (nextTile.Properties.Effect != null && nextTile.Properties.Effect.Timeout - ::Time.getRound() >= 2)
					continue;

				if (nextTile.IsOccupiedByActor)
					targets.push(nextTile.getEntity());
			}

			if (targets.len() == 0)
				continue;

			foreach( target in targets )
			{
				if (_entity.isAlliedWith(target))
					continue;

				local targetTile = target.getTile();
				local target_score = _skill.getMaxRange() - _myTile.getDistanceTo(target.getTile());
				target_score += ::Const.AI.Behavior.MiasmaZOCBonus * target.getTile().getZoneOfControlCountOtherThan(target.getAlliedFactions());

				if (::Legends.S.isEntityMovementDisabled(target))
					target_score -= ::Const.AI.Behavior.MiasmaStunnedBonus;

				target_score *= target.getCurrentProperties().TargetAttractionMult;

				if (targetTile.Properties.Effect != null && targetTile.Properties.Effect.Type == "legend_shadow_mist" && targetTile.Properties.Effect.Timeout - ::Time.getRound() == 1)
					target_score *= ::Const.AI.Behavior.MiasmaOneTurnLeftMult;

				if (!::Legends.S.isEntityMovementDisabled(target) && !target.getTile().hasZoneOfControlOtherThan(target.getAlliedFactions()) && !target.isAbleToWait())
					target_score *= ::Const.AI.Behavior.MiasmaVSWaitMult;

				score += target_score;
				numAffected += 1;
			}

			if (numAffected > 1)
				score *= ::Math.pow(::Const.AI.Behavior.RootNumAffectedPOW, numAffected - 1);

			if (score <= bestScore)
				continue;

			bestScore = score;
			bestTarget = tile;
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget;
			this.m.TargetScore = bestScore;
			return ::Math.maxf(0.1, bestScore * 0.1);
		}
		else
		{
			return 0.0;
		}
	}

});

