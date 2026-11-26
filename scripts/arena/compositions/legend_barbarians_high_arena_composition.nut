this.legend_barbarians_high_arena_composition <- this.inherit("scripts/arena/compositions/legend_barbarians_low_arena_composition", {
	m = {},

	function create() {
		this.legend_barbarians_low_arena_composition.create();
		this.m.Type = "arena_composition.legend_barbarians_high";
		this.m.DisplayName = "Barbarians";
		this.m.DisplayText = "\"These are the ones the other northerners are afraid of. \'Chosen\', they call themselves, though by whom I could not say, the Gilder certainly never chose them. They wear half a smithy on their backs and still swing a hammer as if it were a reed. Try not to stand where it lands.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.BarbarianChosen
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.BarbarianChosen,
			::BDP.Arena.EntityTypes.BarbarianChosen,
			::BDP.Arena.EntityTypes.BarbarianReaver,
			::BDP.Arena.EntityTypes.BarbarianReaver
		];
		this.m.PotentialChampions = [
			::BDP.Arena.EntityTypes.ChampionBarbarianChosen
		];
		this.m.Pay = 425;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 45;
		this.m.MinDay = 25;
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.max(_difficulty, 2);
	}
});
