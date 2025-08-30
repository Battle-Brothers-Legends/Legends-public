::mods_hookExactClass("states/tactical_state", function(o)
{
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

	o.onBattleEnded = function()
	{
		if (this.m.IsExitingToMenu)
		{
			return;
		}

		this.m.IsBattleEnded = true;
		local isVictory = this.Tactical.Entities.getCombatResult() == this.Const.Tactical.CombatResult.EnemyDestroyed || this.Tactical.Entities.getCombatResult() == this.Const.Tactical.CombatResult.EnemyRetreated;
		this.m.IsFogOfWarVisible = false;
		this.Tactical.fillVisibility(this.Const.Faction.Player, true);
		this.Tactical.getCamera().zoomTo(2.0, 1.0);
		this.Tooltip.hide();
		this.m.TacticalScreen.hide();
		this.Tactical.OrientationOverlay.removeOverlays();

		if (isVictory)
		{
			this.Music.setTrackList(this.Const.Music.VictoryTracks, this.Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsAttackingLocation)
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictoryVSLocation);
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves")
					{
						this.World.Statistics.getFlags().set("LastBattleWasLocation", true);
						local findCaptiveChance = 15;

						if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID()) {
							findCaptiveChance += 10;
						} else if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID()) {
							findCaptiveChance -= 10;
						}

						if (this.Math.rand(1, 100) <= findCaptiveChance)
						{
							this.World.Statistics.getFlags().set("FindCaptivePostBattle", true);
						}
						else
						{
							this.World.Statistics.getFlags().set("FindCaptivePostBattle", false);
						}
					}
				}
				else
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictory);
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves")
					{
						this.World.Statistics.getFlags().set("LastBattleWasLocation", false);
						this.World.Statistics.getFlags().set("FindCaptivePostBattle", false);
					}
				}

				this.World.Contracts.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Events.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Statistics.getFlags().set("LastPlayersAtBattleStartCount", this.m.MaxPlayers);
				this.World.Statistics.getFlags().set("LastEnemiesDefeatedCount", this.m.MaxHostiles);
				this.World.Statistics.getFlags().set("LastCombatResult", 1);
				this.World.Statistics.getFlags().increment("BattlesWon");
				if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID())
				{
					this.World.Statistics.getFlags().increment("BeastsDefeated");
				}
				this.World.Assets.getOrigin().onBattleWon(this.m.CombatResultLoot);

				local playerRoster = this.World.getPlayerRoster().getAll();
				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						bro.getSkills().onDeath(this.Const.FatalityType.Devoured);
						bro.onDeath(null, null, null, this.Const.FatalityType.Devoured);
						this.World.getPlayerRoster().remove(bro);
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
							bro.improveMood(this.Const.MoodChange.BattleWon, "Won a fight in the arena");
						}
						else
						{
							bro.improveMood(this.Const.MoodChange.BattleWon, "Won a battle");
						}
					}

					else if (!this.m.StrategicProperties.IsUsingSetPlayers)
					{
						if (bro.isPlacedOnMap())
						{
							bro.getLifetimeStats().BattlesWithoutMe = 0;
							bro.improveMood(this.Const.MoodChange.BattleWon, "Won a battle");
						}
						else if (bro.getMoodState() > this.Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && !this.World.Assets.m.IsDisciplined)
						{
							++bro.getLifetimeStats().BattlesWithoutMe;

							if (bro.getLifetimeStats().BattlesWithoutMe > this.Math.max(2, 6 - bro.getLevel()))
							{
								bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
							}
						}
					}
					bro.getFlags().remove("TemporaryRider");
				}
			}
		}
		else
		{
			this.Music.setTrackList(this.Const.Music.DefeatTracks, this.Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						if (bro.isAlive())
						{
							bro.getSkills().onDeath(this.Const.FatalityType.Devoured);
							bro.onDeath(null, null, null, this.Const.FatalityType.Devoured);
							this.World.getPlayerRoster().remove(bro);
						}
					}
					else if (bro.isPlacedOnMap() && (bro.getFlags().get("Charmed") == true || bro.getFlags().get("Sleeping") == true || bro.getFlags().get("Nightmare") == true))
					{
						if (bro.isAlive())
						{
							bro.kill(null, null, this.Const.FatalityType.Suicide);
						}
					}
					else if (bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;

						if (this.Tactical.getCasualtyRoster().getSize() != 0)
						{
							bro.worsenMood(this.Const.MoodChange.BattleLost, "Lost a battle");
						}
						else if (this.World.Assets.getOrigin().getID() != "scenario.deserters")
						{
							bro.worsenMood(this.Const.MoodChange.BattleRetreat, "Retreated from battle");
						}
					}
					else if (bro.getMoodState() > this.Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && (!bro.getFlags().has("TemporaryRider") || !bro.getFlags().has("IsHorse")))
					{
						++bro.getLifetimeStats().BattlesWithoutMe;

						if (bro.getLifetimeStats().BattlesWithoutMe > this.Math.max(2, 6 - bro.getLevel()))
						{
							bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
						}
					}
					bro.getFlags().remove("TemporaryRider");
				}

				if (this.World.getPlayerRoster().getSize() != 0)
				{
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnLoss);
					this.World.Contracts.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
					this.World.Events.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
					this.World.Statistics.getFlags().set("LastEnemiesDefeatedCount", 0);
					this.World.Statistics.getFlags().set("LastCombatResult", 2);
				}
			}
		}

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			this.Sound.play(this.Const.Sound.ArenaEnd[this.Math.rand(0, this.Const.Sound.ArenaEnd.len() - 1)], this.Const.Sound.Volume.Tactical);
			this.Time.scheduleEvent(this.TimeUnit.Real, 4500, function ( _t )
			{
				this.Sound.play(this.Const.Sound.ArenaOutro[this.Math.rand(0, this.Const.Sound.ArenaOutro.len() - 1)], this.Const.Sound.Volume.Tactical);
			}, null);
		}

		this.gatherBrothers(isVictory);
		this.gatherLoot();
		this.Time.scheduleEvent(this.TimeUnit.Real, 800, this.onBattleEndedDelayed.bindenv(this), isVictory);
	}

	o.onBattleEndedDelayed = function ( _isVictory )
	{
		if (this.m.MenuStack.hasBacksteps())
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 50, this.onBattleEndedDelayed.bindenv(this), _isVictory);
			return;
		}

		if (this.m.IsGameFinishable)
		{
			this.Tooltip.hide();
			this.m.TacticalCombatResultScreen.show();
			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.m.MenuStack.push(function ()
			{
				if (this.m.TacticalCombatResultScreen != null)
				{
					if (_isVictory && !this.Tactical.State.isScenarioMode() && this.m.StrategicProperties != null && (!this.m.StrategicProperties.IsLootingProhibited || this.m.StrategicProperties.IsArenaMode && !this.m.CombatResultLoot.isEmpty()) && this.Settings.getGameplaySettings().AutoLoot)
					{
						this.m.TacticalCombatResultScreen.onLootAllItemsButtonPressed();
						this.World.Assets.consumeItems();
						this.World.Assets.refillAmmo();
						this.World.Assets.updateAchievements();
						this.World.Assets.checkAmbitionItems();
						this.World.State.updateTopbarAssets();
					}

					if ("Camp" in this.World && this.World.Camp != null)
					{
						this.World.Camp.assignRepairs();
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

		foreach (id, tile in ::Tactical.Entities.m.NetTiles)
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

	o.gatherLoot = function()
	{
		local playerKills = 0;

		foreach( bro in this.m.CombatResultRoster )
		{
			playerKills = playerKills + bro.getCombatStats().Kills;
		}

		if (!this.isScenarioMode())
		{
			this.returnBrokenNetToOwner();
			this.World.Statistics.getFlags().set("LastCombatKills", playerKills);
		}

		local isArena = !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode;

		if (!isArena && !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsLootingProhibited)
			return;

		local EntireCompanyRoster = this.World.getPlayerRoster().getAll();
		local CannibalsInRoster = 0;
		local CannibalisticButchersInRoster = 0;
		local zombieSalvage = 10;
		local zombieLoot = false;
		local skeletonLoot = false;

		foreach (bro in EntireCompanyRoster)
		{
			if (!bro.isAlive())
			{
				continue;
			}

			switch (bro.getBackground().getID())
			{
				case "background.legend_cannibal":
					CannibalsInRoster += 1;
					break;
				case "background.gravedigger":
					zombieSalvage += 5;
					break;
				case "background.graverobber":
					zombieSalvage += 5;
					break;
				case "background.butcher":
					if (bro.getSkills().hasTrait(::Legends.Trait.LegendCannibalistic))
					{
						CannibalisticButchersInRoster += 1;
					}
					break;
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendReclamation))
			{
				local skill = ::Legends.Perks.get(bro, ::Legends.Perk.LegendReclamation);
				zombieSalvage += skill.m.LootChance;
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendResurrectionist))
			{
				local skill = ::Legends.Perks.get(bro, ::Legends.Perk.LegendResurrectionist);
				zombieSalvage += skill.m.LootChance;
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnZombieLow) || bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnZombieMed) || bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnZombieHigh))
			{
				zombieLoot = true;
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnSkeletonLow) || bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnSkeletonMed) || bro.getSkills().hasPerk(::Legends.Perk.LegendSpawnSkeletonHigh))
			{
				skeletonLoot = true;
			}

		}

		local loot = [];
		local size = this.Tactical.getMapSize();

		for( local x = 0; x < size.X; x = ++x )
		{
			for( local y = 0; y < size.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.IsContainingItems)
				{
					foreach( item in tile.Items )
					{
						if (isArena && item.getLastEquippedByFaction() != 1)
						{
							continue;
						}

						item.onCombatFinished();
						loot.push(item);
					}
				}

				if (zombieLoot && tile.Properties.has("Corpse"))
				{
					if (tile.Properties.get("Corpse").isHuman == 1 || tile.Properties.get("Corpse").isHuman == 2)
					{
						if (this.Math.rand(1, 100) <= zombieSalvage)
						{
							local zloot = this.new("scripts/items/spawns/legend_zombie_item");
							loot.push(zloot);
						}
					}
				}

				// if (skeletonLoot && tile.Properties.has("Corpse")) //Removed until skeleton summoning is reworked into another origin - Luft 12/12/22
				// {
				// 	if (tile.Properties.get("Corpse").isHuman == 1 || tile.Properties.get("Corpse").isHuman == 3)
				// 	{
				// 		if (this.Math.rand(1, 100) <= zombieSalvage)
				// 		{
				// 			local zloot = this.new("scripts/items/spawns/skeleton_item");
				// 			loot.push(zloot);
				// 		}
				// 	}
				// }

				if (this.Math.rand(1, 100) <= 8 && tile.Properties.has("Corpse") && tile.Properties.get("Corpse").isHuman == 1)
				{
					if (CannibalisticButchersInRoster >= 1)
					{
						local humanmeat = this.new("scripts/items/supplies/legend_yummy_sausages");
						humanmeat.randomizeAmount();
						humanmeat.randomizeBestBefore();
						loot.push(humanmeat);
					}
					else if (CannibalisticButchersInRoster < 1 && CannibalsInRoster >= 1)
					{
						local humanmeat = this.new("scripts/items/supplies/legend_human_parts");
						humanmeat.randomizeAmount();
						humanmeat.randomizeBestBefore();
						loot.push(humanmeat);
					}
				}


				if (tile.Properties.has("Corpse") && tile.Properties.get("Corpse").Items != null && !tile.Properties.has("IsSummoned"))
				{
					local items = tile.Properties.get("Corpse").Items.getAllItems();

					foreach( item in items )
					{

						if (isArena && item.getLastEquippedByFaction() != 1)
						{
							continue;
						}

						item.onCombatFinished();
						if (!item.isChangeableInBattle() && item.isDroppedAsLoot())
						{
							if (item.getCondition() > 1 && item.getConditionMax() > 1 && item.getCondition() > item.getConditionMax() * 0.66 && this.Math.rand(1, 100) <= 66)
							{
								local c = this.Math.minf(item.getCondition(), this.Math.rand(this.Math.maxf(10, item.getConditionMax() * 0.35), item.getConditionMax()));
								item.setCondition(c);
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

		if (!isArena && this.m.StrategicProperties != null)
		{
			local player = this.World.State.getPlayer();

			foreach( party in this.m.StrategicProperties.Parties )
			{
				if (party.getTroops().len() == 0 && party.isAlive() && !party.isAlliedWithPlayer() && party.isDroppingLoot() && (playerKills > 0 || this.m.IsDeveloperModeEnabled))
				{
					party.onDropLootForPlayer(loot);
				}
			}

			foreach( item in this.m.StrategicProperties.Loot )
			{
				loot.push(this.new(item));
			}
		}

		if (!isArena && !this.isScenarioMode())
		{
			if (this.Tactical.Entities.getAmmoSpent() > 0 && this.World.Assets.m.IsRecoveringAmmo)
			{
				local amount = this.Math.max(1, this.Tactical.Entities.getAmmoSpent() * 0.2);
				amount = this.Math.rand(amount / 2, amount);

				if (amount > 0)
				{
					local ammo = this.new("scripts/items/supplies/ammo_item");
					ammo.setAmount(amount);
					loot.push(ammo);
				}
			}

			if (this.Tactical.Entities.getArmorParts() > 0 && this.World.Assets.m.IsRecoveringArmor)
			{
				local amount = this.Math.min(60, this.Math.max(1, this.Tactical.Entities.getArmorParts() * this.Const.World.Assets.ArmorPartsPerArmor * 0.15));
				amount = this.Math.rand(amount / 2, amount);

				if (amount > 0)
				{
					local parts = this.new("scripts/items/supplies/armor_parts_item");
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
		this.Tactical.CombatResultRoster <- this.m.CombatResultRoster;
		local alive = this.Tactical.Entities.getAllInstancesAsArray();

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

		local dead = this.Tactical.getCasualtyRoster().getAll();
		local survivor = this.Tactical.getSurvivorRoster().getAll();
		local retreated = this.Tactical.getRetreatRoster().getAll();
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
						this.Tactical.getCasualtyRoster().remove(d);
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
				bro.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(bro);
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

		if (!this.isScenarioMode() && this.World.getPlayerRoster().getSize() == 0 && this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians) != null && this.m.Factions.getHostileFactionWithMostInstances() == this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getID())
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
		this.Time.setRound(_round);

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			if (_round == 1) {
				this.Sound.play(this.Const.Sound.ArenaStart[this.Math.rand(0, this.Const.Sound.ArenaStart.len() - 1)], this.Const.Sound.Volume.Tactical);
			}
			else {
				this.Sound.play(this.Const.Sound.ArenaNewRound[this.Math.rand(0, this.Const.Sound.ArenaNewRound.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
			}
		}
		else {
			this.Sound.play(this.Const.Sound.NewRound[this.Math.rand(0, this.Const.Sound.NewRound.len() - 1)], this.Const.Sound.Volume.Tactical);
		}

		this.Tactical.clearVisibility();

		if (!this.m.IsFogOfWarVisible) {
			this.Tactical.fillVisibility(this.Const.Faction.Player, true);
			this.Tactical.fillVisibility(this.Const.Faction.PlayerAnimals, true);
		}

		local heroes = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		foreach( hero in heroes ) {
			hero.updateVisibilityForFaction();
		}

		this.m.MaxPlayers = this.Math.max(this.m.MaxPlayers, heroes.len());

		local pets = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.PlayerAnimals);
		foreach( pet in pets ) {
			pet.updateVisibilityForFaction();
		}

		this.Tactical.Entities.updateTileEffects();
		this.Tactical.TopbarRoundInformation.update();
		this.m.MaxHostiles = this.Math.max(this.m.MaxHostiles, this.Tactical.Entities.getHostilesNum());
	}
});
