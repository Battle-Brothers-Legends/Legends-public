::mods_hookNewObject("entity/tactical/tactical_entity_manager", function(o)
{
	o.m.NetTiles <- {};

	o.addNetTiles <- function( _tile )
	{
		if (_tile.ID in m.NetTiles) return;
		else m.NetTiles[_tile.ID] <- _tile;
	}

	local clear_tactical_entity_manager = o.clear;
	o.clear = function()
	{
		clear_tactical_entity_manager();
		m.NetTiles = {};
	}

 	o.spawn = function ( _properties )
	{
		if (this.World.State.getCombatSeed() != 0)
		{
			this.Math.seedRandom(this.World.State.getCombatSeed());
		}

		this.Time.setRound(0);
		this.World.Assets.updateFormation();
		local all_players = _properties.IsUsingSetPlayers ? _properties.Players : this.World.getPlayerRoster().getAll();

		foreach( e in _properties.TemporaryEnemies )
		{
			if (e > 2)
			{
				this.World.FactionManager.getFaction(e).setIsTemporaryEnemy(true);
			}
		}

		local frontline = [];
		local reserves = [];

		foreach (p in all_players)
		{
			if (p.getPlaceInFormation() > 26)
			{
				continue;
			}

			if (!p.isInReserves())
			{
				frontline.push(p);
			}
			else
			{
				reserves.push(p);
			}
		}

		foreach (r in reserves)
		{
			if (this.World.State.getBrothersInFrontline() != 0 || this.World.Assets.getBrothersMaxInCombat() <= frontline.len()) //Removed: _properties.IsPlayerInitiated && from this line, which should fix the issue where bro tagged as 'reserve' always get pulled into defensive battles
			{
				break;
			}

			frontline.push(r);
		}

		foreach (f in frontline)
		{
			local items = f.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);

			foreach( item in items )
			{
				if ("setLoaded" in item)
				{
					item.setLoaded(false);
				}
			}
		}

		if (this.World.State.isUsingGuests() && this.World.getGuestRoster().getSize() != 0)
		{
			frontline.extend(this.World.getGuestRoster().getAll());
		}

		if (_properties.BeforeDeploymentCallback != null)
		{
			_properties.BeforeDeploymentCallback();
		}

		local isPlayerInitiated = _properties.IsPlayerInitiated;

		if (_properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.Auto)
		{
			if (this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull())
			{
				_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
			}
			else if (_properties.LocationTemplate != null && _properties.LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && !_properties.LocationTemplate.ForceLineBattle)
			{
				_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
			}
			else if ((this.Const.World.TerrainTypeLineBattle[_properties.Tile.Type] || _properties.IsAttackingLocation || isPlayerInitiated) && !_properties.InCombatAlready)
			{
				_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
			}
			else if (!_properties.InCombatAlready)
			{
				_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
			}
			else
			{
				_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
			}
		}

		_properties.Entities.sort(this.onFactionCompare);
		local ai_entities = [];

		foreach( e in _properties.Entities )
		{
			if (ai_entities.len() == 0 || ai_entities[ai_entities.len() - 1].Faction != e.Faction)
			{
				local f = {
					Faction = e.Faction,
					IsAlliedWithPlayer = this.World.FactionManager.isAlliedWithPlayer(e.Faction),
					IsOwningLocation = false,
					DeploymentType = _properties.EnemyDeploymentType,
					Entities = []
				};
				ai_entities.push(f);

				if (_properties.LocationTemplate != null && this.World.FactionManager.isAllied(f.Faction, _properties.LocationTemplate.OwnedByFaction))
				{
					f.IsOwningLocation = true;
				}

				if (f.DeploymentType == this.Const.Tactical.DeploymentType.Auto)
				{
					if (this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull())
					{
						f.DeploymentType = this.Const.Tactical.DeploymentType.Line;
					}
					else if (f.IsAlliedWithPlayer && !_properties.InCombatAlready)
					{
						f.DeploymentType = _properties.PlayerDeploymentType;
					}
					else if (_properties.LocationTemplate != null && _properties.LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && !this.World.FactionManager.isAllied(f.Faction, _properties.LocationTemplate.OwnedByFaction) && !_properties.LocationTemplate.ForceLineBattle)
					{
						f.DeploymentType = this.Const.Tactical.DeploymentType.LineBack;
					}
					else if (_properties.LocationTemplate != null && _properties.LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && this.World.FactionManager.isAllied(f.Faction, _properties.LocationTemplate.OwnedByFaction) && !_properties.LocationTemplate.ForceLineBattle)
					{
						f.DeploymentType = this.Const.Tactical.DeploymentType.Camp;
					}
					else if (_properties.LocationTemplate != null && (_properties.LocationTemplate.Fortification == this.Const.Tactical.FortificationType.None || _properties.LocationTemplate.ForceLineBattle))
					{
						f.DeploymentType = this.Const.Tactical.DeploymentType.Line;
					}
					else if (this.Const.World.TerrainTypeLineBattle[_properties.Tile.Type] || _properties.IsAttackingLocation || isPlayerInitiated || _properties.InCombatAlready)
					{
						f.DeploymentType = this.Const.Tactical.DeploymentType.Line;
					}
					else
					{
						f.DeploymentType = this.Const.Tactical.DeploymentType.Circle;
					}
				}
			}

			ai_entities[ai_entities.len() - 1].Entities.push(e);
		}

		ai_entities.sort(function ( _a, _b )
		{
			if (_a.IsOwningLocation && !_b.IsOwningLocation)
			{
				return -1;
			}
			else if (!_a.IsOwningLocation && _b.IsOwningLocation)
			{
				return 1;
			}

			return 0;
		});
		local hasCampDeployment = false;

		foreach( ai in ai_entities )
		{
			if (ai.DeploymentType == this.Const.Tactical.DeploymentType.Camp)
			{
				hasCampDeployment = true;
				break;
			}
		}

		local shiftX = _properties.LocationTemplate != null ? _properties.LocationTemplate.ShiftX : 0;
		local shiftY = _properties.LocationTemplate != null ? _properties.LocationTemplate.ShiftY : 0;

		switch(_properties.PlayerDeploymentType)
		{
		case this.Const.Tactical.DeploymentType.Line:
			this.placePlayersInFormation(frontline);
			break;

		case this.Const.Tactical.DeploymentType.LineBack:
			if (_properties.InCombatAlready)
			{
				this.placePlayersInFormation(frontline, -10);
			}
			else
			{
				this.placePlayersInFormation(frontline, -10 + shiftX);
			}

			break;

		case this.Const.Tactical.DeploymentType.LineCenter:
			this.placePlayersInFormation(frontline, 3 + shiftX);
			break;

		case this.Const.Tactical.DeploymentType.LineForward:
			this.placePlayersInFormation(frontline, 8 + shiftX);
			break;

		case this.Const.Tactical.DeploymentType.Arena:
			this.placePlayersInFormation(frontline, -4, -3);
			break;

		case this.Const.Tactical.DeploymentType.Center:
			this.placePlayersAtCenter(frontline);
			break;

		case this.Const.Tactical.DeploymentType.Edge:
			this.placePlayersAtBorder(frontline);
			break;

		case this.Const.Tactical.DeploymentType.Random:
		case this.Const.Tactical.DeploymentType.Circle:
			this.placePlayersInCircle(frontline);
			break;

		case this.Const.Tactical.DeploymentType.Custom:
			if (_properties.PlayerDeploymentWithFrontlineCallback != null)
			{
				_properties.PlayerDeploymentWithFrontlineCallback(frontline);
			}
			else if (_properties.PlayerDeploymentCallback != null)
			{
				_properties.PlayerDeploymentCallback();
			}

			break;
		}

		local factionsNotAlliedWithPlayer = hasCampDeployment || _properties.InCombatAlready && ai_entities.len() <= 2 ? 1 : 0;
		local lastFaction = 99;

		foreach( i, f in ai_entities )
		{
			if ((!f.IsAlliedWithPlayer || _properties.InCombatAlready) && f.DeploymentType != this.Const.Tactical.DeploymentType.Camp && (lastFaction == 99 || !this.World.FactionManager.isAllied(lastFaction, f.Faction)))
			{
				factionsNotAlliedWithPlayer = ++factionsNotAlliedWithPlayer;
			}

			if (factionsNotAlliedWithPlayer > 3)
			{
				continue;
			}

			local n = f.IsAlliedWithPlayer && !_properties.InCombatAlready ? 0 : factionsNotAlliedWithPlayer;
			lastFaction = f.Faction;

			switch(f.DeploymentType)
			{
			case this.Const.Tactical.DeploymentType.Line:
				if (_properties.InCombatAlready)
				{
					if (n == 1)
					{
						this.spawnEntitiesInFormation(f.Entities, n, -5, 0);
					}
					else
					{
						this.spawnEntitiesInFormation(f.Entities, n, 0, 7);
					}
				}
				else
				{
					this.spawnEntitiesInFormation(f.Entities, n);
				}

				break;

			case this.Const.Tactical.DeploymentType.Camp:
				this.spawnEntitiesAtCamp(f.Entities, shiftX, shiftY);
				break;

			case this.Const.Tactical.DeploymentType.LineBack:
				if (f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineForward)
				{
					this.spawnEntitiesInFormation(f.Entities, n, 8 + shiftX);
				}
				else if (f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineCenter)
				{
					this.spawnEntitiesInFormation(f.Entities, n, 3 + shiftX);
				}
				else if (!f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineForward)
				{
					this.spawnEntitiesInFormation(f.Entities, n, -10 - shiftX);
				}
				else
				{
					this.spawnEntitiesInFormation(f.Entities, n, -10 + shiftX);
				}

				break;

			case this.Const.Tactical.DeploymentType.LineCenter:
				if (f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineForward)
				{
					this.spawnEntitiesInFormation(f.Entities, n, 8 + shiftX);
				}
				else if (!f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineForward)
				{
					this.spawnEntitiesInFormation(f.Entities, n, 3 - shiftX);
				}
				else
				{
					this.spawnEntitiesInFormation(f.Entities, n, 3 + shiftX);
				}
				break;

			case this.Const.Tactical.DeploymentType.Arena:
				this.spawnEntitiesInFormation(f.Entities, n, 3, -3);
				break;

			case this.Const.Tactical.DeploymentType.Center:
				this.spawnEntitiesAtCenter(f.Entities);
				break;

			case this.Const.Tactical.DeploymentType.Random:
				this.spawnEntitiesRandomly(f.Entities);
				break;

			case this.Const.Tactical.DeploymentType.Circle:
				this.spawnEntitiesInCircle(f.Entities);
				break;
			}
		}

		if (_properties.EnemyDeploymentCallback != null)
		{
			_properties.EnemyDeploymentCallback();
		}

		this.m.IsLineVSLine = _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line && _properties.EnemyDeploymentType == this.Const.Tactical.DeploymentType.Line;

		if (!this.Tactical.State.isScenarioMode() && !_properties.IsPlayerInitiated && !_properties.InCombatAlready)
		{
			foreach( i, s in this.m.Strategies )
			{
				if (!this.World.FactionManager.isAllied(this.Const.Faction.Player, i))
				{
					s.setIsAttackingOnWorldmap(true);
				}
			}
		}

		if(this.m.IsLineVSLine && !this.Tactical.State.isScenarioMode())
		{
			local friendlyRanged = false, enemyRanged = false;
				for( local i = this.Const.Faction.Player; i != this.m.Instances.len(); i = ++i )
					{
					if(this.m.Instances[i].len() == 0) continue; // most factions are empty
						local friendly = i == this.Const.Faction.Player || this.World.FactionManager.isAlliedWithPlayer(i);
						if(!(friendly ? friendlyRanged : enemyRanged))
						{
						foreach(e in this.m.Instances[i])
							{
							if(e.isArmedWithRangedWeapon())
								{
								if(friendly) friendlyRanged = true;
								else enemyRanged = true;
								break;
								}
							}
						}
					}

			if(friendlyRanged || enemyRanged)
			{
				for( local i = this.Const.Faction.Player; i != this.m.Instances.len(); i = ++i )
				{
					if(this.m.Instances[i].len() == 0) continue; // most factions are empty
					local faction = this.World.FactionManager.getFaction(i);
					local factionType = faction != null ? faction.getType() : this.Const.FactionType.Player;
					if(factionType == this.Const.FactionType.Zombies || factionType == this.Const.FactionType.Orcs)
					{
						continue; // zombies are too dumb. orcs are too confident
					}
					else if(factionType == this.Const.FactionType.Bandits)
					{
						local hasLeader = false; // bandits are too undisciplined unless there's a leader
						foreach(e in this.m.Instances[i])
						if(e.getType() == this.Const.EntityType.BanditLeader)
						{
							hasLeader = true;
							break;
						}
						if(!hasLeader) continue;
					}
				}
			}
		}

		if (_properties.AfterDeploymentCallback != null)
		{
			_properties.AfterDeploymentCallback();
		}

		if (_properties.IsAutoAssigningBases)
		{
			this.assignBases();
		}

		this.makeEnemiesKnownToAI(_properties.InCombatAlready);

		if (this.World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			local roster = this.World.getPlayerRoster().getAll();
			local slaves = 0;
			local nonSlaves = 0;

			foreach( bro in roster )
			{
				if (!bro.isPlacedOnMap())
				{
					continue;
				}

				if (bro.getBackground().getID() == "background.slave")
				{
					slaves = ++slaves;
				}
				else
				{
					nonSlaves = ++nonSlaves;
				}
			}

			if (slaves <= nonSlaves)
			{
				foreach( bro in roster )
				{
					if (!bro.isPlacedOnMap())
					{
						continue;
					}

					if (bro.getBackground().getID() != "background.slave")
					{
						bro.worsenMood(this.Const.MoodChange.TooFewSlavesInBattle, "Too few indebted in battle");
					}
				}
			}
		}

		foreach( player in this.m.Instances[this.Const.Faction.Player] )
		{
			player.onCombatStart();
		}

		this.Math.seedRandom(this.Time.getRealTime());
	}

	o.placePlayersInFormation = function ( _players, _offsetX = 0, _offsetY = 0 )
	{
		for( local x = 11 + _offsetX; x <= 14 + _offsetX; x = ++x )
		{
			for( local y = 10; y <= 20 + _offsetY; y = ++y )
			{
				this.Tactical.getTile(x, y - x / 2).removeObject();
			}
		}

		local positions = [];
		positions.resize(27 ,0);

		foreach( e in _players )
		{
			local p = e.getPlaceInFormation();
			if (positions[p] == 1)
			{
				p += 9;
			}
			else
			{
				positions[p] = 1;
			}

			local x = 13 - p / 9 + _offsetX;
			local y = 30 - (11 + p - p / 9 * 9) + _offsetY;
			local tile = this.Tactical.getTileSquare(x, y);

			if (!tile.IsEmpty)
			{
				tile.removeObject();
			}

			if (this.isTileIsolated(tile))
			{
				local avg = 0;

				for( local x = 0; x < 6; x = ++x )
				{
					if (tile.hasNextTile(x))
					{
						avg = avg + tile.getNextTile(x).Level;
					}
				}

				tile.Level = avg / 6;
			}

			this.Tactical.addEntityToMap(e, tile.Coords.X, tile.Coords.Y);

			if (!this.World.getTime().IsDaytime && e.getBaseProperties().IsAffectedByNight)
			{
				::Legends.Effects.grant(e, ::Legends.Effect.Night);
			}

			if (this.Tactical.getWeather().IsRaining && e.getBaseProperties().IsAffectedByRain)
			{
				::Legends.Effects.grant(e, ::Legends.Effect.LegendRain);
			}
		}
	}

	o.isTileIsolated = function( _tile )
	{
		local isCompletelyIsolated = true;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_tile.hasNextTile(i))
			{
				continue
			}

			if (_tile.getNextTile(i).IsEmpty && this.Math.abs(_tile.Level - _tile.getNextTile(i).Level) <= 1)
			{
				isCompletelyIsolated = false;
				break;
			}
		}

		if (isCompletelyIsolated)
		{
			return true;
		}

		local size = this.Tactical.getMapSize();

		if (_tile.Level == 0 && this.Tactical.getTileSquare(0, 0).Level == 3 && this.Tactical.getTileSquare(size.X - 1, size.Y - 1).Level == 3 && this.Tactical.getTileSquare(0, size.Y - 1).Level == 3 && this.Tactical.getTileSquare(size.X - 1, 0).Level == 3)
		{
			return false;
		}

		local allFactions = [];
		allFactions.resize(128, 0); //Yuck, we have this dynamic throughout the code, but not sure how to get that dynamic here

		for( local i = 0; i != 128; i = ++i )
		{
			allFactions[i] = i;
		}

		local navigator = this.Tactical.getNavigator();
		local settings = navigator.createSettings();
		settings.ActionPointCosts = this.Const.SameMovementAPCost;
		settings.FatigueCosts = this.Const.PathfinderMovementFatigueCost;
		settings.AllowZoneOfControlPassing = true;
		settings.AlliedFactions = allFactions;

		if (!navigator.findPath(_tile, this.Tactical.getTileSquare(0, 0), settings, 1) && !navigator.findPath(_tile, this.Tactical.getTileSquare(size.X - 1, size.Y - 1), settings, 1) && !navigator.findPath(_tile, this.Tactical.getTileSquare(0, size.Y - 1), settings, 1) && !navigator.findPath(_tile, this.Tactical.getTileSquare(size.X - 1, 0), settings, 1))
		{
			return true;
		}

		return false;
	}

	o.resurrect = function ( _info, _delay = 0 )
	{
		if (_info.Type == "")
			return;

		if (!this.MSU.Tile.canResurrectOnTile(_info.Tile, true))
		{
			return;
		}

		if (_info.Tile.IsVisibleForPlayer)
		{
			this.Tactical.CameraDirector.addMoveToTileEvent(_delay, _info.Tile, -1, this.onResurrect.bindenv(this), _info, this.Const.Tactical.Settings.CameraWaitForEventDelay, this.Const.Tactical.Settings.CameraNextEventDelay);
			this.Tactical.CameraDirector.addDelay(1.5);
		}
		else
		{
			this.onResurrect(_info);

			if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().isPlayerControlled())
			{
				this.Tactical.TurnSequenceBar.getActiveEntity().setDirty(true);
			}
		}
	}

	local onResurrect = o.onResurrect;
	o.onResurrect = function( _info, _force = false )
	{
		// holyflame stop the ressurection
		if (_info.Tile.Properties.Effect != null && _info.Tile.Properties.Effect.Type == "legend_holyflame") {
			if (_info.Tile.IsVisibleForPlayer)
				this.Tactical.EventLog.log("The simmering holy flame stops the dead from raising back to life again.");

			return null;
		}

		return onResurrect(_info, _force);
	}

	local setupEntity = o.setupEntity;
	o.setupEntity = function( _e, _t )
	{
		setupEntity( _e, _t );
		if (("Outfits") in _t) { //this is mostly only used for free companies currently, I'll admit I just can't think of a better way to do these
			_e.m.Outfits = _t.Outfits;
		}
		::Legends.Scaling.scaleEnemy(_e, _t);
	}

	local getHostilesNum = o.getHostilesNum;
	o.getHostilesNum = function() {
		/** Part of lindwurm fix, that makes them count as one enemy in battle by ignoring entities with 'tail' flag */
		local count = getHostilesNum();
		if (!::Tactical.State.isScenarioMode()) {
			for (local i = 0; i != ::World.FactionManager.getFactions().len(); i++) {
				if (!::World.FactionManager.isAlliedWithPlayer(i)) {
					for (local j = 0; j != this.m.Instances[i].len(); j++) {
						if (this.m.Instances[i][j].getFlags().has("tail")) {
							count -= 1;
						}
					}
				}
			}
		}
		return count;
	}
});
