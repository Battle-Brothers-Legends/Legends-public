::mods_hookExactClass("arena/arena", function (o) {
	local getFightsPerDay = o.getFightsPerDay;
	o.getFightsPerDay = function () {
		return this.m.ActiveTournament ? getFightsPerDay() : this.m.CityState.getBuilding("building.arena").getMaxAttempts();
	}

	local startTournament = o.startTournament;
	o.startTournament = function () {
		startTournament();
		this.m.MatchesFought = 0;
	}

	local incrementMatchesFought = o.incrementMatchesFought;
	o.incrementMatchesFought = function () {
		incrementMatchesFought();
		if (!this.m.ActiveTournament) {
			this.m.CityState.getBuilding("building.arena").registerAttempt();
		}
	}

	o.updateAdditionalLoot = function () {
		if (!(this.m.MatchesFoughtTotal > this.m.LastMatchLootUpdate && this.m.MatchesFoughtTotal % 5 == 0)) {
			return;
		}

		this.m.LastMatchLootUpdate = this.m.MatchesFoughtTotal;

		this.m.AdditionalLoot.add(::Legends.Arena.pickLoot(this.m.MatchesFoughtTotal));
	}
});

::mods_hookExactClass("events/events/special/arena_event", function (o) {
	o.m.WasInReserves <- [];
	o.m.IsArenaFlagsSet <- false;

	local onPrepare = o.onPrepare;
	o.onPrepare = function () {
		onPrepare();
		this.m.WasInReserves = [];
		this.m.IsArenaFlagsSet = false;
	}

	// Just testing a catch cause I saw my fights go up by 2 wins instead of one
	// If it works then great, if it doesn't then fuck me ig
	local setArenaFlags = o.setArenaFlags;
	o.setArenaFlags = function () {
		local bros = [];
		foreach (bro in this.m.Bros) {
			if (bros.find(bro) == null) {
				bros.push(bro);
			}
		}
		this.m.Bros = bros;

		if (this.m.IsArenaFlagsSet) {
			::logWarning("Uh oh Stinky!");
			return;
		}

		this.m.IsArenaFlagsSet = true;
		setArenaFlags();
	}

	local buildArenaCombatProperties = o.buildArenaCombatProperties;
	o.buildArenaCombatProperties = function (_players, _entities) {
		foreach (bro in _players) {
			if (bro.isInReserves()) {
				this.m.WasInReserves.push(bro);
				bro.setInReserves(false);
			}
		}
		return buildArenaCombatProperties(_players, _entities);
	}

	local onClear = o.onClear;
	o.onClear = function () {
		foreach (bro in this.m.WasInReserves) {
			bro.setInReserves(true);
		}
		this.m.WasInReserves = [];
		this.m.IsArenaFlagsSet = false;
		onClear();
	}

	local getPromotions = o.getPromotions;
	o.getPromotions = function () {
		// BD+ only knows the ranks up to Arena Veteran, so it would hand an Arena Champion or Invictus a new Pit Fighter trait
		local before = {};
		foreach (bro in this.m.Bros) {
			before[bro.getID()] <- this.getArenaRank(bro);
		}

		local promotions = getPromotions();

		foreach (bro in this.m.Bros) {
			if (!bro.isAlive()) {
				continue;
			}

			local rank = before[bro.getID()];
			if (rank > 0 && this.getArenaRank(bro, rank) >= 0) {
				local prefix = bro.getName() + " is now";
				local kept = [];
				foreach (p in promotions) {
					if (p.text.find(prefix) != 0) {
						kept.push(p);
					}
				}
				promotions = kept;
			}

			::Legends.Arena.updateTraits(promotions, bro);

			local highest = this.getArenaRank(bro);
			foreach (i, tier in ::Legends.Arena.TraitTiers) {
				if (i < highest) {
					::Legends.Traits.remove(bro, tier[1]);
				}
			}
		}
		return promotions;
	}

	o.getArenaRank <- function (_bro, _below = 99) {
		local rank = -1;
		foreach (i, tier in ::Legends.Arena.TraitTiers) {
			if (i < _below && _bro.getSkills().hasTrait(tier[1])) {
				rank = i;
			}
		}
		return rank;
	}
});

foreach (scenario in ["scenarios/world/gladiators_scenario", "scenarios/world/legends_escaped_slaves_scenario"]) {
	::mods_hookExactClass(scenario, function (o) {
		local onSpawnAssets = o.onSpawnAssets;
		o.onSpawnAssets = function () {
			onSpawnAssets();
			foreach (bro in ::World.getPlayerRoster().getAll()) {
				if (bro.getSkills().hasTrait(::Legends.Trait.ArenaFighter)) {
					bro.getFlags().set(::BDP.Arena.Flags.MatchesFought, 5);
					bro.getFlags().set(::BDP.Arena.Flags.HighestDifficulty, 2);
				}
			}
		}
	});
}

::mods_hookExactClass("states/world/arena_manager", function (o) {
	// BD+ only sets up arenas for the city states at the start of a campaign, an arena that is built later (like Stronghold's) gets one when it is first asked for
	local getArenaByCityStateID = o.getArenaByCityStateID;
	o.getArenaByCityStateID = function (_cityStateID) {
		this.removeLostArenas();
		local arena = getArenaByCityStateID(_cityStateID);

		if (arena == null) {
			local settlement = ::World.getEntityByID(_cityStateID);

			if (settlement != null && settlement.hasBuilding("building.arena")) {
				this.buildArena(settlement);
				arena = getArenaByCityStateID(_cityStateID);
			}
		}

		return arena;
	}

	// and it has to go again once that settlement is gone, BD+ expects every arena to have one when it updates and saves
	o.removeLostArenas <- function () {
		this.m.Arenas = this.m.Arenas.filter(@(_, _arena) _arena.getCityState() != null && !_arena.getCityState().isNull() && _arena.getCityState().isAlive());
	}

	local update = o.update;
	o.update = function () {
		if (this.m.LastUpdatedDay < ::World.getTime().Days) {
			this.removeLostArenas();
		}

		update();
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function (_out) {
		this.removeLostArenas();
		onSerialize(_out);
	}
});
