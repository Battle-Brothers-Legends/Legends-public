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
