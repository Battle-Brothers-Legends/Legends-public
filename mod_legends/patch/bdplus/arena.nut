::mods_hookExactClass("arena/arena", function (o) {
	o.getFightsPerDay <- @() this.m.CityState.getBuilding("building.arena").getMaxAttempts();

	local incrementMatchesFought = o.incrementMatchesFought;
	o.incrementMatchesFought = function () {
		incrementMatchesFought();
		this.m.CityState.getBuilding("building.arena").registerAttempt();
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
	local getPromotions = o.getPromotions;
	o.getPromotions = function () {
		local promotions = getPromotions();
		foreach (bro in this.m.Bros) {
			if (bro.isAlive() && (bro.getSkills().hasTrait(::Legends.Trait.ArenaVeteran) || bro.getSkills().hasTrait(::Legends.Trait.LegendArenaChampion))) {
				::Legends.Arena.updateTraits(promotions, bro);
			}
		}
		return promotions;
	}
});
