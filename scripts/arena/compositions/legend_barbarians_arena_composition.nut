this.legend_barbarians_arena_composition <- this.inherit("scripts/arena/compositions/legend_barbarians_low_arena_composition", {
	m = {},

	function create() {
		this.legend_barbarians_low_arena_composition.create();
		this.m.Type = "arena_composition.legend_barbarians";
		this.m.DisplayName = "Barbarians";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.BarbarianReaver
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.BarbarianThrall,
			::BDP.Arena.EntityTypes.BarbarianReaver,
			::BDP.Arena.EntityTypes.BarbarianReaver,
			::BDP.Arena.EntityTypes.BarbarianChosen
		];
		this.m.PotentialChampions = [
			::BDP.Arena.EntityTypes.ChampionBarbarianChosen
		];
		this.m.Pay = 300;
		this.m.BaseStrength = 40;
		this.m.MinDay = 10;
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = _difficulty;
	}
});
