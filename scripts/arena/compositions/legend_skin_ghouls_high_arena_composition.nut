this.legend_skin_ghouls_high_arena_composition <- this.inherit("scripts/arena/compositions/legend_skin_ghouls_low_arena_composition", {
	m = {},

	function create() {
		this.legend_skin_ghouls_low_arena_composition.create();
		this.m.Type = "arena_composition.legend_skin_ghouls_high";
		this.m.DisplayName = "Skin Ghouls";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendSkinGhoulHigh
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.LegendSkinGhoulMedium,
			::BDP.Arena.EntityTypes.LegendSkinGhoulMedium,
			::BDP.Arena.EntityTypes.LegendSkinGhoulLow,
			::BDP.Arena.EntityTypes.LegendSkinGhoulLow
		];
		this.m.Pay = 475;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 90;
		this.m.MinDay = 35;
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.max(_difficulty, 2);
	}
});
