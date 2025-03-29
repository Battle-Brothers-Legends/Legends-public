this.legend_ai_spawn_shadow <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		IsSpent = false,
		Tiles = []
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.SpawnShadow;
		this.m.Order = this.Const.AI.Behavior.Order.SpawnShadow;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Tiles = [];
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		local time = this.Time.getExactTime();

		if (this.m.IsSpent)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPoints() == _entity.getActionPointsMax() && !this.Tactical.State.isAutoRetreat())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPoints() >= 5 && !this.Tactical.State.isAutoRetreat())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local tiles = [];
		local mapSize = this.Tactical.getMapSize();

		for( local x = 0; x < mapSize.X; x = ++x )
		{
			for( local y = 0; y < mapSize.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty || tile.Properties.Effect == null || tile.Properties.Effect.Type != "shadows")
				{
				}
				else
				{
					tiles.push({
						Tile = tile,
						Score = 0.0
					});
				}
			}
		}

		if (tiles.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		foreach( t in tiles )
		{
			local tile = t.Tile;
			local score = 0.0;

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			for( local i = 0; i < 6; i = ++i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else
				{
					local targetTile = tile.getNextTile(i);

					if (this.Math.abs(tile.Level - targetTile.Level) > 1)
					{
					}
					else if (!targetTile.IsOccupiedByActor || targetTile.getEntity().isAlliedWith(_entity))
					{
					}
					else
					{
						local target = targetTile.getEntity();
						local target_score = 1.0;
						target_score = target_score + this.Math.max(0, 8 - myTile.getDistanceTo(targetTile));

						if (myTile.getDistanceTo(targetTile) <= target.getIdealRange())
						{
							target_score = target_score + this.Const.AI.Behavior.HorrorAttackingMeBonus;
						}

						if (target.isTurnDone())
						{
							target_score = target_score * this.Const.AI.Behavior.SleepTurnDoneMult;
						}

						target_score = target_score * this.queryTargetValue(_entity, target);
						score = score + target_score;
					}
				}
			}

			if (t.Tile.Properties.Effect.Timeout - this.Time.getRound() <= 1)
			{
				score = score * 0.5;
			}

			t.Score = score;
		}

		tiles.sort(this.onSortByScore);

		if (tiles[0].Score == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Tiles = tiles;
		return this.Const.AI.Behavior.Score.SpawnShadow * scoreMult;
	}

	function onTurnStarted()
	{
		this.m.IsSpent = false;
	}

	function onExecute( _entity )
	{
		local max_shadows = 2;

		for( local i = 0; i < this.m.Tiles.len(); i = ++i )
		{
			if (this.m.Tiles[0].Score == 0)
			{
				break;
			}

			local tile = this.m.Tiles[0].Tile;
			this.m.Tiles.remove(0);
			local shadow = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_alp_shadow", tile.Coords.X, tile.Coords.Y);
			shadow.setFaction(_entity.getFaction());
			max_shadows = --max_shadows;

			if (max_shadows <= 0)
			{
				break;
			}
		}

		this.m.Tiles = [];
		this.m.IsSpent = true;
		this.getAgent().declareEvaluationDelay(1000);
		return true;
	}

	function onSortByScore( _a, _b )
	{
		if (_a.Score > _b.Score)
		{
			return -1;
		}
		else if (_a.Score < _b.Score)
		{
			return 1;
		}

		return 0;
	}

});

