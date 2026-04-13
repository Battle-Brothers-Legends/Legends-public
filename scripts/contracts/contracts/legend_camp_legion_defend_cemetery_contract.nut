this.legend_camp_legion_defend_cemetery_contract <- ::inherit("scripts/contracts/legend_camp_contract", {
	m = {
		Destination = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.legend_camp_contract.create();
		this.m.Type = "contract.legend_camp_legion_defend_cemetery";
		this.m.Name = "Defend burial site";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 10.0;
		this.m.EmployerFaction = ::Legends.CampContracts.EmployerFaction.Legion;
		this.m.DifficultyMult = ::Math.rand(95, 125) * 0.01;
		this.m.DescriptionTemplates = [
			"Sacred burial site is threatened, action should be taken.",
			"Reports indicate a band of hired blades looting tombs for valuables.",
			"Grave robbers under mercenary contract are stripping the crypts bare.",
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

	function setDestination(_d) {
		this.m.Destination = ::WeakTableRef(_d);
	}

	function start() {
		if (this.m.Destination == null || this.m.Destination.isNull()) {
			local playerTile = ::World.State.getPlayer().getTile();
			local locations = ::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getSettlements()
				.filter(@(_, _loc) ::Legends.S.oneOf(_loc.getTypeID(), "location.undead_graveyard", "location.undead_crypt"));
			locations.sort(@(a, b) playerTile.getDistanceTo(b.getTile()) <=> playerTile.getDistanceTo(a.getTile()));
			this.m.Destination = ::WeakTableRef(locations.top());
		}
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Flags.set("DestinationFaction", this.m.Destination.getFaction());
		this.m.Destination.setFaction(::Const.Faction.PlayerAnimals);
		this.m.Payment.Pool = 800 * this.getPaymentMult() * ::Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		this.contract.start();
	}

	function createStates() {
		this.m.States.push({
			ID = "Offer",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					::format("Travel to %s", this.Flags.get("DestinationName")),
					::format("Defend %s from invaders", this.Flags.get("DestinationName")),
				];
				this.Contract.setScreen(::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance ? "Intro" : "Task");
			}

			function end() {
				this.Contract.m.Destination.setDiscovered(true);
				::World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.setScreen("Overview");
				::World.Contracts.setActiveContract(this.Contract);
			}
		});

		this.m.States.push({
			ID = "Running",
			function start() {
				if (!::Legends.S.isNull(this.Contract.m.Destination)) {
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}
			}

			function update() {
				if (!::Legends.S.isNull(this.Contract.m.Destination)) {
					if (this.Contract.m.Destination.getTile().getDistanceTo(::World.State.getPlayer().getTile()) < 3) {
						this.Contract.setScreen("Arrival");
						::World.Contracts.showActiveContract();
					}
				}

				if (::Legends.S.isNull(this.Contract.m.Destination) || !this.Contract.m.Destination.isAlive()) {
					this.Contract.setScreen("FailedDestroyed");
					::World.Contracts.showActiveContract();
				}
			}
		});

		this.m.States.push({
			ID = "Defending",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					::format("Defend %s from invaders", this.Flags.get("DestinationName"))
				];
				if (!::Legends.S.isNull(this.Contract.m.Destination)) {
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.m.IsAttackable = false;
				}
			}

			function update() {
				if (::Legends.S.isNull(this.Contract.m.Destination) || !this.Contract.m.Destination.isAlive()) {
					this.Contract.setScreen("FailedDestroyed");
					::World.Contracts.showActiveContract();
				}
				this.Contract.updateSpawnedUnits();

				if (this.Contract.m.UnitsSpawned.len() == 0) {
					this.Contract.setState("Return");
					return;
				}

				foreach (party in this.Contract.m.UnitsSpawned.map(@(_it) ::World.getEntityByID(_it))) {
					if (party.getController().getCurrentOrder() == null) {
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						break;
					}
				}
			}
		});

		this.m.States.push({
			ID = "Return",
			function start() {
				this.Contract.m.BulletpointsObjectives = [
					"Wait for messenger to contact you."
				];
				this.Contract.m.Flags.set("WaitReward", ::Time.getVirtualTimeF() + ::World.getTime().SecondsPerDay * 0.05)
			}

			function update() {
				if (::Time.getVirtualTimeF() > this.Contract.m.Flags.get("WaitReward")) {
					this.Contract.setScreen("Success");
					::World.Contracts.showActiveContract();
				}
			}
		});
	}

	function createScreens() {
		this.importScreens(::Const.Contracts.NegotiationItemsOnly());
		this.importScreens(::Const.Contracts.Overview);

		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{ %employer% approaches you and gives you a sealed scroll. You break the seal and read. %SPEECH_ON%There has been suspicious activity near %location%. Tracks of graverobbers sniffing around were found. You're to investigate this matter. Go out to the cemetery and end this nuisance once and for all!%SPEECH_OFF% }",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [{
				Text = "We'll need compensation.",
				getResult = @() "Negotiation"
			}, {
				Text = "Not interested.",
				function getResult() {
					this.World.Contracts.removeContract(this.Contract);
					return 0;
				}
			}],
			function start() {}
		});

		this.m.Screens.push({
			ID = "Success",
			Title = "Success",
			Text = "[img]gfx/ui/events/event_73.png[/img]For glory! It looks like they learned their lesson. %location% will be safe for a while. Meanwhile carriage sent by %employer% arrived and you start unloading.",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [{
				Text = "For glory!",
				function getResult() {
					if (!::Legends.S.isNull(this.Contract.m.Destination)) {
						this.Contract.m.Destination.setFaction(this.Contract.m.Flags.getAsInt("DestinationFaction"));
					}
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess);
					this.World.Contracts.finishActiveContract();
					return 0;
				}
			}],
			function start() {
				this.List.extend(::Legends.EventList.addItems(this.Contract.m.Payment.Items, ::World.Assets.getStash()));
			}
		});
		this.m.Screens.push({
			ID = "FailedDestroyed",
			Title = "FailedDestroyed",
			Text = "[img]gfx/ui/events/event_46.png[/img]%location% has fallen, graves robbed, crypts plundered. %SPEECH_ON%I suppose that\'s it, then.%SPEECH_OFF%%randombrother% says. %employer% will { not be pleased | be furious }.",
			Image = "",
			List = [],
			Options = [{
				Text = "A shame.",
				function getResult() {
					if (!::Legends.S.isNull(this.Contract.m.Destination)) {
						this.Contract.m.Destination.setFaction(this.m.Flags.getAsInt("DestinationFaction"));
					}
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract(true);
					return 0;
				}
			}],
			function start() {
				foreach (party in this.Contract.m.UnitsSpawned.map(@(_it) ::World.getEntityByID(_it))) {
					party.die();
				}
				this.Contract.updateSpawnedUnits();
			}
		});
		this.m.Screens.push({
			ID = "Arrival",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_57.png[/img]As you arrived near burial place, you see signs of recent human activity. Best we can do now is to stay around and fend off any graverobbers.",
			Image = "",
			List = [],
			Options = [{
				Text = "Let's take a look around.",
				function getResult() {
					return 0;
				}
			}],
			function start() {
				this.Contract.spawnEnemies();
				this.Contract.setState("Defending");
			}
		});
	}

	function spawnEnemies() {
		this.m.UnitsSpawned.extend([
			this.spawnMercenaries(10).getID(),
			this.spawnMercenaries(20).getID()
		]);
	}

	function spawnMercenaries(_distance) {
		local nearTile = this.getTileToSpawnLocation(this.m.Destination.getTile(), _distance - 2, _distance + 2);
		local names = ::Const.Strings.MercenaryCompanyNames;

		local spawnType = ::Const.World.Spawn.BanditScouts;
		if (::World.Assets.getBusinessReputation() > 1500)
			spawnType = ::Const.World.Spawn.BanditRaiders;
		if (::World.Assets.getBusinessReputation() > 2500)
			spawnType = ::Const.World.Spawn.Mercenaries;

		local faction = ::World.FactionManager.getFactionOfType(::Const.FactionType.FreeCompany);
		local party = faction.spawnEntity(nearTile, names[::Math.rand(0, names.len() - 1)], false, spawnType, ::Math.rand(75, 90) * this.getDifficultyMult() * this.getScaledDifficultyMult(), this.getMinibossModifier());
		party.setDescription("A party of graberobbers and pillagers.");
		party.setAttackableByAI(false);

		party.getLoot().Money = this.Math.rand(21, 111);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(0, 30);

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);

		local raid = this.new("scripts/ai/world/orders/raid_order");
		raid.setTime(60.0);
		raid.setTargetTile(this.m.Destination.getTile());
		c.addOrder(raid);

		return party;
	}

	function onIsValid() {
		if (!this.m.IsStarted)
			return true;
		if (::Legends.S.isNull(this.m.Destination))
			return false;
		if (!this.m.Destination.isAlive())
			return false;
		return true;
	}

	function onPrepareVariables( _vars ) {
		_vars.push(["location", this.m.Flags.get("DestinationName")]);
	}

	function onClear() {
		if (this.m.IsActive) {
			if (!::Legends.S.isNull(this.m.Destination)) {
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.m.IsAttackable = true;
			}
		}
	}

	function onSerialize( _out ) {
		_out.writeU32(::Legends.S.isNull(this.m.Destination) ? 0 : this.m.Destination.getID());
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in ) {
		local destination = _in.readU32();
		if (destination != 0) {
			this.m.Destination = ::WeakTableRef(::World.getEntityByID(destination));
		}
		this.contract.onDeserialize(_in);
	}
});
