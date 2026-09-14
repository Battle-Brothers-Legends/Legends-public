::mods_hookExactClass("entity/world/settlement_modifiers", function(o) {
	o.StablesMult <- 1.0;

	local reset = o.reset;
	o.reset = function () {
		reset();
		this.StablesMult = 1.0;
		this.RecruitsMult = ::Legends.Difficulty.RecruitsMult[::World.Assets.getEconomicDifficulty()];
	}
});
