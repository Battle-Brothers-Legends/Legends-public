this.legend_orcs_high_arena_composition <- this.inherit("scripts/arena/compositions/legend_orcs_low_arena_composition", {
	m = {},

	function create() {
		this.legend_orcs_low_arena_composition.create();
		this.m.Type = "arena_composition.legend_orcs_high";
		this.m.DisplayName = "Orcs";
		this.m.DisplayText = "\"I will not lie to you, Crownling, I argued against this one. A warlord of the greenskins and his warband, here, in my arena! The pit crew drew lots to decide who has to open the gate. If you live, the Viziers themselves will know your name. If you do not, well, at least it will be quick, haghaghagh!\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.OrcWarlord
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.OrcWarrior,
			::BDP.Arena.EntityTypes.OrcWarrior,
			::BDP.Arena.EntityTypes.OrcBerserker,
			::BDP.Arena.EntityTypes.OrcYoung
		];
		this.m.Pay = 500;
		this.m.AllowedEntrants = 5;
		this.m.BaseStrength = 60;
		this.m.MinDay = 30;
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.max(_difficulty, 2);
	}
});
