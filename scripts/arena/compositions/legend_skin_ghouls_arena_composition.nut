this.legend_skin_ghouls_arena_composition <- this.inherit("scripts/arena/compositions/legend_skin_ghouls_low_arena_composition", {
	m = {},

	function create() {
		this.legend_skin_ghouls_low_arena_composition.create();
		this.m.Type = "arena_composition.legend_skin_ghouls";
		this.m.DisplayName = "Skin Ghouls";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendSkinGhoulMedium,
			::BDP.Arena.EntityTypes.NachzehrerMedium
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.LegendSkinGhoulMedium,
			::BDP.Arena.EntityTypes.LegendSkinGhoulLow,
			::BDP.Arena.EntityTypes.LegendSkinGhoulLow,
			::BDP.Arena.EntityTypes.NachzehrerMedium,
			::BDP.Arena.EntityTypes.NachzehrerLow,
			::BDP.Arena.EntityTypes.NachzehrerLow
		];
		this.m.Pay = 350;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 75;
		this.m.MinDay = 20;
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = _difficulty;
	}
});
