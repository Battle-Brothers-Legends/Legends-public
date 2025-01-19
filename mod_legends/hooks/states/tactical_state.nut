::mods_hookExactClass("states/tactical_state", function(o)
{
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
					if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves")
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
					if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves")
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

					else if (bro.getSkills().hasSkill("perk.legend_pacifist") && bro.isPlacedOnMap())
					{
							bro.getLifetimeStats().BattlesWithoutMe = 0;
							bro.worsenMood(this.Const.MoodChange.BattleWithoutMe, "Forced into battle against their wishes");
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

	o.gatherLoot = function()
	{
		local playerKills = 0;

		foreach( bro in this.m.CombatResultRoster )
		{
			playerKills = playerKills + bro.getCombatStats().Kills;
		}

		if (!this.isScenarioMode())
		{
			this.World.Statistics.getFlags().set("LastCombatKills", playerKills);
		}

		local isArena = !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode;

		if (!isArena && !this.isScenarioMode() && this.m.StrategicProperties != null && this.m.StrategicProperties.IsLootingProhibited)
		{
			return;
		}

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
					if (bro.getSkills().hasSkill("trait.vazl_cannibalistic"))
					{
						CannibalisticButchersInRoster += 1;
					}
					break;
			}

			if (bro.getSkills().hasSkill("perk.legends_reclamation"))
			{
				local skill = bro.getSkills().getSkillByID("perk.legends_reclamation");
				zombieSalvage += skill.m.LootChance;
			}

			if (bro.getSkills().hasSkill("perk.legend_resurrectionist"))
			{
				local skill = bro.getSkills().getSkillByID("perk.legend_resurrectionist");
				zombieSalvage += skill.m.LootChance;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_low") || bro.getSkills().hasSkill("perk.legend_spawn_zombie_med") || bro.getSkills().hasSkill("perk.legend_spawn_zombie_high"))
			{
				zombieLoot = true;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_low") || bro.getSkills().hasSkill("perk.legend_spawn_skeleton_med") || bro.getSkills().hasSkill("perk.legend_spawn_skeleton_high"))
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
});
