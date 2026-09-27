::mods_hookBaseClass("arena/arena", function(o) {
	o.getFightsPerDay = @() ::World.Assets.m.IsArenaTooled ? 3 : 1;

	o.updateAdditionalLoot = function () {
		if (!(this.m.MatchesFoughtTotal > this.m.LastMatchLootUpdate && this.m.MatchesFoughtTotal % 5 == 0))
			return;

		this.m.LastMatchLootUpdate = this.m.MatchesFoughtTotal;

		this.m.AdditionalLoot.add(::Legends.Arena.pickLoot(this.m.MatchesFoughtTotal));
	}
});
