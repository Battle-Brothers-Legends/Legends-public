this.legend_orcs_arena_composition <- this.inherit("scripts/arena/compositions/legend_orcs_low_arena_composition", {
	m = {},

	function create() {
		this.legend_orcs_low_arena_composition.create();
		this.m.Type = "arena_composition.legend_orcs";
		this.m.DisplayName = "Orcs";
		this.m.DisplayText = "\"Orc warriors. Each one is a wall of meat wrapped in whatever iron it tore off the last man who fought it. It took eleven manhunters and a siege chain to get them into the pens, and nine manhunters came back. The crowd adores them, so do try to last long enough to be worth the seat.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.OrcWarrior
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.OrcYoung,
			::BDP.Arena.EntityTypes.OrcYoung,
			::BDP.Arena.EntityTypes.OrcBerserker,
			::BDP.Arena.EntityTypes.OrcWarrior
		];
		this.m.PotentialChampions = [
			::BDP.Arena.EntityTypes.ChampionOrcWarlord
		];
		this.m.Pay = 350;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 50;
		this.m.MinDay = 15;
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = _difficulty;
	}
});
