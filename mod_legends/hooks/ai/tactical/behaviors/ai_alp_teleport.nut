::mods_hookExactClass("ai/tactical/behaviors/ai_alp_teleport", function(o)
{
	o.onEvaluate = function( _entity )
	{
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;

		if (_entity.getCurrentProperties().IsRooted)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getCurrentProperties().IsStunned)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.Retreat).getScore() > 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _entity.getID())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				this.m.SelectedSkill = skill;
				break;
			}
		}

		if (this.m.SelectedSkill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local potentialDestinations = [];

		if (this.Const.Tactical.Actor.Alp.TeleportTargets.len() == 0 || this.Const.Tactical.Actor.Alp.TeleportFrame != this.Time.getFrame())
		{
			this.Const.Tactical.Actor.Alp.TeleportTargets = [];
			this.Const.Tactical.Actor.Alp.TeleportFrame = this.Time.getFrame();
			this.getStrategy().cleanUpKnownOpponents();
			this.getStrategy().compileKnownOpponents();
			local targets = this.getAgent().getKnownOpponents();

			foreach( t in targets )
			{
				if (t.Actor.isNull())
				{
					continue;
				}

				local targetValue = this.queryTargetValue(_entity, t.Actor);

				if (t.Actor.getCurrentProperties().IsStunned && t.Actor.getSkills().hasEffect(::Legends.Effect.Sleeping))
				{
					targetValue = targetValue * 1.5;
				}

				if (t.Actor.getCurrentProperties().MoraleCheckBraveryMult[1] > 0.0)
				{
					targetValue = targetValue / t.Actor.getCurrentProperties().MoraleCheckBraveryMult[1];
				}

				local potentialTiles = this.queryDestinationsInRange(t.Actor.getTile(), this.getProperties().EngageRangeMin, this.getProperties().EngageRangeMax);

				foreach( tile in potentialTiles )
				{
					if (!tile.IsEmpty || tile.Type == this.Const.Tactical.TerrainType.Impassable)
					{
						continue;
					}

					local score = 60.0 + 40.0 * targetValue;
					score = score - tile.getZoneOfOccupationCountOtherThan(_entity.getAlliedFactions()) * 20.0;
					score = score + tile.TVTotal;
					score = score - (this.hasNegativeTileEffect(tile, _entity) ? 40.0 : 0.0);

					foreach( o in targets )
					{
						if (o.Actor.isNull() || o.Actor.getID() == t.Actor.getID())
						{
							continue;
						}

						if (o.Actor.getMoraleState() == this.Const.MoraleState.Fleeing || o.Actor.getCurrentProperties().IsStunned)
						{
							continue;
						}

						local d = o.Actor.getTile().getDistanceTo(tile);

						if (d <= 3)
						{
							score = score - 5.0;
						}
					}

					this.Const.Tactical.Actor.Alp.TeleportTargets.push({
						Tile = tile,
						Score = score
					});
				}
			}
		}

		foreach( pd in this.Const.Tactical.Actor.Alp.TeleportTargets )
		{
			if (!pd.Tile.IsEmpty || pd.Tile.Type == this.Const.Tactical.TerrainType.Impassable)
			{
				continue;
			}

			local score = pd.Score;

			for( local i = 0; i < 6; i = ++i )
			{
				if (!pd.Tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = pd.Tile.getNextTile(i);

					if (nextTile.IsOccupiedByActor && nextTile.getEntity().getType() == this.Const.EntityType.Alp)
					{
						score = score - 10.0;
					}
				}
			}

			potentialDestinations.push({
				Tile = pd.Tile,
				Score = score
			});
		}

		if (potentialDestinations.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		potentialDestinations.sort(this.onSortByScore);
		this.m.TargetTile = potentialDestinations[0].Tile;
		return this.Const.AI.Behavior.Score.AlpTeleport * score;
	}
});