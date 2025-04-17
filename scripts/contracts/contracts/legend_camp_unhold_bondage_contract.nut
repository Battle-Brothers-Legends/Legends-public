this.legend_camp_unhold_bondage_contract <- this.inherit("scripts/contracts/camp_contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true
	},

	function create() {
		this.contract.create();
		this.m.Type = "contract.legend_camp_unhold_bondage_contract";
		this.m.Name = "Capture Unhold";
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Barbarians;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(95, 125) * 0.01;
		this.m.DescriptionTemplates = [
			"Friendly barbarian tribe tries to expand their forces. They're looking for some unholds.",
			"Local barbarian warlord is looking for new pet. You imagine what he wants.",
		];
	}

	function getBanner() {
		return "ui/banners/factions/banner_legend_s";
	}

	function start() {
		this.m.Payment.Pool = 400 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 10) {
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		} else {
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates() {
		this.m.States.push({
			ID = "Offer",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Equip provided nets",
					"Hunt and capture at least one unhold"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance) {
					this.Contract.setScreen("Intro");
				} else {
					this.Contract.setScreen("Task");
				}
			}

			function end() {
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.spawnEnemies();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);

				local count = ::Math.rand(1, 3);
				while (count--) {
					::World.Assets.getStash().add(::new("scripts/items/tools/legend_unhold_throwing_net"));
				}
			}

		});
		this.m.States.push({
			ID = "Running",
			function start() {
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull()) {
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update() {
				if (this.Flags.getAsInt("CapturedUnholds") > 0) {
					local target = this.Contract.m.Target;
					if (target != null) {
						::World.EntityManager.onWorldEntityDestroyed(target, false);
						target.onCombatLost();
					}
					this.Contract.m.Target = null;
				}
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive()) {
					this.Contract.setScreen("AfterBattle");
					this.World.Contracts.showActiveContract();
					if (this.Flags.getAsInt("CapturedUnholds") > 0) {
						this.Contract.setState("Return");
					} else {
						this.Contract.setState("Chase");
					}
				}
			}

			function onTargetAttacked(_dest, _isPlayerAttacking) {
				if (!this.Flags.get("IsEncounterShown")) {
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				} else {
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}
		});
		this.m.States.push({
			ID = "Chase",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you."
				];
				this.Contract.spawnRevengeEnemies();
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull()) {
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update() {
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive()) {
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked(_dest, _isPlayerAttacking) {
				if (!this.Flags.get("IsBarbEncounterShown")) {
					this.Flags.set("IsBarbEncounterShown", true);
					this.Contract.setScreen("BarbEncounter");
					this.World.Contracts.showActiveContract();
				} else {
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}
		});
		this.m.States.push({
			ID = "Return",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you."
				];
			}

			function update() {
				this.Contract.setScreen("Success");
				this.World.Contracts.showActiveContract();
			}

		});
	}

	function createScreens() {
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);

		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_31.png[/img]{When you enter %employer%\'s keep he runs out to greet you, he looks wracked with fear. Here goes contract description. }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{The %companyname% can help for the right price. | Let\'s talk crowns.}",
					function getResult() {
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | This won\'t be worth the risk.}",
					function getResult() {
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			]
		});

		this.m.Screens.push({
			ID = "Encounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{You found the unhold pack %employer% was talking about. You rally your men to charge at them.}",
			Image = "",
			List = [],
			Options = [{
				Text = "Charge!",
				function getResult() {
					this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "BarbEncounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{%employer% isn't pleased that you killed the unhold he wanted to capture. You line up your men to face them.}",
			Image = "",
			List = [],
			Options = [{
				Text = "Charge!",
				function getResult() {
					this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "AfterBattle",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_113.png[/img]{The giant barelly breathing, laying on the ground, still weakened by the contraption. You order the men to load it to the cage.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Time to get paid.",
					function getResult() {
						return 0;
					}
				}
			],
			function start() {
				if (this.Flags.getAsInt("CapturedUnholds") == 0) {
					this.Text = "[img]gfx/ui/events/event_113.png[/img]{You failed to capture unhold. Your employer won't be satisfied.}";
					this.Options = [
						{
							Text = "Damn it.",
							function getResult() {
								return 0;
							}
						}
					];
				}
			}
		});

		this.m.Screens.push({
			ID = "Success",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_31.png[/img]{Success text}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
					Text = "A successful hunt.",
					function getResult() {
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_venison_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/supplies/medicine_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/loot/ancient_gold_coins_item"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rid the town of rock unholds");
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Saviour of the lands");
						this.World.Contracts.finishActiveContract();
						return 0;
					}
				}],
			function start() {
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});

		this.m.Screens.push({
			ID = "Failure",
			Title = "After battle...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{Failure text}",
			Image = "",
			List = [],
			Options = [{
				Text = "Such is life",
				function getResult() {
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract();
					return 0;
				}
			}]
		});

	}

	function spawnEnemies() {
		local playerTile = this.World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Tundra
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 8);
		local party;
		party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Unholds", false, ::Const.World.Spawn.Unhold, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("One or more lumbering giants.");
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.85);
		party.getFlags().set("IsUnholds", true);
		this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, 0.85);
		this.m.Target = this.WeakTableRef(party);
		party.getSprite("banner").setBrush("banner_beasts_01");
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setPivot(this.m.Home);
		roam.setMinRange(2);
		roam.setMaxRange(8);
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Shore, false);
		roam.setTerrain(this.Const.World.TerrainType.Forest, false);
		roam.setTerrain(this.Const.World.TerrainType.LeaveForest, false);
		roam.setTerrain(this.Const.World.TerrainType.SnowyForest, false);
		roam.setTerrain(this.Const.World.TerrainType.AutumnForest, false);
		c.addOrder(roam);
		return party;
	}

	function spawnRevengeEnemies() {
		local playerTile = ::World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Tundra
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 8);
		local party;
		party = ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians).spawnEntity(tile, "Barbarians", false, ::Const.World.Spawn.BarbarianHunters, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A warband of your barbarian employer.");
		party.setMovementSpeed(::Const.World.MovementSettings.Speed * 2.0);
		party.setAttackableByAI(false);
		party.setFootprintSizeOverride(0.85);

		this.m.Target = this.WeakTableRef(party);

		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(true);
		local intercept = ::new("scripts/ai/world/orders/intercept_order");
		intercept.setTarget(::World.State.getPlayer());
		c.addOrder(intercept);
		return party;
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"shouter",
			this.m.Dude != null ? this.m.Dude.getName() : ""
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onClear() {
		if (this.m.IsActive) {
			if (this.m.Target != null && !this.m.Target.isNull()) {
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}
		}
	}

	function onSerialize(_out) {
		if (this.m.Target != null && !this.m.Target.isNull()) {
			_out.writeU32(this.m.Target.getID());
		} else {
			_out.writeU32(0);
		}
		this.contract.onSerialize(_out);
	}

	function onDeserialize(_in) {
		local target = _in.readU32();
		if (target != 0) {
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}
		this.contract.onDeserialize(_in);
	}

});

