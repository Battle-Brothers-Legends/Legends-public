this.legend_camp_smuggle_contract <- ::inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Town = null,
		Fortress = null,
		Camp = null,
		PursuitParty = null
	},
	function create() {
		this.legend_camp_contract.create();
		this.m.Type = "contract.legend_camp_smuggle_contract";
		this.m.Name = "Smuggle item";
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Bandits;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 10.0;
		this.m.DifficultyMult = ::Math.rand(80, 139) * 0.01;
		this.m.DescriptionTemplates = [
			"Bandits want to procure an item, but as outlaws they cannot enter town.",
			"Local criminal is in dire need of new equipment. You can help them smuggle goods.",
			"Mysterious cargo, back alley handovers - honest pay for dishonest work."
		];
	}

	function isVisible() {
		// exclude desert i guess?
		local currentTile = ::World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y < ::World.getMapSize().Y * 0.3)
			return false;

		local sourceSettlements = [];
		local militarySettlements = [];
		foreach (settlement in ::World.EntityManager.getSettlements()) {
			if (!::MSU.isKindOf(settlement, "settlement"))
				continue;
			if (settlement.isIsolatedFromRoads())
				continue;
			if (settlement.isMilitary()) {
				militarySettlements.push(settlement);
			} else {
				sourceSettlements.push(settlement)
			}
		}

		if (sourceSettlements.len() == 0)
			return false;

		if (militarySettlements.len() == 0)
			return false;
		return true;
	}

	function start() {
		this.m.Payment.Pool = 600 * this.getPaymentMult() * ::Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		this.m.Payment.Completion = 1.0;

		local sourceSettlements = [];
		local militarySettlements = [];
		foreach (settlement in ::World.EntityManager.getSettlements()) {
			if (!::MSU.isKindOf(settlement, "settlement"))
				continue;
			if (settlement.isIsolatedFromRoads())
				continue;
			if (settlement.isMilitary()) {
				militarySettlements.push(settlement);
			} else {
				sourceSettlements.push(settlement)
			}
		}
		// limit these to 3 nearest
		sourceSettlements.sort(this.onSortByDistance);
		while(sourceSettlements.len() > 3)
			sourceSettlements.pop();

		this.m.Town = ::WeakTableRef(sourceSettlements[::Math.rand(0, sourceSettlements.len() - 1)]);
		this.m.Fortress = ::WeakTableRef(militarySettlements[::Math.rand(0, militarySettlements.len() - 1)]);
		this.m.Flags.set("EnemyNobleHouse", this.m.Fortress.getOwner().getID());
		this.m.Flags.set("EmulateNobleFaction", this.m.Fortress.getOwner().getID());

		this.contract.start();
	}

	function createStates() {
		this.m.States.push({
			ID = "Offer",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Pick up requested item from " + this.Contract.m.Town.getName()
				];

				if (::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance) {
					this.Contract.setScreen("Intro");
				} else {
					this.Contract.setScreen("Task");
				}
			}

			function end() {
				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Flags.set("ItemTypeSeed", ::Math.rand(0, 32767));
				this.Flags.set("ItemSeed", ::Math.rand(0, 32767));
				if (::Math.rand(0, 2)) { // 66% chance for enemy spawn
					if(::Math.rand(0, 1)) {
						this.Flags.set("Ambush", true); // 50% for ambush
					} else {
						this.Flags.set("Pursuit", true); // 50% for pursuit
					}
				}

				::World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				this.Contract.setScreen("Overview");
				::World.Contracts.setActiveContract(this.Contract);
				this.Contract.m.Town.getSprite("selection").Visible = true;
			}
		});

		this.m.States.push({
			ID = "Running",
			function start() {
				this.Contract.m.Town.getSprite("selection").Visible = true;
			}
			function update() {
				if (this.Contract.isPlayerAt(this.Contract.m.Town)) {
					this.Contract.setScreen("ItemPickedUp");
					::World.Contracts.showActiveContract();
				}
			}
		});

		this.m.States.push({
			ID = "Delivery",
			function start() {
				if (this.Contract.m.Camp != null && !this.Contract.m.Camp.isNull()) {
					this.Contract.m.Camp.getSprite("selection").Visible = true;
					this.Contract.m.Camp.setOnCombatWithPlayerCallback(this.onLocationCombat.bindenv(this));
				}
				if (this.Flags.has("Pursuit")) {
					if (this.Contract.m.PursuitParty == null)
						this.Contract.m.PursuitParty = ::WeakTableRef(this.Contract.spawnPursuitParty());
					this.Contract.m.PursuitParty.setOnCombatWithPlayerCallback(this.onPursuitCombat.bindenv(this));
				}
				this.Contract.m.BulletpointsObjectives = [
					"Deliver requested item to bandit camp"
				];
			}
			function update() {
				if (this.Flags.get("IsFailure")) {
					this.Contract.setScreen("FailedPursuit");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("BoxOpened")) {
					if (this.Contract.m.PursuitParty != null && !this.Contract.m.PursuitParty.isNull() && this.Contract.m.PursuitParty.isAlive()) {
						this.Contract.m.PursuitParty.die();
					}
					this.Contract.m.PursuitParty = null;
					this.Contract.setState("Revenge");
				}
			}

			function onPursuitCombat(_dest, _isPlayerInitiated) {
				local p = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
				p.CombatID = "Pursuit";
				::World.Contracts.startScriptedCombat(p, _isPlayerInitiated, true, true);
			}

			function onRetreatedFromCombat(_combatID) {
				if (_combatID == "Pursuit") {
					this.Flags.remove("Pursuit");
					if (this.Contract.m.PursuitParty != null && !this.Contract.m.PursuitParty.isNull() && this.Contract.m.PursuitParty.isAlive()) {
						this.Contract.m.PursuitParty.die();
					}
					this.Contract.m.PursuitParty = null;
				}
			}

			function onCombatVictory(_combatID) {
				if (_combatID == "Pursuit") {
					this.Flags.remove("Pursuit");
				}
			}

			function onLocationCombat(_dest, _isPlayerInitiated) {
				if(this.Flags.get("Ambush")) {
					this.Contract.setScreen("Ambush");
				} else {
					this.Contract.setScreen("Success");
				}
				::World.Contracts.showActiveContract();
			}
		});

		this.m.States.push({
			ID = "Ambush",
			function start() {
				local p = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
				p.CombatID = "Ambush";
				p.MapSeed = this.Flags.getAsInt("MapSeed");
				p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
				p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
				p.Entities = [];
				this.Contract.spawnAmbushParty(p);
				::World.Contracts.startScriptedCombat(p, false, true, true);
			}

			function update() {
				if (this.Flags.get("IsFailure")) {
					this.Contract.setScreen("FailedAmbush");
					this.World.Contracts.showActiveContract();
					if (this.Contract.m.Camp != null && !this.Contract.m.Camp.isNull()) {
						this.Contract.m.Camp.die();
						this.Contract.m.Camp = null;
					}
					return;
				}

				if (this.Flags.get("IsFinalBattleWon")) {
					this.Contract.setScreen("Success");
					::World.Contracts.showActiveContract();
				}

				if (this.Flags.get("BoxOpened")) {
					this.Contract.setState("Revenge");
				}
			}

			function onRetreatedFromCombat(_combatID) {
				if (_combatID == "Ambush") {
					this.Flags.set("IsFailure", true);
				}
			}

			function onCombatVictory( _combatID ) {
				if (_combatID == "Ambush") {
					this.Flags.set("IsFinalBattleWon", true);
				}
			}
		});

		this.m.States.push({
			ID = "Revenge",
			function start() {
				this.Contract.m.BulletpointsPayment = [];
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you"
				];
				if (this.Contract.m.Camp != null && !this.Contract.m.Camp.isNull()) {
					this.Contract.m.Camp.getSprite("selection").Visible = false;
					this.Contract.m.Camp.setOnCombatWithPlayerCallback(null);
				}
				if (this.Contract.m.PursuitParty == null)
					this.Contract.m.PursuitParty = ::WeakTableRef(this.Contract.spawnRevengeParty());
				this.Contract.m.PursuitParty.setOnCombatWithPlayerCallback(this.onRevengeCombat.bindenv(this));
			}

			function onRevengeCombat(_dest, _isPlayerInitiated) {
				local p = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
				p.CombatID = "Revenge";
				::World.Contracts.startScriptedCombat(p, _isPlayerInitiated, true, true);
			}

			function onCombatVictory( _combatID ) {
				if (_combatID == "Revenge") {
					::World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
					::World.Contracts.finishActiveContract(true);
				}
			}
		});
	}

	function createScreens() {
		this.importScreens(::Const.Contracts.NegotiationDefault);
		this.importScreens(::Const.Contracts.Overview);

		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{With a cocky grin, %employer% strolls into your tent like he owns the place. %SPEECH_ON%I need a favor. %Town%'s got something of mine, but I'm not welcome here. Could you, uh, go shopping for me?%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [{
				Text = "{The %companyname% can help for the right price. | Let\'s talk crowns.}",
				function getResult() {
					return "Negotiation";
				}
			}, {
				Text = "{This doesn\'t sound like our kind of work. | This won\'t be worth the risk.}",
				function getResult() {
					::World.Contracts.removeContract(this.Contract);
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "ItemPickedUp",
			Title = "Inside town",
			Text = ::format("[img]gfx/ui/events/event_112.png[/img]{%s | %s | %s}",
				"A smuggler meets you behind the tavern, tossing a chest into your hands. %SPEECH_ON%Road's clear - for now. And if it starts squeaking, you didn\'t get it from me.%SPEECH_OFF%",
				"A nervous clerk meets you by the well, handing off a small chest. %SPEECH_ON%Here! Just take it and go. I never saw you, understood?%SPEECH_OFF%",
				"As you near the market, a passing drunk addresses you with a slurred greeting, then produces a small box from under their ragged cloak. %SPEECH_ON%Took you long enough, take it and be quick, the boss is waiting.%SPEECH_OFF%They push the box into your chest and slink past, quickly resuming their act with a hiccup and some surprisingly good singing."
			),
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [{
				Text = "{Pick the package and head out.}",
				function getResult() {
					this.Contract.m.Town.getSprite("selection").Visible = false;
					this.Contract.m.Camp = ::WeakTableRef(::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getNearestSettlement(::World.State.getPlayer().getTile()));
					this.Contract.m.Camp.getFlags().set("isContractLocation", true);
					this.Contract.m.Camp.setDiscovered(true);
					::World.uncoverFogOfWar(this.Contract.m.Camp.getPos(), 250.0);
					::Settings.getTempGameplaySettings().CameraLocked = false;
					::World.getCamera().Zoom = 1.0;
					::World.getCamera().setPos(this.Contract.m.Camp.getPos());
					if (!::World.Assets.getStash().hasEmptySlot())
						::World.Assets.getStash().makeEmptySlots(1);
					::World.Assets.getStash().add(::new("scripts/items/misc/legend_smuggle_box_item"));
					this.Contract.setState("Delivery");
					return 0;
				}
			}]
		});

		this.m.Screens.push({
			ID = "Ambush",
			Title = "At bandit camp...",
			Text = ::format("[img]gfx/ui/events/event_05.png[/img]{%s | %s}",
				"You arrive at the camp, package in hand — but you're not alone. Steel flashes from the treeline as enemies pour in. %SPEECH_ON%You bastards, lay down your arms and surrender the contraband!%SPEECH_OFF%",
				"As you hand the package to %employer%'s hands, a rustling sounds come from nearby bushes. %SPEECH_ON%Thought you could smuggle goods into outlaw hands under our noses and get away with it? Get them all!%SPEECH_OFF%"
			),
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "{Oh shit.}",
				function getResult() {
					this.Contract.setState("Ambush");
					return 0;
				}
			}],
			function start() {}
		});

		this.m.Screens.push({
			ID = "Success",
			Title = "At bandit camp...",
			Text = ::format("[img]gfx/ui/events/event_05.png[/img]{%s | %s}",
				"You hand over the package over to the %employer%.%SPEECH_ON%Give me that and scram.%SPEECH_OFF%You leave the camp, wondering if you really did the right thing.",
				"As you near the camp, several figures approach with steel at the ready. %randombrother% reaches for their weapon, but stops as one of the bandits speak. %SPEECH_ON%You have it?%SPEECH_OFF% A nod and gesture to the package in your arms disarms any tension. They produce a purse, tossing it your way. You catch it as you set the package on the floor. %SPEECH_ON%As agreed, it's %reward_count% crowns. Now, if you don\'t mind.%SPEECH_OFF% They look away from the camp, then back to you. %SPEECH_ON%Piss off.%SPEECH_OFF%"
			)
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "{Perhaps, such is life.}",
				function getResult() {
					::World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess);
					::World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
					::World.Contracts.finishActiveContract();
					return 0;
				}
			}],
			function start() {
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
			}
		});

		this.m.Screens.push({
			ID = "FailedPursuit",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_05.png[/img]{Defeated, you run from the battlefield. Package is lost.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "{This is not worth losing the company over...}",
				function getResult() {
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract(true);
					return 0;
				}
			}],
			function start() {}
		});

		this.m.Screens.push({
			ID = "FailedAmbush",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_05.png[/img]{Defeated, you run from the battlefield. Package is lost, your employer at mercy of local authorities. Let's hope there will be no further consequences.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "{This is not worth losing the company over...}",
				function getResult() {
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract(true);
					return 0;
				}
			}],
			function start() {}
		});
	}

	function onSortByDistance( _a, _b ) {
		local distance1 = _a.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		local distance2 = _b.getTile().getDistanceTo(::World.State.getPlayer().getTile());
		if (distance1 > distance2)
			return 1;
		if (distance1 < distance2)
			return -1;
		return 0;
	}

	function spawnPursuitParty() {
		local tile = this.getTileToSpawnLocation(::World.State.getPlayer().getTile(), 8, 12);

		local party = null;
		if (this.getDifficulty() <= 2) { // we want militia party for these
			party = ::World.FactionManager.getFactionOfType(::Const.FactionType.FreeCompany)
				.spawnEntity(tile, this.m.Town.getName() + " Militia", false, ::Const.World.Spawn.Militia, 80 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
			party.getSprite("banner").setBrush(this.m.Town.getBanner());
			party.setDescription("Brave men defending their homes with their lives. Farmers, craftsmen, artisans - but not one real soldier.");
			party.setFootprintType(this.Const.World.FootprintsType.Militia);
		} else { // hardest should spawn nobles
			party = ::World.FactionManager.getFactionOfType(::Const.FactionType.FreeCompany)
				.spawnEntity(tile, "Patrol", false, ::Const.World.Spawn.Noble, 80 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
			party.getSprite("banner").setBrush(::World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse")).getBannerSmall());
			party.setDescription("Professional soldiers in service to local lords.");
			party.setFootprintType(::Const.World.FootprintsType.Nobles);
		}
		if (this.getDifficulty() >= 2) { // attach small unit of mercenaries
			local oldMinR = ::Const.World.Spawn.Mercenaries.MinR;
			::Const.World.Spawn.Mercenaries.MinR = 0;
			this.addUnitsToEntity(party, ::Const.World.Spawn.Mercenaries, 25 * this.getDifficultyMult() * this.getScaledDifficultyMult());
			::Const.World.Spawn.Mercenaries.MinR = oldMinR;
			party.setDescription(party.getDescription() + " Small mercenary contingent attached.");
		}

		party.getLoot().Money = this.Math.rand(50, 100);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Medicine = this.Math.rand(0, 2);
		party.getLoot().Ammo = this.Math.rand(0, 20);
		party.setMovementSpeed(::Const.World.MovementSettings.Speed * 2.0);

		local r = this.Math.rand(1, 6);
		if (r == 1) {
			party.addToInventory("supplies/bread_item");
		} else if (r == 2) {
			party.addToInventory("supplies/roots_and_berries_item");
		} else if (r == 3) {
			party.addToInventory("supplies/dried_fruits_item");
		} else if (r == 4) {
			party.addToInventory("supplies/ground_grains_item");
		} else if (r == 5) {
			party.addToInventory("supplies/pickled_mushrooms_item");
		}

		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);

		local c = party.getController();
		local intercept = this.new("scripts/ai/world/orders/intercept_order");
		intercept.setTarget(::World.State.getPlayer());
		c.addOrder(intercept);
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee)
			.setEnabled(true);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack)
			.setEnabled(true);
		return party;
	}

	function spawnRevengeParty() {
		local tile = this.getTileToSpawnLocation(::World.State.getPlayer().getTile(), 6, 8);
		if (this.m.Camp != null && !this.m.Camp.isNull())
			tile = this.m.Camp.getTile();
		local oldMaxR = ::Const.World.Spawn.BanditArmy.MaxR;
		::Const.World.Spawn.BanditArmy.MaxR = 1200;
		local party = ::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits)
			.spawnEntity(tile, "Your employer", false, ::Const.World.Spawn.BanditArmy, 130 * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		::Const.World.Spawn.BanditArmy.MaxR = oldMaxR;
		party.setDescription("Bandit army of your employer.");
		party.setFootprintType(::Const.World.FootprintsType.Brigands);
		party.getLoot().Money = this.Math.rand(50, 100);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Medicine = this.Math.rand(0, 2);
		party.getLoot().Ammo = this.Math.rand(0, 20);
		party.setMovementSpeed(::Const.World.MovementSettings.Speed * 2.0);

		local r = this.Math.rand(1, 6);
		if (r == 1) {
			party.addToInventory("supplies/bread_item");
		} else if (r == 2) {
			party.addToInventory("supplies/roots_and_berries_item");
		} else if (r == 3) {
			party.addToInventory("supplies/dried_fruits_item");
		} else if (r == 4) {
			party.addToInventory("supplies/ground_grains_item");
		} else if (r == 5) {
			party.addToInventory("supplies/pickled_mushrooms_item");
		}

		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);

		local c = party.getController();
		local intercept = this.new("scripts/ai/world/orders/intercept_order");
		intercept.setTarget(::World.State.getPlayer());
		c.addOrder(intercept);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack)
			.setEnabled(true);
		return party;
	}

	function spawnAmbushParty(_properties) {
		if (this.getDifficulty() <= 2) { // we want militia party for these
			::Const.World.Common.addUnitsToCombat(_properties.Entities, ::Const.World.Spawn.Militia, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult(), ::Const.Faction.Enemy);
			_properties.EnemyBanners = [this.m.Town.getBanner()];
		} else { // hardest should spawn nobles
			::Const.World.Common.addUnitsToCombat(_properties.Entities, ::Const.World.Spawn.Noble, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult(), ::Const.Faction.Enemy);
			_properties.EnemyBanners = [::World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse")).getBanner()];
		}
		if (this.getDifficulty() >= 2) { // attach small unit of mercenaries
			local oldMinR = ::Const.World.Spawn.Mercenaries.MinR;
			::Const.World.Spawn.Mercenaries.MinR = 0;
			::Const.World.Common.addUnitsToCombat(_properties.Entities, ::Const.World.Spawn.Mercenaries, 50 * this.getDifficultyMult() * this.getScaledDifficultyMult(), ::Const.Faction.Enemy);
			::Const.World.Spawn.Mercenaries.MinR = oldMinR;
		}
		::Const.World.Common.addUnitsToCombat(_properties.Entities, ::Const.World.Spawn.BanditDefenders, 50 * this.getDifficultyMult() * this.getScaledDifficultyMult(), ::Const.Faction.PlayerAnimals);
	}

	function onPrepareVariables(_vars) {
		if (this.m.Town != null) {
			_vars.push([
				"Town",
				this.m.Town.getName()
			]);
		}
	}

	function onClear() {
		if (!this.m.IsActive)
			return;

		if (this.m.Town != null && !this.m.Town.isNull()) {
			this.m.Town.getSprite("selection").Visible = false;
		}
		if (this.m.Camp != null && !this.m.Camp.isNull()) {
			this.m.Camp.getSprite("selection").Visible = false;
			this.m.Camp.getFlags().remove("isContractLocation");
			this.m.Camp.setOnCombatWithPlayerCallback(null);
		}
		if (this.m.PursuitParty != null && !this.m.PursuitParty.isNull() && this.m.PursuitParty.isAlive()) {
			if (this.m.PursuitParty.getFaction() != ::Const.Faction.Bandits)
				this.m.PursuitParty.die();
		}
		this.m.PursuitParty = null;
		local stash = ::World.Assets.getStash().getItems();
		foreach( i, item in stash ) {
			if (item != null && item.getID() == "misc.legend_smuggle_box") {
				stash[i] = null;
			}
		}
	}

	function onSerialize(_out) {
		_out.writeU32((this.m.Town != null && !this.m.Town.isNull()) ? this.m.Town.getID() : 0);
		_out.writeU32((this.m.Fortress != null && !this.m.Fortress.isNull()) ? this.m.Fortress.getID() : 0);
		_out.writeU32((this.m.Camp != null && !this.m.Camp.isNull()) ? this.m.Camp.getID() : 0);
		_out.writeU32((this.m.PursuitParty != null && !this.m.PursuitParty.isNull()) ? this.m.PursuitParty.getID() : 0);
		this.contract.onSerialize(_out);
	}

	function onDeserialize(_in) {
		local target = _in.readU32();
		if (target != 0) {
			this.m.Town = ::WeakTableRef(::World.getEntityByID(target));
		}
		target = _in.readU32();
		if (target != 0) {
			this.m.Fortress = ::WeakTableRef(::World.getEntityByID(target));
		}
		target = _in.readU32();
		if (target != 0) {
			this.m.Camp = ::WeakTableRef(::World.getEntityByID(target));
		}
		target = _in.readU32();
		if (target != 0) {
			local entity = ::World.getEntityByID(target);
			if (entity != null) {
				this.m.PursuitParty = ::WeakTableRef(entity);
			}
		}
		this.contract.onDeserialize(_in);
	}
});
