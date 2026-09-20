::mods_hookExactClass("states/tactical_state", function(o) {
	o.m.TilesReservedForTeleport <- {};

	local setPause = o.setPause;
	o.setPause = function (_f) {
		setPause(_f);
		if (!_f) {
			::Time.setVirtualSpeed(::Const.Tactical.Settings.AnimationSpeed);
		}
	}

	o.onCancelQuitToMainMenu = function() {
		::Tactical.State.setPause(false);
	}

	o.swapToItem <- function ( _activeEntity, _item )
	{
		if (this.m.CurrentActionState != null)
		{
			this.cancelEntitySkill(_activeEntity);
		}

		this.m.CharacterScreen.onEquipBagItem([
			_activeEntity.getID(),
			_item.getInstanceID()
		]);
		_activeEntity.getSkills().update();
		_activeEntity.setDirty(true);
	}

	local _turnsequencebar_onEntitySkillClicked = o.turnsequencebar_onEntitySkillClicked;
	o.turnsequencebar_onEntitySkillClicked = function ( _skillId )
	{
		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();

		if (activeEntity == null || activeEntity.getSkills().hasSkill(_skillId))
		{
			_turnsequencebar_onEntitySkillClicked(_skillId);
		}
		else if (!this.isInputLocked())
		{
			local item = activeEntity.getItems().getItemByInstanceID(_skillId);

			if (item != null)
			{
				this.swapToItem(activeEntity, item);
			}
		}
	}

	local _setActionStateBySkillIndex = o.setActionStateBySkillIndex;
	o.setActionStateBySkillIndex = function ( _index )
	{
		if (this.m.CurrentActionState != null)
		{
			switch(this.m.CurrentActionState)
			{
			case ::Const.Tactical.ActionState.TravelPath:
				::logInfo("entity is currently travelling!");
				return;

			case ::Const.Tactical.ActionState.ExecuteSkill:
				::logInfo("entity is currently executing a skill!");
				return;
			}
		}

		local e = ::Tactical.TurnSequenceBar.getActiveEntity();
		local itemIndex = -1;

		if (e != null && !this.isInputLocked())
		{
			itemIndex = _index - e.getSkills().queryActives().len();
		}

		if (itemIndex >= 0)
		{
			local items = e.querySwitchableItems();

			if (itemIndex < items.len())
			{
				this.swapToItem(e, items[itemIndex]);
			}
		}
		else
		{
			_setActionStateBySkillIndex(_index);
		}
	};

	o.computeEntityPath = function(_activeEntity, _mouseEvent) {
		if (this.m.IsGameFinishable && this.isBattleEnded() || this.wasInCameraMovementMode()) {
			return;
		}

		this.m.LastTileSelected = ::Tactical.getTile(::Tactical.screenToTile(_mouseEvent.getX(), _mouseEvent.getY()));

		if (!this.m.LastTileSelected.IsDiscovered || _activeEntity.getCurrentProperties().IsRooted)	{
			this.Cursor.setCursor(::Const.UI.Cursor.Denied);
			return;
		}

		if (this.m.LastTileSelected.ID == _activeEntity.getTile().ID) {
			this.Cursor.setCursor(::Const.UI.Cursor.Denied);
			::Tactical.getNavigator().clearVisualisation();
			::Tactical.getHighlighter().clear();
			::Tactical.TurnSequenceBar.resetActiveEntityCostsPreview();
			this.m.CurrentActionState = null;
			return;
		}

		this.m.CurrentActionState = ::Const.Tactical.ActionState.ComputePath;
		local settings = ::Tactical.getNavigator().createSettings();
		settings.ActionPointCosts = _activeEntity.getActionPointCosts();
		local properties = _activeEntity.getCurrentProperties();
		local realMovementCostsForPreview = _activeEntity.getFatigueCosts();
		foreach (i, val in realMovementCostsForPreview) {
			realMovementCostsForPreview[i] = ::Math.round(val * properties.FatigueEffectMult);
		}
		settings.FatigueCosts = realMovementCostsForPreview; // set preview fat costs so it includes fat reduction/increase effects
		settings.FatigueCostFactor = ::Const.Movement.FatigueCostFactor;
		settings.ActionPointCostPerLevel = _activeEntity.getLevelActionPointCost();
		settings.FatigueCostPerLevel = _activeEntity.getLevelFatigueCost();
		settings.ZoneOfControlCost = 4;
		settings.AlliedFactions = _activeEntity.getAlliedFactions();
		settings.Faction = _activeEntity.getFaction();
		settings.AllowZoneOfControlPassing = true;
		settings.IsPlayer = true;

		local athletic = {
			skill = _activeEntity.getSkills().getSkillByID(::Legends.Traits.getID(::Legends.Trait.Athletic)),
			bonusAP = 0,
			bonusFat = 0
		};

		local targetTileType = _activeEntity.getTile().Type;
		if (::Tactical.getNavigator().findPath(_activeEntity.getTile(), this.m.LastTileSelected, settings, 0)) {
			targetTileType = ::Tactical.getNavigator().getCostForPath(_activeEntity, settings, 0, 0).First.Type; // mockup movement test only to determine the first tiles' cost
		}

		if (athletic.skill != null && !athletic.skill.m.HasMoved) {
			athletic.bonusAP = ::Math.max(0, (_activeEntity.getActionPointCosts()[targetTileType] * properties.MovementAPCostMult));
			athletic.bonusFat = ::Math.max(0, (_activeEntity.getFatigueCosts()[targetTileType] * properties.MovementFatigueCostMult * properties.FatigueEffectMult));
			if (_activeEntity.getFatigue() - athletic.bonusFat < 0) {
				athletic.bonusFat += _activeEntity.getFatigue() - athletic.bonusFat; // read the temporary fat reduced if close to 0, so we don't add any when the bro is at less than movement cost
			}
			_activeEntity.setActionPoints(_activeEntity.getActionPoints() + athletic.bonusAP); //add temporary stats to fool the prediction
			_activeEntity.setFatigue(::Math.max(0, _activeEntity.getFatigue() - athletic.bonusFat));
		}

		if (::Tactical.getNavigator().findPath(_activeEntity.getTile(), this.m.LastTileSelected, settings, 0)) {
			this.Cursor.setCursor(::Const.UI.Cursor.Boot);
			::Tactical.getNavigator().buildVisualisation(_activeEntity, settings, _activeEntity.getActionPoints(), _activeEntity.getFatigueMax() - _activeEntity.getFatigue());
			::Tactical.getHighlighter().clear();
			::Tactical.getHighlighter().highlightZoneOfControl(_activeEntity.getAlliedFactions());
			settings.ZoneOfControlCost = 0;
			local movementCosts = ::Tactical.getNavigator().getCostForPath(_activeEntity, settings, _activeEntity.getActionPoints(), _activeEntity.getFatigueMax() - _activeEntity.getFatigue());

			if (movementCosts.Tiles != 0) {
				::Tactical.TurnSequenceBar.setActiveEntityCostsPreview(movementCosts);
			} else {
				::Tactical.TurnSequenceBar.flashProgressbars(movementCosts.IsMissingActionPoints, movementCosts.IsMissingFatigue);
			}
		} else {
			this.Cursor.setCursor(::Const.UI.Cursor.Denied);
			::Tactical.getNavigator().clearVisualisation();
			::Tactical.getHighlighter().clear();
			::Tactical.TurnSequenceBar.resetActiveEntityCostsPreview();
			this.m.CurrentActionState = null;
		}
		settings.FatigueCosts = _activeEntity.getFatigueCosts(); // reset preview fat costs for executeEntityTravel below to use so its not applied twice
		if (athletic.skill != null && !athletic.skill.m.HasMoved) {
			_activeEntity.setActionPoints(_activeEntity.getActionPoints() - athletic.bonusAP); // reset temporary stats after engine's prediction
			_activeEntity.setFatigue(_activeEntity.getFatigue() + athletic.bonusFat);
		}
	}

	o.executeEntityTravel = function(_activeEntity, _mouseEvent) {
		if (this.wasInCameraMovementMode()) {
			return;
		}

		local tile = ::Tactical.getTile(::Tactical.screenToTile(_mouseEvent.getX(), _mouseEvent.getY()));

		if (::Tactical.getNavigator().HasValidPath && this.m.LastTileSelected.X == tile.X && this.m.LastTileSelected.Y == tile.Y) {
			local athletic = {
				skill = _activeEntity.getSkills().getSkillByID(::Legends.Traits.getID(::Legends.Trait.Athletic)),
				bonusAP = 0,
				bonusFat = 0,
				buffApplied = false
			};

			if (athletic.skill != null && !athletic.skill.m.HasMoved) {
				local targetTileType = _activeEntity.getTile().Type;
				targetTileType = ::Tactical.getNavigator().getCostForPath(_activeEntity, ::Tactical.getNavigator().getLastSettings(), 0, 0).First.Type; // mockup movement test only to determine the first tiles' cost
				
				local properties = _activeEntity.getCurrentProperties();
				athletic.bonusAP = ::Math.max(0, (_activeEntity.getActionPointCosts()[targetTileType] * properties.MovementAPCostMult));
				athletic.bonusFat = ::Math.max(0, (_activeEntity.getFatigueCosts()[targetTileType] * properties.MovementFatigueCostMult * properties.FatigueEffectMult));
				if (_activeEntity.getFatigue() - athletic.bonusFat < 0) {
					athletic.bonusFat += _activeEntity.getFatigue() - athletic.bonusFat; // read the temporary fat reduced if close to 0, so we don't add any when the bro is at less than movement cost
				}
				_activeEntity.setActionPoints(_activeEntity.getActionPoints() + athletic.bonusAP);
				_activeEntity.setFatigue(::Math.max(0, _activeEntity.getFatigue() - athletic.bonusFat));
				athletic.buffApplied = true;
			}

			local movementCosts = ::Tactical.getNavigator().getCostForPath(_activeEntity, ::Tactical.getNavigator().getLastSettings(), _activeEntity.getActionPoints(), _activeEntity.getFatigueMax() - _activeEntity.getFatigue());

			if (movementCosts.Tiles != 0) {
				this.Cursor.setCursor(::Const.UI.Cursor.Hourglass);
				this.m.CurrentActionState = ::Const.Tactical.ActionState.TravelPath;
				this.m.ActiveEntityNeedsUpdate = true;
				::Tactical.getNavigator().clearVisualisation();
				::Tactical.getHighlighter().clear();
				::Tactical.getShaker().cancel(_activeEntity);

				if (::Tactical.getCamera().Level < tile.Level) {
					::Tactical.getCamera().Level = tile.Level;
				}

				if (athletic.buffApplied) {
					if (this.m.CurrentActionState == ::Const.Tactical.ActionState.TravelPath) {
						athletic.skill.m.HasMoved = true;
					} else {
						_activeEntity.setActionPoints(_activeEntity.getActionPoints() - athletic.bonusAP); // most likely unnecessary, but just in case the move didn't happen
						_activeEntity.setFatigue(_activeEntity.getFatigue() + athletic.bonusFat);
					}
				}
			}
		} else {
			this.computeEntityPath(_activeEntity, _mouseEvent);
		}
	}

	o.onProcessAI = function() {
		if (::Tactical.State == null || ::Tactical.State.isBattleEnded())	{
			return;
		}

		local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();

		if (activeEntity != null && activeEntity.getAIAgent().isEvaluating()) {
			if (::Time.getVirtualTime() < activeEntity.getAIAgent().m.NextEvaluationTime) {
            	return;
        	}

			activeEntity.getAIAgent().think(true);
		}
	}

	o.onBattleEnded = function()
	{
		if (this.m.IsExitingToMenu)
		{
			return;
		}

		this.m.IsBattleEnded = true;
		local isVictory = ::Tactical.Entities.getCombatResult() == ::Const.Tactical.CombatResult.EnemyDestroyed || ::Tactical.Entities.getCombatResult() == ::Const.Tactical.CombatResult.EnemyRetreated;
		this.m.IsFogOfWarVisible = false;
		::Tactical.fillVisibility(::Const.Faction.Player, true);
		::Tactical.getCamera().zoomTo(2.0, 1.0);
		this.Tooltip.hide();
		this.m.TacticalScreen.hide();
		::Tactical.OrientationOverlay.removeOverlays();

		if (isVictory)
		{
			this.Music.setTrackList(::Const.Music.VictoryTracks, ::Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsAttackingLocation)
				{
					::World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnVictoryVSLocation);
					if (::World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves")
					{
						::World.Statistics.getFlags().set("LastBattleWasLocation", true);
						local findCaptiveChance = 15;

						if (::World.Statistics.getFlags().getAsInt("LastCombatFaction") == ::World.FactionManager.getFactionOfType(::Const.FactionType.OrientalBandits).getID()) {
							findCaptiveChance += 10;
						} else if (::World.Statistics.getFlags().getAsInt("LastCombatFaction") == ::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getID()) {
							findCaptiveChance -= 10;
						}

						if (::Math.rand(1, 100) <= findCaptiveChance)
						{
							::World.Statistics.getFlags().set("FindCaptivePostBattle", true);
						}
						else
						{
							::World.Statistics.getFlags().set("FindCaptivePostBattle", false);
						}
					}
				}
				else
				{
					::World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnVictory);
					if (::World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves")
					{
						::World.Statistics.getFlags().set("LastBattleWasLocation", false);
						::World.Statistics.getFlags().set("FindCaptivePostBattle", false);
					}
				}

				::World.Contracts.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				::World.Events.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				::World.Statistics.getFlags().set("LastPlayersAtBattleStartCount", this.m.MaxPlayers);
				::World.Statistics.getFlags().set("LastEnemiesDefeatedCount", this.m.MaxHostiles);
				::World.Statistics.getFlags().set("LastCombatResult", 1);
				::World.Statistics.getFlags().increment("BattlesWon");
				if (::World.Statistics.getFlags().getAsInt("LastCombatFaction") == ::World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID())
				{
					::World.Statistics.getFlags().increment("BeastsDefeated");
				}
				::World.Assets.getOrigin().onBattleWon(this.m.CombatResultLoot);

				local playerRoster = ::World.getPlayerRoster().getAll();
				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						bro.getSkills().onDeath(::Const.FatalityType.Devoured);
						bro.onDeath(null, null, null, ::Const.FatalityType.Devoured);
						::World.getPlayerRoster().remove(bro);
					}

					else if (bro.getSkills().hasPerk(::Legends.Perk.LegendPacifist) && bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;
					}

					else if (this.m.StrategicProperties.IsUsingSetPlayers && bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;

						if (this.m.StrategicProperties.IsArenaMode)
						{
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a fight in the arena");
						}
						else
						{
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a battle");
						}
					}

					else if (!this.m.StrategicProperties.IsUsingSetPlayers)
					{
						if (bro.isPlacedOnMap())
						{
							bro.getLifetimeStats().BattlesWithoutMe = 0;
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a battle");
						}
						else if (bro.getMoodState() > ::Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && ::World.Assets.m.ProfessionEffect.LegendBreadAndGames <= 0)
						{
							++bro.getLifetimeStats().BattlesWithoutMe;

							if (bro.getLifetimeStats().BattlesWithoutMe > ::Math.max(2, 6 - bro.getLevel()))
							{
								bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
							}
						}
					}
					bro.getFlags().remove("TemporaryRider");
				}
			}
		}
		else
		{
			this.Music.setTrackList(::Const.Music.DefeatTracks, ::Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				local playerRoster = ::World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						if (bro.isAlive())
						{
							bro.getSkills().onDeath(::Const.FatalityType.Devoured);
							bro.onDeath(null, null, null, ::Const.FatalityType.Devoured);
							::World.getPlayerRoster().remove(bro);
						}
					}
					else if (bro.isPlacedOnMap() && (bro.getFlags().get("Charmed") == true || bro.getFlags().get("Sleeping") == true || bro.getFlags().get("Nightmare") == true))
					{
						if (bro.isAlive())
						{
							bro.kill(null, null, ::Const.FatalityType.Suicide);
						}
					}
					else if (bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;

						if (::Tactical.getCasualtyRoster().getSize() != 0)
						{
							bro.worsenMood(::Const.MoodChange.BattleLost, "Lost a battle");
						}
						else if (::World.Assets.getOrigin().getID() != "scenario.deserters")
						{
							bro.worsenMood(::Const.MoodChange.BattleRetreat, "Retreated from battle");
						}
					}
					else if (bro.getMoodState() > ::Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && (!bro.getFlags().has("TemporaryRider") || !bro.getFlags().has("IsHorse")))
					{
						++bro.getLifetimeStats().BattlesWithoutMe;

						if (bro.getLifetimeStats().BattlesWithoutMe > ::Math.max(2, 6 - bro.getLevel()))
						{
							bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
						}
					}
					bro.getFlags().remove("TemporaryRider");
				}

				if (::World.getPlayerRoster().getSize() != 0)
				{
					::World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnLoss);
					::World.Contracts.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
					::World.Events.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
					::World.Statistics.getFlags().set("LastEnemiesDefeatedCount", 0);
					::World.Statistics.getFlags().set("LastCombatResult", 2);
				}
			}
		}

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			::Sound.play(::Const.Sound.ArenaEnd[::Math.rand(0, ::Const.Sound.ArenaEnd.len() - 1)], ::Const.Sound.Volume.Tactical);
			::Time.scheduleEvent(::TimeUnit.Real, 4500, function ( _t )
			{
				::Sound.play(::Const.Sound.ArenaOutro[::Math.rand(0, ::Const.Sound.ArenaOutro.len() - 1)], ::Const.Sound.Volume.Tactical);
			}, null);
		}

		this.gatherBrothers(isVictory);
		this.gatherLoot();
		::Time.scheduleEvent(::TimeUnit.Real, 800, this.onBattleEndedDelayed.bindenv(this), isVictory);
	}

	o.onBattleEndedDelayed = function ( _isVictory )
	{
		if (this.m.MenuStack.hasBacksteps())
		{
			::Time.scheduleEvent(::TimeUnit.Real, 50, this.onBattleEndedDelayed.bindenv(this), _isVictory);
			return;
		}

		if (this.m.IsGameFinishable)
		{
			this.Tooltip.hide();
			this.m.TacticalCombatResultScreen.show();
			this.Cursor.setCursor(::Const.UI.Cursor.Hand);
			this.m.MenuStack.push(function ()
			{
				if (this.m.TacticalCombatResultScreen != null)
				{
					if (_isVictory && !::Tactical.State.isScenarioMode() && this.m.StrategicProperties != null && (!this.m.StrategicProperties.IsLootingProhibited || this.m.StrategicProperties.IsArenaMode && !this.m.CombatResultLoot.isEmpty()) && this.Settings.getGameplaySettings().AutoLoot)
					{
						this.m.TacticalCombatResultScreen.onLootAllItemsButtonPressed();
						::World.Assets.consumeItems();
						::World.Assets.refillAmmo();
						::World.Assets.updateAchievements();
						::World.Assets.checkAmbitionItems();
						::World.State.updateTopbarAssets();
					}

					if ("Camp" in ::World && ::World.Camp != null)
					{
						::World.Camp.assignRepairs();
					}

					this.m.TacticalScreen.show();
					this.m.TacticalCombatResultScreen.hide();
				}
			}, function ()
			{
				return false;
			});
		}
	}

	o.returnBrokenNetToOwner <- function()
	{
		local bros = {};

		if (::Tactical.Entities.m.NetTiles.len() > 0) {
			foreach (bro in ::World.getPlayerRoster().getAll())
			{
				bros[bro.getID()] <- bro;
			}
		}

		foreach (_, tile in ::Tactical.Entities.m.NetTiles)
		{
			if (!tile.IsContainingItems) continue;

			for (local i = tile.Items.len() - 1; i >= 0; --i)
			{
				local item = tile.Items[i];

				if (!item.isItemType(::Const.Items.ItemType.Net) || item.m.OwnerID == null)
					continue;

				if (!(item.m.OwnerID in bros))
					continue;

				local success = false;

				if (bros[item.m.OwnerID].getItems().equip(item))
					success = true;

				if (!success)
					success = bros[item.m.OwnerID].getItems().addToBag(item);

				if (success)
					tile.Items.remove(i).m.OwnerID = null;
			}

			tile.IsContainingItems = tile.Items.len() > 0;
		}

		::Tactical.Entities.m.NetTiles = {};
	}

	o.gatherLoot = function() {
		local playerKills = 0;

		foreach( bro in this.m.CombatResultRoster )	{
			playerKills = playerKills + bro.getCombatStats().Kills;
		}

		if (!this.isScenarioMode())	{
			this.returnBrokenNetToOwner();
			::World.Statistics.getFlags().set("LastCombatKills", playerKills);
		}

		local isArena = !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode;
		if (!isArena && !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsLootingProhibited)
			return;

		//local CannibalsInRoster = 0; // unused
		
		local corpseSalvageThreshold = 10;
		local zombieLoot = false;
		local skeletonLoot = false;

		local livingBrothers = ::World.getPlayerRoster().getAll().filter(@(_, _bro) (_bro.isAlive()));
		local CannibalisticButchersInRoster = livingBrothers.filter(@(_, _bro) (::Legends.Backgrounds.has(_bro, ::Legends.Background.Butcher) && ::Legends.Traits.has(_bro, ::Legends.Trait.LegendCannibalistic))).len();
		
		foreach (bro in livingBrothers)	{
			if (::Legends.Backgrounds.hasAny(bro, ::Legends.Background.Gravedigger,	::Legends.Background.Graverobber)) {
				corpseSalvageThreshold += 5;
			}

			if (::Legends.Perks.has(bro, ::Legends.Perk.LegendReclamation)) {
				corpseSalvageThreshold += ::Legends.Perks.get(bro, ::Legends.Perk.LegendReclamation).m.LootChance;
			}

			if (::Legends.Perks.has(bro, ::Legends.Perk.LegendResurrectionist)) {
				corpseSalvageThreshold += ::Legends.Perks.get(bro, ::Legends.Perk.LegendResurrectionist).m.LootChance;
			}

			if (::Legends.Perks.hasAny(bro, ::Legends.Perk.LegendSpawnZombieLow, ::Legends.Perk.LegendSpawnZombieMed, ::Legends.Perk.LegendSpawnZombieHigh)) {
				zombieLoot = true;
			}
		}

		local loot = [];

		local alive = ::Tactical.Entities.getAllInstancesAsArray();
		foreach (actor in alive) {
			if (!::Legends.S.isEntityNullOrDead(actor) && actor.getFaction() == ::Const.Faction.PlayerAnimals && actor.getType() == ::Const.EntityType.ZombieYeoman) {
				local eligibleItems = actor.getItems().getAllItems().filter(@(_,_item) (!isArena || _item.getLastEquippedByFaction() == 1));
				foreach(item in eligibleItems) {
					item.onCombatFinished();
					if (!item.isChangeableInBattle() && item.isDroppedAsLoot()) {
						if (item.getCondition() > 1 && item.getConditionMax() > 1 && item.getCondition() > item.getConditionMax() * 0.66 && ::Math.rand(1, 100) <= 66) {
							item.setCondition(::Math.minf(item.getCondition(), ::Math.rand(::Math.maxf(10, item.getConditionMax() * 0.35 + ::World.Assets.m.ProfessionEffect.LegendMaterialist), item.getConditionMax())));
						}

						item.removeFromContainer();
						foreach (i in item.getLootLayers()) {
							loot.push(i);
						}
					}
				}
			}
		}

		local size = ::Tactical.getMapSize();

		for( local x = 0; x < size.X; x = ++x )	{
			for( local y = 0; y < size.Y; y = ++y )	{
				local tile = ::Tactical.getTileSquare(x, y);
				if (tile.IsContainingItems) {
					local eligibleItems = tile.Items.filter(@(_,_item) (!isArena || _item.getLastEquippedByFaction() == 1));
					foreach( item in eligibleItems ) {
						item.onCombatFinished();
						loot.push(item);
					}
				}

				if(tile.Properties.has("Corpse") && tile.Properties.get("Corpse").isHuman == 1) {
					if (zombieLoot && ::Math.rand(1, 100) <= corpseSalvageThreshold) { // tile.Properties.get("Corpse").isHuman == 2 used to be an alternative, but its some unused bs?
						loot.push(::new("scripts/items/spawns/legend_zombie_item"));
					}

					//if (zombieLoot && tile.Properties.has("Corpse") && tile.Properties.get("Corpse").isHuman == 1 && ::Math.rand(1, 100) <= corpseSalvageThreshold) { // tile.Properties.get("Corpse").isHuman == 3 used to be an alternative, but its some unused bs?
					//	loot.push(::new("scripts/items/spawns/legend_skeleton_item")); //Removed until skeleton summoning is reworked into another origin - Luft 12/12/22
					//}

					if (::Math.rand(1, 100) <= 8) {
						if (CannibalisticButchersInRoster >= 1)	{
							local humanMeat = ::new("scripts/items/supplies/legend_yummy_sausages");
							humanMeat.randomizeAmount();
							humanMeat.randomizeBestBefore();
							loot.push(humanMeat);
						} /*else if (CannibalisticButchersInRoster < 1 && CannibalsInRoster >= 1)	{ // unused, cannibalsinroster is never set to anything else than 0
							local humanMeat = ::new("scripts/items/supplies/legend_human_parts");
							humanMeat.randomizeAmount();
							humanMeat.randomizeBestBefore();
							loot.push(humanMeat);
						}*/
					}
				}

				if (tile.Properties.has("Corpse") && tile.Properties.get("Corpse").Items != null && !tile.Properties.has("IsSummoned"))	{
					local eligibleItems = tile.Properties.get("Corpse").Items.getAllItems().filter(@(_,_item) (!isArena || _item.getLastEquippedByFaction() == 1));
					foreach( item in eligibleItems ) {
						item.onCombatFinished();
						if (!item.isChangeableInBattle() && item.isDroppedAsLoot())	{
							if (item.getCondition() > 1 && item.getConditionMax() > 1 && item.getCondition() > item.getConditionMax() * 0.66 && ::Math.rand(1, 100) <= 66) {
								item.setCondition(::Math.minf(item.getCondition(), ::Math.rand(::Math.maxf(10, item.getConditionMax() * (0.35 + ::World.Assets.m.ProfessionEffect.LegendMaterialist)), item.getConditionMax())));
							}

							item.removeFromContainer();
							foreach (i in item.getLootLayers())
							{
								loot.push(i);
							}
						}
					}
				}
			}
		}
		if (!isArena && this.m.StrategicProperties != null)	{
			local self = this;
			local eligibleParties = this.m.StrategicProperties.Parties.filter(@(_, _party)(_party.getTroops().len() == 0 && _party.isAlive() && !_party.isAlliedWithPlayer() && _party.isDroppingLoot() && (playerKills > 0 || self.m.IsDeveloperModeEnabled)));
			foreach(party in eligibleParties) {
				party.onDropLootForPlayer(loot);
			}

			foreach( item in this.m.StrategicProperties.Loot ) {
				loot.push(::new(item));
			}
		}

		if (!isArena && !this.isScenarioMode())	{
			if (::Tactical.Entities.getAmmoSpent() > 0 && ::World.Assets.m.ProfessionEffect.LegendAmmoScrounger > 0) {
				local amount = ::Math.max(1, ::Tactical.Entities.getAmmoSpent() * ::World.Assets.m.ProfessionEffect.LegendAmmoScrounger);
				amount = ::Math.rand(amount / 2, amount);

				if (amount > 0)	{
					local ammo = ::new("scripts/items/supplies/ammo_item");
					ammo.setAmount(amount);
					loot.push(ammo);
				}
			}

			if (::Tactical.Entities.getArmorParts() > 0 && ::World.Assets.m.ProfessionEffect.LegendVulture > 0) {
				local amount = ::Math.min(60, ::Math.max(1, ::Tactical.Entities.getArmorParts() * ::Const.World.Assets.ArmorPartsPerArmor * ::World.Assets.m.ProfessionEffect.LegendVulture));
				amount = ::Math.rand(amount / 2, amount);

				if (amount > 0)	{
					local parts = ::new("scripts/items/supplies/armor_parts_item");
					parts.setAmount(amount);
					loot.push(parts);
				}
			}
		}

		loot.extend(this.m.CombatResultLoot.getItems());
		this.m.CombatResultLoot.assign(loot);
		this.m.CombatResultLoot.sort();
	}

	o.gatherBrothers = function ( _isVictory )
	{
		this.m.CombatResultRoster = [];
		::Tactical.CombatResultRoster <- this.m.CombatResultRoster;
		local alive = ::Tactical.Entities.getAllInstancesAsArray();

		foreach( bro in alive )
		{
			if (bro.isAlive() && this.isKindOf(bro, "player"))
			{
				bro.onBeforeCombatResult();

				if (bro.isAlive() && !bro.isGuest() && bro.isPlayerControlled())
				{
					this.m.CombatResultRoster.push(bro);
				}
			}
		}

		local dead = ::Tactical.getCasualtyRoster().getAll();
		local survivor = ::Tactical.getSurvivorRoster().getAll();
		local retreated = ::Tactical.getRetreatRoster().getAll();
		local isArena = this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode;

		if (_isVictory || isArena)
		{
			foreach( s in survivor )
			{
				s.setIsAlive(true);
				s.onBeforeCombatResult();

				foreach( i, d in dead )
				{
					if (s.getID() == d.getOriginalID())
					{
						dead.remove(i);
						::Tactical.getCasualtyRoster().remove(d);
						break;
					}
				}
			}

			this.m.CombatResultRoster.extend(survivor);
		}
		else
		{
			foreach( bro in survivor )
			{
				::Legends.addFallen(bro, "Left to die");
				bro.getSkills().onDeath(::Const.FatalityType.None);
				::World.getPlayerRoster().remove(bro);
				bro.die();
			}
		}

		foreach( s in retreated )
		{
			s.onBeforeCombatResult();
		}

		this.m.CombatResultRoster.extend(retreated);
		this.m.CombatResultRoster.extend(dead);

		if (!this.isScenarioMode() && dead.len() > 1 && dead.len() >= this.m.CombatResultRoster.len() / 2)
		{
			this.updateAchievement("TimeToRebuild", 1, 1);
		}

		if (!this.isScenarioMode() && ::World.getPlayerRoster().getSize() == 0 && ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians) != null && this.m.Factions.getHostileFactionWithMostInstances() == ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians).getID())
		{
			this.updateAchievement("GiveMeBackMyLegions", 1, 1);
		}
	};

	local showRetreatScreen = o.showRetreatScreen;
	o.showRetreatScreen = function (_tag = null)
	{
		this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToAllowRetreat(true);
		return showRetreatScreen();
	}

	o.isEnemyRetreatDialogShown <- function ()
	{
		return this.m.IsEnemyRetreatDialogShown;
	}

	// todo same as vanilla, i've added it because vanilla line numbers are off, trying to catch turn_sequence_bar bug - chopeks
	o.turnsequencebar_onNextRound = function ( _round )
	{
		this.logDebug("INFO: Next round issued: " + _round);
		::Time.setRound(_round);

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			if (_round == 1) {
				::Sound.play(::Const.Sound.ArenaStart[::Math.rand(0, ::Const.Sound.ArenaStart.len() - 1)], ::Const.Sound.Volume.Tactical);
			}
			else {
				::Sound.play(::Const.Sound.ArenaNewRound[::Math.rand(0, ::Const.Sound.ArenaNewRound.len() - 1)], ::Const.Sound.Volume.Tactical * ::Const.Sound.Volume.Arena);
			}
		}
		else {
			::Sound.play(::Const.Sound.NewRound[::Math.rand(0, ::Const.Sound.NewRound.len() - 1)], ::Const.Sound.Volume.Tactical);
		}

		::Tactical.clearVisibility();

		if (!this.m.IsFogOfWarVisible) {
			::Tactical.fillVisibility(::Const.Faction.Player, true);
			::Tactical.fillVisibility(::Const.Faction.PlayerAnimals, true);
		}

		local heroes = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);

		foreach( hero in heroes ) {
			hero.updateVisibilityForFaction();
		}

		this.m.MaxPlayers = ::Math.max(this.m.MaxPlayers, heroes.len());

		local pets = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.PlayerAnimals);
		foreach( pet in pets ) {
			pet.updateVisibilityForFaction();
		}

		::Tactical.Entities.updateTileEffects();
		::Tactical.TopbarRoundInformation.update();
		this.m.MaxHostiles = ::Math.max(this.m.MaxHostiles, ::Tactical.Entities.getHostilesNum());
	}


	o.tactical_flee_screen_onFleePressed = function () {
		::Sound.play("sounds/retreat_01.wav", 0.75);

		if (this.isScenarioMode() || this.isEveryoneSafe()) {
			this.m.IsFleeing = true;
			this.m.MenuStack.pop();
			this.m.TacticalDialogScreen.hide();
			this.m.TacticalScreen.hide();
			::Time.clearEvents();
			this.setPause(true);
			this.flee();
		} else if (!this.m.IsAutoRetreat) {
			this.m.IsAutoRetreat = true;
			this.m.MenuStack.pop();
			this.Settings.getTempGameplaySettings().FasterPlayerMovement = true;
			this.Settings.getTempGameplaySettings().FasterAIMovement = true;
			::Tactical.getCamera().zoomTo(::Math.maxf(::Tactical.getCamera().Zoom, 1.5), 1.0);
			::Time.setVirtualSpeed(1.5 * ::Const.Tactical.Settings.AnimationSpeed);
			local alive = ::Tactical.Entities.getAllInstancesAsArray();

			foreach (bro in alive) {
				if (bro.isAlive() && this.isKindOf(bro, "player")) {
					if (bro.getSkills().hasEffect(::Legends.Effect.Charmed)) {
						local agent = bro.getSkills().getSkillByID(::Legends.Effects.getID(::Legends.Effect.Charmed)).m.OriginalAgent;
						agent.setUseHeat(true);
						agent.getProperties().BehaviorMult[::Const.AI.Behavior.ID.Retreat] = 1.0;
					} else if (bro.getSkills().hasEffect(::Legends.Effect.LegendIntenselyCharmed)) {
						local agent = bro.getSkills().getSkillByID(::Legends.Effects.getID(::Legends.Effect.LegendIntenselyCharmed)).m.OriginalAgent;
						agent.setUseHeat(true);
						agent.getProperties().BehaviorMult[::Const.AI.Behavior.ID.Retreat] = 1.0;
					} else {
						bro.getAIAgent().setUseHeat(true);
						bro.getAIAgent().getProperties().BehaviorMult[::Const.AI.Behavior.ID.Retreat] = 1.0;
					}

					::Tactical.TurnSequenceBar.updateEntity(bro.getID());
				}
			}

			local activeEntity = ::Tactical.TurnSequenceBar.getActiveEntity();

			if (activeEntity != null && activeEntity.isPlayerControlled()) {
				activeEntity.getAIAgent().setFinished(false);
			}

			this.updateCurrentEntity();
		}
	}

	local helper_handleContextualKeyInput = o.helper_handleContextualKeyInput;
	o.helper_handleContextualKeyInput = function (_key) {
		local ret = helper_handleContextualKeyInput(_key);
		if (_key.getState() != 0 || this.isInLoadingScreen() || this.isBattleEnded() || this.isInCharacterScreen() || this.m.MenuStack.hasBacksteps()) {
			return ret;
		}

		local key = _key.getKey();
		if (key >= 71 && key <= 74) {
			this.setTacticalSpeed((key - 70).tofloat());
			return true;
		}
		return ret;
	}

	o.setTacticalSpeed <- function (_speed) {
		::Const.Tactical.Settings.AnimationSpeed = _speed;
		this.m.TacticalScreen.getTurnSequenceBarModule().m.JSHandle.asyncCall("updateAnimationSpeed", ::Math.maxf(1.0, ::Const.Tactical.Settings.AnimationSpeed / 2));
		::Tactical.TopbarRoundInformation.updateSpeedButtons(_speed);
		if (!this.m.IsGamePaused) {
			if (this.m.IsAutoRetreat) {
				::Time.setVirtualSpeed(::Const.Tactical.Settings.AnimationSpeed * 1.5);
			} else {
				::Time.setVirtualSpeed(::Const.Tactical.Settings.AnimationSpeed);
			}
		}
	}

	o.spawnEffectOnTile = function( _tile, _effectType, _effect, _particles ) {
		if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == _effectType)	{
			_tile.Properties.Effect.Timeout = _effect.Timeout;
		} else {
			if (_tile.Properties.Effect != null) {
				::Tactical.Entities.removeTileEffect(_tile);
			}

			_tile.Properties.Effect = clone _effect;
			local spawnedParticles = [];

			foreach( particleInfo in _particles ) {
				spawnedParticles.push(::Tactical.spawnParticleEffect(particleInfo.Entity, particleInfo.Brushes, particleInfo.Tile, particleInfo.Delay, particleInfo.Quantity, particleInfo.Lifetime, particleInfo.Rate, particleInfo.Stages));
			}

			::Tactical.Entities.addTileEffect(_tile, _tile.Properties.Effect, spawnedParticles);
		}
	}

	o.createEffectParticles <- function (_tile, _particles, _entity = true) {
		local particles = [];

		for (local i = 0; i < _particles.len(); i++) {
			particles.push({
				Entity = _entity,
				Brushes = _particles[i].Brushes,
				Tile = _tile,
				Delay = _particles[i].Delay,
				Quantity = _particles[i].Quantity,
				Lifetime = _particles[i].LifeTimeQuantity,
				Rate = _particles[i].SpawnRate,
				Stages = _particles[i].Stages
			});
		}

		return particles;
	}

	o.spawnHolyFlameOnTile <- function (_tile, _user = null, _applyImmediately = true, _timeout = ::Const.Combat.LegendHolyFlameTimeout) {
		local effect = {
			Type = "legend_holyflame",
			Tooltip = "This is hallowed ground.\n\nAllies gain the Sanctified effect, becoming immune to injuries, bleeding, poison, and morale checks when taking damage.\n\nUndead and Cultists gain the Consecrated effect, dealing damage to them each turn and removing any immunity to injuries, bleeding, and being poisoned.\n\nAdditionally, Undead are unable to resurrect in the area while the flame is active.",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = true,
			IsByPlayer = _user != null ? _user.isPlayerControlled() : false,
			Timeout = ::Time.getRound() + _timeout,
			Callback = @(_tile, _entity) ::Const.Tactical.Common.onApplyHolyFlame(_tile, _entity, _user),
			Applicable = @(_a) true
		};

		::Tactical.State.spawnEffectOnTile(_tile, effect.Type, effect, this.createEffectParticles(_tile, ::Const.Tactical.HolyFlameParticles));

		if (_applyImmediately && _tile.IsOccupiedByActor) {
			effect.Callback(_tile, _tile.getEntity());
		}
	}

	o.spawnShadowMistOnTile <- function (_tile, _user = null, _applyImmediately = true, _timeout = ::Const.Combat.LegendShadowMistTimeout) {
		local effect = {
			Type = "legend_shadow_mist",
			Tooltip = "A pitch black mist lingers here, emanating bone chilling air from within.",
			IsPositive = true,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = true,
			IsByPlayer = false,
			Timeout = ::Time.getRound() + _timeout,
			Callback = @(_tile, _entity) ::Const.Tactical.Common.onApplyShadowMist(_tile, _entity),
			Applicable = @(_a) _a.getFlags().has("alp") || _a.getMoraleState != ::Const.MoraleState.Ignore
		};

		::Tactical.State.spawnEffectOnTile(_tile, effect.Type, effect, this.createEffectParticles(_tile, ::Const.Tactical.ShadowParticles));

		if (_applyImmediately && _tile.IsOccupiedByActor) {
			effect.Callback(_tile, _tile.getEntity());
		}
	}

	o.spawnMiasmaOnTile = function (_tile, _user = null, _applyImmediately = false, _timeout = ::Const.Combat.MiasmaTimeout) {
		local effect = {
			Type = "miasma",
			Tooltip = "Miasma lingers here, harmful to any living being",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _user != null ? _user.isPlayerControlled() : false,
			Timeout = ::Time.getRound() + _timeout,
			Callback = @(_tile, _entity) ::Const.Tactical.Common.onApplyMiasma(_tile, _entity, _user),
			Applicable = @(_a) !_a.getFlags().has("undead")
		};
		
		::Tactical.State.spawnEffectOnTile(_tile, effect.Type, effect, this.createEffectParticles(_tile, ::Const.Tactical.MiasmaParticles));

		if (_applyImmediately && _tile.IsOccupiedByActor) {
			effect.Callback(_tile, _tile.getEntity());
		}
	}

	o.spawnFireFirebombOnTile <- function (_tile, _user = null, _applyImmediately = false, _timeout = ::Const.Combat.FireTimeout, _restrictedTerrain = null) {
		local effect = {
			Type = "fire",
			Tooltip = "Fire rages here, melting armor and flesh alike.",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,			
			IsByPlayer = _user != null ? _user.isPlayerControlled() : false,
			Timeout = ::Time.getRound() + _timeout,
			Callback = @(_tile, _entity) ::Const.Tactical.Common.onApplyFire(_tile, _entity, _user),
			Applicable = @(_a) true
		};

		local restrictedTerrainSubtypes = _restrictedTerrain != null ? _restrictedTerrain : ::Tactical.Entities.getNonFlammableTileSubtypes();
		if (!::Legends.S.oneOf(_tile.Type, ::Const.Tactical.TerrainType.ShallowWater, ::Const.Tactical.TerrainType.DeepWater) && restrictedTerrainSubtypes.find(_tile.Subtype) == null){
			::Tactical.State.spawnEffectOnTile(_tile, effect.Type, effect, this.createEffectParticles(_tile, ::Const.Tactical.FireParticles));
			_tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
			_tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);
		}

		if (_applyImmediately && _tile.IsOccupiedByActor) {
			effect.Callback(_tile, _tile.getEntity());
		}
	}

	o.spawnFireRSWBlazingOnTile <- function (_tile, _effect = null, _applyImmediately = true, _timeout = null) {
		local user = _effect.getContainer().getActor();
		local effect = {
			Type = "fire_legend_rsw_blazing",
			Tooltip = "Runic fire rages here, melting armor and flesh alike.",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _effect != null ? user.isPlayerControlled() : false,
			Timeout = ::Time.getRound() + _effect.getItem().getRuneBonus2(),
			Damage = _effect.getItem().getRuneBonus1(),
			Callback = @(_tile, _entity) ::Const.Tactical.Common.onApplyFireRune(_tile, _entity, user),
			Applicable = @(_a) true
		};

		::Tactical.State.spawnEffectOnTile(_tile, effect.Type, effect, this.createEffectParticles(_tile, ::Const.Tactical.FireParticles));
		_tile.Properties.Effect.Damage = effect.Damage;
		_tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
		_tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);

		if (_applyImmediately && _tile.IsOccupiedByActor) {
			effect.Callback(_tile, _tile.getEntity());
		}
	}

	o.spawnFireFirefieldOnTile <- function (_tile, _user = null, _applyImmediately = true, _timeout = 3) {
		local effect = {
			Type = "fire_legend_firefield",
			Tooltip = "Magical fire rages here, melting armor and flesh alike.",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _user != null ? _user.isPlayerControlled() : false,
			Timeout = ::Time.getRound() + _timeout,
			Callback = @(_tile, _entity) ::Const.Tactical.Common.onApplyFire(_tile, _entity, _user),
			Applicable = @(_a) true
		};

		::Tactical.State.spawnEffectOnTile(_tile, effect.Type, effect, this.createEffectParticles(_tile, ::Const.Tactical.FireParticles));
		_tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
		_tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);

		if (_applyImmediately && _tile.IsOccupiedByActor) {
			local entity = _tile.getEntity();

			for (local i = 0; i < 2; ++i) {
				if (!::Legends.S.isEntityNullOrDead(entity)) {
					effect.Callback(_tile, entity);
				}
			}
		}
	}
});
