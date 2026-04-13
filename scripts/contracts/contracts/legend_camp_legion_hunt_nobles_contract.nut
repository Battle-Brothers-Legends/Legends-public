this.legend_camp_legion_hunt_nobles_contract <- this.inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Target = null,
		IsPlayerAttacking = true
	},

	function create() {
		this.legend_camp_contract.create();
		this.m.Type = "contract.legend_camp_legion_hunt_nobles_contract";
		this.m.Name = "Hunt: Nobles";
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Legion;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = ::Math.rand(95, 125) * 0.01;
		this.m.DescriptionTemplates = [
			"A Noble house patrol is too close to discovering a nearby camp of ours.",
			"Cause infighting between the Noble houses by murdering one of their patrols.",
		];
		this.m.Payment.ItemPool = [
			[25, "supplies/medicine_item"],
			[25, "supplies/armor_parts_item"],
			[15, "tools/reinforced_throwing_net"],
			[15, @() [
				[70, "weapons/ancient/legend_broken_decorated_sword"],
				[70, "weapons/ancient/legend_broken_spatha"],
				[50, "weapons/ancient/legend_sica"],
				[50, "weapons/ancient/legend_gladius"],
				[50, "weapons/ancient/legend_spatha"],
				[50, "weapons/ancient/legend_decorated_sword"],
				[50, "weapons/ancient/legend_broadhead_spear"],
				[50, "weapons/ancient/legend_oxtongue_spear"],
				[30, "weapons/ancient/legend_decorated_rhomphaia"],
				[30, "weapons/ancient/legend_kopis"],
				[20, "weapons/ancient/legend_honed_warscythe"],
				[20, "weapons/ancient/legend_broad_warscythe"],
				[20, "weapons/ancient/legend_military_crypt_cleaver"],
				[20, "weapons/ancient/legend_military_rhomphaia"],
				[20, "weapons/legend_drum"],
			]],
			[5, @() [
				[20, "ammo/large_quiver_of_bolts"],
				[20, "ammo/legend_large_broad_head_bolts"],
				[20, "ammo/legend_large_broad_head_arrows"],
				[20, "ammo/legend_large_armor_piercing_bolts"],
				[20, "ammo/legend_large_armor_piercing_arrows"],
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

	function isVisible()
	{
		// exclude bottom half of the map
		local currentTile = ::World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y < ::World.getMapSize().Y * 0.5)
			return false;
		return true;
	}

	function start() //payment & rewards
	{
		this.m.Payment.Pool = 350 * this.getPaymentMult() * ::Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Destroy the Noble house patrol",
					"Do not leave any survivors"
				];

				if (::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance)
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
				local r = ::Math.rand(1, 100);
				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Contract.spawnEnemies();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.has("Survivors") && this.Flags.getAsInt("Survivors") > 0)
				{
					local target = this.Contract.m.Target;
					if (target != null) {
						::World.EntityManager.onWorldEntityDestroyed(target, false);
						target.onCombatLost();
					}
					this.Contract.m.Target = null;
				}

				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					this.Contract.setScreen("AfterBattle");
					this.World.Contracts.showActiveContract();

					if (this.Flags.getAsInt("Survivors") == 0)
					{
						this.Contract.setState("Return");
					}

					else
					{
						this.Contract.setState("Chase");
					}
				}
			}

			function onTargetAttacked(_dest, _isPlayerAttacking)
			{
				this.Flags.set("Survivors", this.Contract.m.Target.getTroops().len());
				if (!this.Flags.get("IsEncounterShown")) {
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				} else {
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (!::Legends.S.oneOf(_actor.getFaction(), ::Const.Faction.Player, ::Const.Faction.PlayerAnimals)) {
					this.Flags.increment("Survivors", -1);
				}
			}
		});
		this.m.States.push({
			ID = "Chase",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you."
				];
				this.Contract.spawnRevengeEnemies();
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull()) {
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked(_dest, _isPlayerAttacking)
			{
				if (!this.Flags.get("IsNobleResponseShown"))
				{
					this.Flags.set("IsNobleResponseShown", true);
					this.Contract.setScreen("NobleResponse");
					this.World.Contracts.showActiveContract();
				}

				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}
		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Wait for your employer to contact you."
				];
			}

			function update()
			{
				this.Contract.setScreen("Success");
				this.World.Contracts.showActiveContract();
			}

		});
	}

	function createScreens()
	{
		this.importScreens(::Const.Contracts.NegotiationItemsOnly()); //for legion, may be better to create new negotiation templates as a hook in 'intro templates'?
		this.importScreens(::Const.Contracts.Overview);

		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{%employer% approaches you in camp. %SPEECH_ON%A patrol is nearby. It has been getting closer and closer to one of our larger camps. Destroy the patrol and place this shield at the battlefield to misdirect the enemy into fighting one another.%SPEECH_OFF% The messenger pauses as both of your hands at at the brim of the shield. An important message follows. %SPEECH_ON%Do not allow any to escape.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Let's talk business.}",
					function getResult() {
						return "Negotiation";
					}

				},
				{
					Text = "{We can\'t take this on right now.}",
					function getResult() {
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			]
		});

		this.m.Screens.push({ //noble patrol
			ID = "Encounter",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_55.png[/img]{You find the patrol %employer% was talking about. They sit completely unprepared for your arrival. The words ring through your hollow mind again... %SPEECH_ON%Do not allow any to escape.%SPEECH_OFF%}",
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

		this.m.Screens.push({ //if not everyone killed = noble response party
			ID = "NobleResponse",
			Title = "Closing in...",
			Text = "[img]gfx/ui/events/event_90.png[/img]{The few survivors that escaped your attack have gotten word out. In the distance, a much larger, more prepared forces tightens the noose around you...}",
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
			Text = "[img]gfx/ui/events/event_60.png[/img]{The battlefield is lain astrew with gore and metal. You take what you can and leave a shield belonging to another Noble house in a treeline not far from the battle.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Time to return.",
					function getResult() {
						return 0;
					}
				}
			],
			function start() {
				if (this.Flags.getAsInt("Survivors") != 0)
				{
					this.Text = "[img]gfx/ui/events/event_22.png[/img]{You perform a brief headcount, first of your own fighters, then a slower, more methodical count of the patrol.\n\n Some are missing.}";
					this.Options = [
						{
							Text = "We need to leave.",
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
			Text = "[img]gfx/ui/events/event_36.png[/img]{You return to %employer%. Little is said, but a mutual understanding is held.\n\n They silently pass you the reward and depart.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "A successful hunt.",
				function getResult() {
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
					this.World.Contracts.finishActiveContract();
					return 0;
				}
			}],
			function start() { //to do
				this.List.extend(::Legends.EventList.addItems(this.Contract.m.Payment.Items, ::World.Assets.getStash()));
			}
		});

		this.m.Screens.push({ //to do
			ID = "Failure",
			Title = "After battle...",
			Text = "[img]gfx/ui/events/legend_rock_unhold.png[/img]{Some memmbers of the patrol escaped. You sense there will be repercussions for this.}",
			Image = "",
			List = [],
			Options = [{
				Text = "Unfortunate.",
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
		local nearTile = this.getTileToSpawnLocation(playerTile, 1, 3);

		local faction = ::World.FactionManager.getFactionOfType(this.Const.FactionType.NobleHouse);

		local party = faction.spawnEntity(tile, "Scouting Party", false, ::Const.World.Spawn.NobleCaravan, ::Math.rand(90, 105) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A small scouting party of a Noble house.");
		party.setAttackableByAI(false);
		party.getFlags().set("IsRandomlySpawned", true);

		party.getLoot().Money = this.Math.rand(21, 111);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		// party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(0, 30);

		::Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), ::Const.GenericFootprints, 0.85);
		this.m.Target = this.WeakTableRef(party);

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

	function spawnRevengeEnemies()
	{
		local playerTile = ::World.State.getPlayer().getTile();
		local tile = this.getTileToSpawnLocation(playerTile, 6, 12, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Tundra
		]);
		local nearTile = this.getTileToSpawnLocation(playerTile, 4, 8);

		local faction = ::World.FactionManager.getFactionOfType(this.Const.FactionType.NobleHouse);

		local party = faction.spawnEntity(tile, "Patrol", false, ::Const.World.Spawn.Noble, ::Math.rand(95, 115) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());

		party.setDescription("A large force hunting you down.");
		party.setMovementSpeed(::Const.World.MovementSettings.Speed * 1.5);
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

	function onPrepareVariables(_vars)
	{
	}

	function onClear() {
		if (!this.m.IsActive)
			return;

		if (this.m.Target != null && !this.m.Target.isNull()) {
			this.m.Target.getSprite("selection").Visible = false;
			this.m.Target.setOnCombatWithPlayerCallback(null);
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
