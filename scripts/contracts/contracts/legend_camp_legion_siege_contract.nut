this.legend_camp_legion_siege_contract <- ::inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Allies = []
	},
	function create()
	{
		this.legend_camp_contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Legion;
		this.m.Type = "contract.legend_camp_legion_siege";
		this.m.Name = "Siege";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;

		this.m.DescriptionTemplates = [
			"Lay siege to a noble house fortification.",
			"Capture and destroy a stronghold.",
			"Lay siege to a stronghold of the noble houses.",
		];
			//rewards
		this.m.Payment.ItemPool = [
			[25, "supplies/medicine_item"],
			[25, "supplies/armor_parts_item"],
			[15, "tools/reinforced_throwing_net"],
			[15, @() [
			[80, "weapons/named/legend_named_great_khopesh"],
				[80, "weapons/named/legend_named_military_warscythe"],
				[80, "weapons/named/named_crypt_cleaver"],
				[80, "weapons/named/named_warscythe"],
				[65, "weapons/named/legend_named_gladius"],
				[55, "weapons/ancient/legend_decorated_rhomphaia"],
				[55, "weapons/ancient/legend_decorated_crypt_cleaver"],
				[50, "weapons/ancient/legend_decorated_sword"],
				[50, "weapons/ancient/legend_honed_warscythe"],
				[50, "weapons/ancient/legend_broad_warscythe"],
				[50, "weapons/ancient/legend_military_crypt_cleaver"],
				[50, "weapons/ancient/legend_military_rhomphaia"],
				[35, "weapons/ancient/legend_sica"],
				[25, "weapons/ancient/legend_gladius"],
				[25, "weapons/ancient/legend_spatha"],
				[15, "weapons/ancient/legend_broadhead_spear"],
				[15, "weapons/ancient/legend_oxtongue_spear"],
				[25, "weapons/ancient/legend_kopis"],
				[20, "weapons/legend_drum"],
			]],
			[5, @() [
				[20, "ammo/large_quiver_of_bolts"],
				[20, "ammo/legend_large_broad_head_bolts"],
				[20, "ammo/legend_large_broad_head_arrows"],
				[20, "ammo/legend_large_armor_piercing_bolts"],
				[20, "ammo/legend_large_armor_piercing_arrows"],
				[20, "shields/ancient/tower_shield"],
			]],
			[5, "misc/legend_map_named_item"],
			[5, "misc/legend_ancient_scroll_item"],
			[2, "misc/legend_map_legendary_item"],
		];

		// optionally, offer just tent, starts at 50% chance, lowers with each tent you have
		local stash = ::World.Assets.getStash();
		local missingTents = ::Legends.Camp.Tents.filter(@(_, _tent) !stash.hasItem(_tent.ID));
		if (missingTents.len() > 0 && ::Math.rand(0, ::Legends.Camp.Tents.len() * 2) < missingTents.len()) {
			this.m.Payment.IsSingleItem = true;
			this.m.Payment.Items = [::Const.World.Common.pickItem(missingTents.map(@(_def) [_def.ID == ::Legends.Camp.Tent.Enchant ? 1 : 10, _def.Script]), "scripts/items/")];
		}
	}

	function start()
	{
		this.m.Flags.set("ObjectiveName", this.m.Origin.getName());
		this.m.Flags.set("RivalHouseID", this.m.Origin.getOwner().getID());
		this.m.Flags.set("RivalHouse", this.m.Origin.getOwner().getName());
		this.m.Flags.set("WaitUntil", 0.0);
		this.m.Name = "Siege " + this.m.Origin.getName();
		this.m.Flags.set("CommanderName", this.Const.Strings.AncientDeadNames[this.Math.rand(0, this.Const.Strings.AncientDeadNames.len() - 1)]);

		this.List.extend(::Legends.EventList.addItems(this.Contract.m.Payment.Items, ::World.Assets.getStash()));

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Travel to %objective% in the %direction%",
					"Help in the siege"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				local r = this.Math.rand(1, 100);

				if (r <= 50)
				{
					this.Flags.set("IsTakingAction", true);
					local r = this.Math.rand(1, 100);

					if (r <= 50)
					{
						this.Flags.set("IsAssaultTheGate", true);
					}
					else if (r <= 80)
					{
						this.Flags.set("IsBurnTheCastle", true);
					}
					else
					{
						this.Flags.set("IsPlayerDecision", true);
					}
				}
				else
				{
					this.Flags.set("IsMaintainingSiege", true);
					r = this.Math.rand(1, 100);

					if (r <= 25)
					{
						this.Flags.set("IsNighttimeEncounter", true);
					}
					else
					{
						this.Flags.set("IsReliefAttack", true);
						r = this.Math.rand(1, 100);

						if (r <= 40)
						{
							this.Flags.set("IsSurrender", true);
						}
						else
						{
							this.Flags.set("IsDefendersSallyForth", true);
						}
					}
				}

				this.Contract.spawnSiege();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}
			}

			function update()
			{
				if (this.Contract.isPlayerNear(this.Contract.m.Origin, 300))
				{
					this.Contract.setScreen("TheSiege");
					this.World.Contracts.showActiveContract();

					foreach( a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally != null)
						{
							ally.setAttackableByAI(true);
						}
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_Wait",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Maintain the siege of %objective%",
					"Intercept anyone trying to break through"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Time.getVirtualTimeF() < this.Flags.get("WaitUntil"))
				{
					return;
				}

				foreach( i, a in this.Contract.m.Allies )
				{
					local ally = this.World.getEntityByID(a);

					if (ally == null || !ally.isAlive())
					{
						this.Contract.m.Allies.remove(i);
					}
				}

				if (this.Contract.isPlayerNear(this.Contract.m.Origin, 300))
				{
					if (this.Flags.get("IsReliefAttackForced"))
					{
						if (this.World.getTime().IsDaytime)
						{
							this.Contract.setScreen("ReliefAttack");
							this.World.Contracts.showActiveContract();
						}
					}
					else if (this.Flags.get("IsSurrenderForced"))
					{
						this.Contract.setScreen("Surrender");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsDefendersSallyForthForced"))
					{
						this.Contract.setScreen("DefendersSallyForth");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsTakingAction"))
					{
						if (this.World.getTime().IsDaytime)
						{
							if (this.Flags.get("IsPlayerDecision"))
							{
								this.Contract.setScreen("TakingAction");
								this.World.Contracts.showActiveContract();
							}
							else
							{
								this.Contract.setState("Running_TakingAction");
							}
						}
					}
					else if (this.Flags.get("IsMaintainingSiege"))
					{
						this.Contract.setScreen("MaintainSiege");
						this.World.Contracts.showActiveContract();
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_TakingAction",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Partake in the assault on %objective%"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Time.getVirtualTimeF() < this.Flags.get("WaitUntil"))
				{
					return;
				}

				if (this.Flags.get("IsLost"))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssaultTheGate") && !this.TempFlags.get("AssaultTheGateShown"))
				{
					this.TempFlags.set("AssaultTheGateShown", true);
					this.Contract.setScreen("AssaultTheGate");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssaultAftermath"))
				{
					this.Contract.setScreen("AssaultAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssaultTheCourtyard") && !this.TempFlags.get("AssaultTheCourtyardShown"))
				{
					this.TempFlags.set("AssaultTheCourtyardShown", true);
					this.Contract.setScreen("AssaultTheCourtyard");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBurnTheCastleAftermath"))
				{
					this.Contract.setScreen("BurnTheCastleAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBurnTheCastle") && !this.TempFlags.get("BurnTheCastleShown"))
				{
					this.TempFlags.set("BurnTheCastleShown", true);
					this.Contract.setScreen("BurnTheCastle");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					foreach( i, a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally == null || !ally.isAlive())
						{
							this.Contract.m.Allies.remove(i);
						}
					}

					if (this.Contract.m.Allies.len() == 0)
					{
						this.Contract.setScreen("Failure");
						this.World.Contracts.showActiveContract();
						return;
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "AssaultTheGate")
				{
					this.Flags.set("IsAssaultTheGate", false);
					this.Flags.set("IsAssaultTheCourtyard", true);
				}
				else if (_combatID == "AssaultTheCourtyard")
				{
					this.Flags.set("IsAssaultTheCourtyard", false);
					this.Flags.set("IsAssaultAftermath", true);
				}
				else if (_combatID == "BurnTheCastle")
				{
					this.Flags.set("IsBurnTheCastle", false);
					this.Flags.set("IsBurnTheCastleAftermath", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "AssaultTheGates" || _combatID == "AssaultTheCourtyard" || _combatID == "BurnTheCastle")
				{
					this.Flags.set("IsLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_NighttimeEncounter",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Maintain the siege of %objective%",
					"Intercept anyone trying to break through"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Time.getVirtualTimeF() < this.Flags.get("WaitUntil") || this.World.getTime().IsDaytime)
				{
					return;
				}

				if (this.Flags.get("IsNighttimeEncounterLost"))
				{
					this.Contract.setScreen("NighttimeEncounterFail");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsNighttimeEncounterAfermath"))
				{
					this.Contract.setScreen("NighttimeEncounterAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsNighttimeEncounter") && !this.TempFlags.get("NighttimeEncounterShown"))
				{
					if (!this.World.getTime().IsDaytime)
					{
						this.TempFlags.set("NighttimeEncounterShown", true);
						this.Contract.setScreen("NighttimeEncounter");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					foreach( i, a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally == null || !ally.isAlive())
						{
							this.Contract.m.Allies.remove(i);
						}
					}

					if (this.Contract.m.Allies.len() == 0)
					{
						this.Contract.setScreen("Failure");
						this.World.Contracts.showActiveContract();
						return;
					}
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (!_actor.isPlayerControlled())
				{
					this.Flags.set("IsNighttimeEncounterLost", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "NighttimeEncounter")
				{
					this.Flags.set("IsNighttimeEncounter", false);

					if (!this.Flags.get("IsNighttimeEncounterLost"))
					{
						this.Flags.set("IsNighttimeEncounterAfermath", true);
					}
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "NighttimeEncounter")
				{
					this.Flags.set("IsNighttimeEncounterLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_SecretPassage",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Sneak into %objective% before the night is over",
					"Assassinate the enemy\'s commander"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setOnCombatWithPlayerCallback(this.onSneakIn.bindenv(this));
					this.Contract.m.Origin.setAttackable(true);
				}
			}

			function end()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.setOnCombatWithPlayerCallback(null);
					this.Contract.m.Origin.setAttackable(false);
				}
			}

			function update()
			{
				if (this.Flags.get("IsSecretPassageWin"))
				{
					this.Contract.setScreen("SecretPassageAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsSecretPassageLost"))
				{
					this.Contract.setScreen("SecretPassageFail");
					this.World.Contracts.showActiveContract();
				}
				else if (this.World.getTime().IsDaytime)
				{
					this.Contract.setScreen("FailedToReturn");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					foreach( i, a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally == null || !ally.isAlive())
						{
							this.Contract.m.Allies.remove(i);
						}
					}

					if (this.Contract.m.Allies.len() == 0)
					{
						this.Contract.setScreen("Failure");
						this.World.Contracts.showActiveContract();
						return;
					}
				}
			}

			function onSneakIn( _dest, _isPlayerAttacking = true )
			{
				if (!this.TempFlags.get("IsSecretPassageShown"))
				{
					this.TempFlags.set("IsSecretPassageShown", true);
					this.Contract.setScreen("SecretPassage");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "SecretPassage";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.m.Origin.getOwner().getID(),
						Callback = this.onEnemyCommanderPlaced
					});
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onEnemyCommanderPlaced( _entity, _tag )
			{
				_entity.getFlags().set("IsFinalBoss", true);
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().get("IsFinalBoss") == true)
				{
					this.Flags.set("IsSecretPassageWin", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "SecretPassage")
				{
					this.Flags.set("IsSecretPassageWin", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "SecretPassage" && !this.Flags.get("IsSecretPassageWin"))
				{
					this.Flags.set("IsSecretPassageFail", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_ReliefAttack",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Maintain the siege of %objective%",
					"Intercept anyone trying to break through"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("IsReliefAttackLost"))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
					return;
				}

				local isAlive = false;

				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive() && e.getFaction() == this.Contract.m.Origin.getOwner().getID())
					{
						isAlive = true;

						if (e.getDistanceTo(this.Contract.m.Origin) <= 250)
						{
							this.onCombatWithPlayer(e, false);
							return;
						}
					}
				}

				if (this.Flags.get("IsReliefAttackWon") || !isAlive)
				{
					this.Contract.setScreen("ReliefAttackAftermath");
					this.World.Contracts.showActiveContract();
					return;
				}

				foreach( i, a in this.Contract.m.Allies )
				{
					local ally = this.World.getEntityByID(a);

					if (ally == null || !ally.isAlive())
					{
						this.Contract.m.Allies.remove(i);
					}
				}

				if (this.Contract.m.Allies.len() == 0)
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
					return;
				}
			}

			function onCombatWithPlayer( _dest, _isPlayerAttacking = true )
			{
				_dest.setPos(this.World.State.getPlayer().getPos());
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.CombatID = "ReliefAttack";
				p.Music = this.Const.Music.NobleTracks;
				p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
				p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
				p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall());
				p.EnemyBanners.push(_dest.getBanner());
				this.Contract.flattenTerrain(p);
				local alliesIncluded = false;

				for( local i = 0; i < p.Entities.len(); i = ++i )
				{
					if (this.World.FactionManager.isAlliedWithPlayer(p.Entities[i].Faction))
					{
						alliesIncluded = true;
					}
				}

				if (!alliesIncluded && _dest.getDistanceTo(this.Contract.m.Origin) <= 400)
				{
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction()); //check

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local e = this.World.getEntityByID(id);

						if (e.isAlliedWithPlayer())
						{
							e.die();
							break;
						}
					}
				}

				this.World.Contracts.startScriptedCombat(p, false, true, true);
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "ReliefAttack")
				{
					this.Flags.set("IsReliefAttackWon", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "ReliefAttack")
				{
					this.Flags.set("IsReliefAttackLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_DefendersSallyForth",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Maintain the siege of %objective%",
					"Intercept anyone trying to break through"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("IsDefendersSallyForthLost"))
				{
					this.Contract.setScreen("DefendersPrevail");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsDefendersSallyForthWon"))
				{
					this.Contract.setScreen("DefendersAftermath");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.Contract.m.Origin.getOwner().addPlayerRelation(-99.0, "Took sides in the war");
					this.Contract.setScreen("DefendersSallyForth");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "DefendersSallyForth")
				{
					this.Flags.set("IsDefendersSallyForthWon", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "DefendersSallyForth")
				{
					this.Flags.set("IsDefendersSallyForthLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Wait for the messenger to contact you."
				];
				this.Contract.m.Flags.set("WaitReward", ::Time.getVirtualTimeF() + ::World.getTime().SecondsPerDay * 0.05)
			}

			function update() {
				if (::Time.getVirtualTimeF() > this.Contract.m.Flags.get("WaitReward")) {
					this.Contract.setScreen("Success");
					::World.Contracts.showActiveContract();
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(::Const.Contracts.NegotiationItemsOnly());
		this.importScreens(::Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% is brief. There has been a decree issued. %objective% is to fall by any means and doing so will greatly carry the Emperor's favour. Several other legions have already made their way to the site. While in not direct compitition with one another, your desire to ensure %companyname% persists outstrips their desire to see other legions do so.\n\n There is no mistake the siege will be long and bloody.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [{
				Text = "We need to discuss spoils.",
				getResult = @() "Negotiation"
			}, {
				Text = "We have other duties to attend to.",
				function getResult() {
					this.World.Contracts.removeContract(this.Contract);
					return 0;
				}
			}],
			function start() {}

		});
		this.m.Screens.push({ //—
			ID = "TheSiege",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% greets you in the command tent, which is marked by years of campaigning. For now, all that is required of you is to wait — which sums up most of your life in the legion.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "The %companyname% will be ready.",
					function getResult()
					{
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TakingAction",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% pulls you from your rounds into his tent. A menial is currently digging a deep yet narrow trench through the in a perfectly straight line. Neither the commander or the digger appear worried about what is transpiring. %commander% has summoned the rest of the leaders from each legion involved in the conflict. The meeting goes on for hours and the same tw or three points are reiterated just as many times. Eventaully, a stalemate is reached — a full assault or a continued siege. You appear to have the deciding vote on the matter...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Perform a full assault on the castle.",
					function getResult()
					{
						this.Flags.set("IsAssaultTheGate", true);
						this.Contract.setState("Running_TakingAction");
						return "AssaultTheGate";
					}

				},
				{
					Text = "Continue the siege.",
					function getResult()
					{
						this.Flags.set("IsBurnTheCastle", true);
						this.Contract.setState("Running_TakingAction");
						return "BurnTheCastle";
					}
				}
			]
		});
		this.m.Screens.push({
			ID = "AssaultTheGate",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% orders the legions into a battlefield formation — columns of creaking yet silent legionaries take the line. The garrison sees this, and in response sallies out with their own fighting force. The garrison commander is unwilling to commit his own force, and instead sends a screening group of several small mercenary companies to soften up your section of the line.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "AssaultTheGate";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "BurnTheCastle",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_68.png[/img]{Pushing through the initial line of paid fodder, you are met with a fresh contingent of eager footsoldiers and their commander.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "BurnTheCastle";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [
							this.World.Assets.getBanner(),
							this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
						];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.getFaction(),
							Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract),
							Tag = this.Contract
						});
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.m.Origin.getOwner().getID(),
							Callback = null
						});
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "AssaultTheCourtyard",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective%\'s gate has been taken, their commander lies dead in the mud.\n\n However, with the threat of certain death looming, the local milita has rounded up the peasants, who have been further galvanised by a surviving royal guard.\n They come now, farm tools in hand and sheer numbers on their side, ready to fight to the last.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "AssaultTheCourtyard";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Peasants, 180 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						p.Entities.push({
							ID = this.Const.EntityType.LegendNobleGuard,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/legend_noble_footman_veteran",
							Faction = this.Contract.m.Origin.getOwner().getID(),
							Callback = null
						});
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "AssaultAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective%\'s fort has fallen. You watch as %commander%\'s personal guard and the other legions finish off survivors, setting fire to them. But not always in that order.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Victory!",
					function getResult()
					{
						this.Contract.destroysettlement();
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BurnTheCastleAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_68.png[/img]{The prolonged siege worked like a charm. Those able to fight have long since been slain, and those left are simply too tired or hungry to put up a fight.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Victory!",
					function getResult()
					{
						this.Contract.destroysettlement();
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Origin.spawnFireAndSmoke();

				foreach( a in this.Contract.m.Origin.getActiveAttachedLocations() )
				{
					a.spawnFireAndSmoke();
					a.setActive(false);
				}
			}

		});
		this.m.Screens.push({
			ID = "MaintainSiege",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% returns with news that the defenders might be weakening. He hopes to avoid a deadly assault and simply wait them out instead. You are instructed to stay with the siege camp until further notice.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "The %companyname% will be ready.",
					function getResult()
					{
						if (this.Flags.get("IsNighttimeEncounter"))
						{
							this.Contract.setState("Running_NighttimeEncounter");
						}
						else if (this.Flags.get("IsReliefAttack"))
						{
							this.Flags.set("IsReliefAttackForced", true);
							this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
							this.Contract.setState("Running_Wait");
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NighttimeEncounter",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{The siege drags on. %commander% orders you and your legion out on a patrol. While making the rounds, you spot a small contingent of poorly armed fighters loading carts in the forest. Why is unknown, but if any were to escape they will surely alert the garrison.\n\n Within the perfect dark, you are able to encircle and get almost within throwing distance of the caravan...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Get them!",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "NighttimeEncounter";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Militia, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NighttimeEncounterFail",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{In the chaos, a survivor takes a torch and tosses it into the cargo. The attached mare is burnt alive in a liquid explosion of flaming pitch.\n\n The fire spreads rapidly, getting hot enough that even your legionaries begin to sear. Bells roil out as the pyre turns the night into day. You are driven back by volleys of stones, arrows and bolts.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damn it!",
					function getResult()
					{
						this.Flags.set("IsNighttimeEncounterLost", false);
						this.Flags.set("IsNighttimeEncounter", false);
						this.Flags.set("IsReliefAttack", true);
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({ //—
			ID = "NighttimeEncounterAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{The last militiaman makes a break for the caravan, only to be cut down.\n Cracking open a barrel it dawns on you the significance of the cargo — you look deep into the murky pitch and order your legionaries to make as many torches as they can.\n\n Torches are soon spaced out within the hills and forests beyond, clustered as if to appear as campfires. Soon, the vast array of light dwarfs even the seige camp itself. Not long after, there is more activity on the walls — you have gained a sizable audience who is now looking in two differant diractions.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We\'ll give it time and see what happens...",
					function getResult()
					{
						this.Flags.set("IsSecretPassage", true);
						this.Contract.setState("Running_SecretPassage");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FailedToReturn",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{You failed to kill the defender\'s leader. Worse yet — they managed to escape the chaos and ride to the nearest settlement for aid. With more reinforcements almost certain and the siege no closer to an end, %commander% orders all the legions to pull out.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damnit!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({ //\n\n
			ID = "SecretPassage",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{At first there is growing concern the nobles have seen through the ruse, yet the activity in the camp reaches a fever pitch as the wall guards weigh their options between the small real camp and the unknowing, yet larger, fake one.\n\n Suddenly, the gates swing wide open, and the garrison commander leads a panicked push out towards the darkness with those he could muster — you legion rises from a trench and into full view. The commander has no choice now. He either goes through you or turns back around. If %companyname% catchs him here, you are confident the siege will end.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Charge!",
					function getResult()
					{
						this.Contract.getActiveState().onSneakIn(null, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SecretPassageAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective%\'s commander falls into the mud with a heavy thud — as if it were a clarion call, what remains of his force immediately panics and attempts to flee back into the gate, which is now only open a fraction. Most are crushed or trampled in the panic. Some make a break for it but are cut down by a closing net of legionaries.\n\n As you approach, the squeeze increases until the gate is pushed open further. Seeing the chance, you and the other legions rush in, pushing your way through the squall and into the settlement.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Another one down.",
					function getResult()
					{
						this.Contract.destroysettlement();
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({ //—
			ID = "SecretPassageFail",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{Fighting like cornered dogs, the commander manages to escape the melee back into the settlement. The wait continues.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damn it!",
					function getResult()
					{
						this.Flags.set("IsSecretPassage", false);
						this.Flags.set("IsReliefAttackForced", true);
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ReliefAttack",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_90.png[/img]{%commander%\'s scouts return with news that a substantial group of mercenaries have been seen marching towards %objective%. It is unclear if they have been paid to lift the siege or just happen upon it — but will likely attemot to lift it for glory and gold either way, as is in their nature...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare for battle!",
					function getResult()
					{
						this.Contract.spawnReliefForces();
						this.Contract.setState("Running_ReliefAttack");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ReliefAttackAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_86.png[/img]{The relief force has been defeated and beaten back off the field. %objective%\'s defenders no doubt saw the whole battle and have taken a hit to their morale. It\'s likely only a matter of time until they surrender.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "They can\'t hold out forever.",
					function getResult()
					{
						this.Flags.set("IsReliefAttackForced", false);

						if (this.Flags.get("IsSurrender"))
						{
							this.Flags.set("IsSurrenderForced", true);
						}
						else if (this.Flags.get("IsDefendersSallyForth"))
						{
							this.Flags.set("IsDefendersSallyForthForced", true);
						}

						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(10, 20));
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Surrender",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_31.png[/img]A messenge from %objective% arrives coiled around an arrow shot near camp. The raid leaders, including yourself, can\'t make heads or tails of it.\n\n Down at the gates, %objective% has been abandoned — on closer inspection tunnels have been dug underneath the keep leading outwards into the forest. Livestock has been picked clean and not a crumb of food remains. What has not been consumed or fought over has succumbed to disease. Files swarm out of the stables and granary alike.\n Some defenders have stayed at their posts, rallied around a single unremarkable figure within the guard\'s tower, who meets their end all the same. A large contingent of nobles, now famished and ragged, have resorted to eating one another behind the barricaded doors and hallways of the keep. The last look one gives you reminds you more of a feral animal than a woman.\n\n Despite the escapees, the protracted siege was a success.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%objective% has, finally, fallen...",
					function getResult()
					{
						this.Contract.destroysettlement();
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({ // \'
			ID = "DefendersSallyForth",
			Title = "At the siege...",
			Text = "[img]gfx/ui/events/event_78.png[/img]{A surge of activity is heard behind the gates of %objective%, the clamour steadily builds until the gates groan open to a rush of defenders. This is it.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Let\'s end this!",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "DefendersSallyForth";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [
							this.World.Assets.getBanner(),
							this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
						];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.getFaction(),
							Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract)
						});
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.m.Origin.getOwner().getID(),
							Callback = null
						});
						this.Contract.setState("Running_DefendersSallyForth");
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "DefendersPrevail",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img]The defenders put up a valiant effort and are rewarded for it. Distantly, you cans ee the siege camp already being packed up and moved. You retreat as the siege crumbles and the other remaining legions fight to their second death.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "The siege has failed.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DefendersAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{The defenders of %objective% have been annihilated and the fortifications left wide open. Another legion will finish what you have done here.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%objective% has fallen!",
					function getResult()
					{
						this.Contract.destroysettlement();
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{Cinder fills the air, the population of %objective% is exterminated with brutal effeciency. Those still in the streets are cut down, as the rest are barricaded in their homes to be set alight.\n\n A desperate few make last stands in chokepoints and alleyways — only to be pushed out and cut down elsewhere. %employer% will be pleased.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "%objective% has fallen.", //millions must find a new place to buy items
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Contracts.finishActiveContract();
						this.Contract.destroysettlement();
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Failure",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img]What a disaster. The battle is lost and you retreat to spare what legionaries you have left. %objective% will not fall anytime soon.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damn this place!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TooFarAway",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_36.png[/img]{The passage of time as a concept seems to have eluded you. Despite your absence, the siege tried to go on, but eventually collapsed without the expected help of the %companyname%. Don\'t bother returning to %employer%. | You were hired to help the siege, not abandon it. Without the %companyname% by their side, the soldiers will likely have to withdraw from the field. | You strayed too far from the siege! Without your help, the attackers had to retreat and %objective% was spared %employer%\'s conquest. Considering that was what you were hired to help accomplish, it\'s probably for the best that you do not return.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Right, there was this siege...",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnReliefForces()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 8, originTile.SquareCoords.X + 8);
			local y = this.Math.rand(originTile.SquareCoords.Y - 8, originTile.SquareCoords.Y + 8);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Mountains)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local party = enemyFaction.spawnEntity(this.Const.World.Spawn.Mercenaries, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		// party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + enemyFaction.getBannerString());
		// party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
		party.setDescription("Professional soldiers in service to local lords.");
		party.setFootprintType(this.Const.World.FootprintsType.Nobles);
		party.getLoot().ArmorParts = this.Math.rand(10, 30);
		party.getLoot().Medicine = this.Math.rand(0, 5);
		party.getLoot().Ammo = this.Math.rand(0, 30);

		party.setAttackableByAI(false);
		this.m.UnitsSpawned.push(party.getID());
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(10.0);
		c.addOrder(wait);
	}

	function spawnSupplyCaravan()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 7, originTile.SquareCoords.X + 7);
			local y = this.Math.rand(originTile.SquareCoords.Y - 7, originTile.SquareCoords.Y + 7);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (!tile.HasRoad)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local party = enemyFaction.spawnEntity(tile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, this.Math.rand(100, 150), this.getMinibossModifier());
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.getLoot().Money = this.Math.rand(0, 100);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		move.setRoadsOnly(true);
		c.addOrder(move);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(despawn);
	}

	function spawnSiege()
	{
		foreach( a in this.m.Origin.getActiveAttachedLocations() )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				a.spawnFireAndSmoke();
				a.setActive(false);
			}
		}

		local f = this.World.FactionManager.getFaction(this.getFaction());
		local castles = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				castles.push(s);
			}
		}

		if (castles.len() == 0)
		{
			castles = clone f.getSettlements();
		}

		local originTile = this.m.Origin.getTile();
		local lastTile;

		for( local i = 0; i < 2; i = ++i )
		{
			local tile;

			while (true)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 1, originTile.SquareCoords.X + 1);
				local y = this.Math.rand(originTile.SquareCoords.Y - 1, originTile.SquareCoords.Y + 1);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) == 0)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				if (i == 0 && !tile.HasRoad && !this.m.Origin.isIsolatedFromRoads())
				{
					continue;
				}

				if (lastTile != null && tile.ID == lastTile.ID)
				{
					continue;
				}

				break;
			}

			lastTile = tile;
			// local party = f.spawnEntity(tile, castles[this.Math.rand(0, castles.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Noble, castles[this.Math.rand(0, castles.len() - 1)].getResources(), this.getMinibossModifier());

			local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.UndeadArmy).spawnEntity(tile, "Legion Cohort", false, this.Const.World.Spawn.UndeadArmy, this.Math.rand(140, 250) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());

			// local party = f.spawnEntity(tile, castles[this.Math.rand(0, castles.len() - 1)], this.Const.World.Spawn.UndeadArmy, castles[this.Math.rand(0, castles.len() - 1)].getResources(), this.getMinibossModifier());

			party.setDescription("An Undead Legion");
			party.setVisibilityMult(2.5);

			if (i == 0)
			{
				party.getSprite("body").setBrush("figure_siege_01");
				party.getSprite("base").Visible = false;
			}
			else
			{
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
			}

			party.setAttackableByAI(false);
			this.m.UnitsSpawned.push(party.getID());
			this.m.Allies.push(party.getID());

			local c = party.getController();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(9000.0);
			c.addOrder(wait);
		}
	}

	local targets = [];

	foreach( l in this.m.Origin.getAttachedLocations() )
	{
		if (l.isActive() && l.isUsable())
		{
			targets.push(l);
		}
	}

	if (targets.len() == 0)
	{
		foreach( l in this.m.Origin.getAttachedLocations() )
		{
			if (l.isUsable())
			{
				targets.push(l);
			}
		}
	}

	for( local i = 0; i < numOtherEnemies; i = ++i )
	{
		local tile;
		local tries = 0;

		while (tries++ < 500)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 4, originTile.SquareCoords.X + 4);
			local y = this.Math.rand(originTile.SquareCoords.Y - 4, originTile.SquareCoords.Y + 4);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 1)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}
			break;
		}
//check
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.UndeadArmy).spawnEntity(tile, "Legion Cohort", false, this.Const.World.Spawn.UndeadArmy, this.Math.rand(90, 110) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		this.m.UnitsSpawned.push(party.getID());
		party.setDescription("Legionaries marching to war.");
		party.getSprite("banner").setBrush(orcBase != null ? orcBase.getBanner() : "banner_undead_01");
		local c = party.getController();
		local raidTarget = targets[this.Math.rand(0, targets.len() - 1)].getTile();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local raid = this.new("scripts/ai/world/orders/raid_order");
		raid.setTime(30.0);
		raid.setTargetTile(raidTarget);
		c.addOrder(raid);
		local destroy = this.new("scripts/ai/world/orders/destroy_order");
		destroy.setTime(60.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(originTile);
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function destroysettlement()
	{
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local castles = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				castles.push(s);
			}
		}

		if (castles.len() == 0)
		{
			castles = clone f.getSettlements();
		}

		local originTile = this.m.Origin.getTile();
		local lastTile;

		for( local i = 0; i < 2; i = ++i )
		{
			local tile;

			while (true)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 1, originTile.SquareCoords.X + 1);
				local y = this.Math.rand(originTile.SquareCoords.Y - 1, originTile.SquareCoords.Y + 1);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) == 0)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				if (i == 0 && !tile.HasRoad && !this.m.Origin.isIsolatedFromRoads())
				{
					continue;
				}

				if (lastTile != null && tile.ID == lastTile.ID)
				{
					continue;
				}

				break;
			}

			// lastTile = tile; //will come from a nearby castle for now. Can refine later.
			// local party = f.spawnEntity(tile, castles[this.Math.rand(0, castles.len() - 1)], this.Const.World.Spawn.UndeadArmy, castles[this.Math.rand(0, castles.len() - 1)].getResources(), this.getMinibossModifier());

			local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.UndeadArmy).spawnEntity(tile, "Legion Cohort", false, this.Const.World.Spawn.UndeadArmy, this.Math.rand(140, 250) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());

			party.setDescription("A legion moving to sack a settlement.");
			party.setVisibilityMult(2.5);

			if (i == 0)
			{
				party.getSprite("body").setBrush("figure_siege_01");
				party.getSprite("base").Visible = false;
			}
			else
			{
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
			}

			party.setAttackableByAI(false);
								///the bit that destroys the settlement v
			local c = party.getController();
			local raidTarget = targets[this.Math.rand(0, targets.len() - 1)].getTile();

			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			c.setAttackableByAI(false); //ensures action not interrupted

			local raid = this.new("scripts/ai/world/orders/raid_order");
			raid.setTime(25.0);
			raid.setTargetTile(raidTarget);
			c.addOrder(raid);
			local destroy = this.new("scripts/ai/world/orders/destroy_order");
			destroy.setTime(35.0);
			destroy.setSafetyOverride(true);
			destroy.setTargetTile(originTile);
			destroy.setTargetID(this.m.Origin.getID());
			c.addOrder(destroy);
		}
	}

	function flattenTerrain( _p )
	{
		if (_p.TerrainTemplate == "tactical.hills_steppe")
		{
			_p.TerrainTemplate = "tactical.steppe";
		}
		else if (_p.TerrainTemplate == "tactical.hills_tundra")
		{
			_p.TerrainTemplate = "tactical.tundra";
		}
		else if (_p.TerrainTemplate == "tactical.hills_snow" || _p.TerrainTemplate == "forest_snow")
		{
			_p.TerrainTemplate = "tactical.snow";
		}
		else if (_p.TerrainTemplate == "tactical.hills" || _p.TerrainTemplate == "tactical.mountain")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
		else if (_p.TerrainTemplate == "tactical.hills" || _p.TerrainTemplate == "tactical.mountain")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
		else if (_p.TerrainTemplate == "tactical.forest_leaves" || _p.TerrainTemplate == "tactical.forest" || _p.TerrainTemplate == "tactical.autumn")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
		else if (_p.TerrainTemplate == "tactical.swamp")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
	}

	function onCommanderPlaced( _entity, _tag )
	{
		_entity.setName(this.m.Flags.get("CommanderName"));
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Flags.get("ObjectiveName")
		]);
		_vars.push([
			"noblefamily",
			this.World.FactionManager.getFaction(this.getFaction()).getName()
		]);
		_vars.push([
			"rivalhouse",
			this.m.Flags.get("RivalHouse")
		]);
		_vars.push([
			"commander",
			this.m.Flags.get("CommanderName")
		]);
		_vars.push([
			"direction",
			this.m.Origin == null || this.m.Origin.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Origin.getTile())]
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			foreach( id in this.m.UnitsSpawned )
			{
				local e = this.World.getEntityByID(id);

				if (e != null && e.isAlive())
				{
					local c = e.getController();
					c.clearOrders();

					if (e.isAlliedWithPlayer())
					{
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(60.0);
						c.addOrder(wait);
					}
				}
			}

			if (this.m.Origin != null && !this.m.Origin.isNull())
			{
				this.m.Origin.getSprite("selection").Visible = false;
				this.m.Origin.setOnCombatWithPlayerCallback(null);
				this.m.Origin.setAttackable(false);
			}

			if (this.m.Home != null && !this.m.Home.isNull())
			{
				this.m.Home.getSprite("selection").Visible = false;
			}
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(2);
			}
		}
	}

	function onIsValid()
	{
		if (this.m.Origin == null || this.m.Origin.isNull() || this.m.Origin.getFaction() == this.getFaction())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
		_out.writeU8(this.m.Allies.len());

		foreach( ally in this.m.Allies )
		{
			_out.writeU32(ally);
		}
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
		local numAllies = _in.readU8();

		for( local i = 0; i < numAllies; i = ++i )
		{
			this.m.Allies.push(_in.readU32());
		}
	}
});

