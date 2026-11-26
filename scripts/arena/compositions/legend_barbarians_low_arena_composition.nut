this.legend_barbarians_low_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_barbarians_low";
		this.m.DisplayName = "Barbarians";
		this.m.DisplayText = "\"Northern savages, the lot of them. The manhunters dragged these down from wherever it is the snow never melts, and they have not stopped howling about their ancestors since. I am told they believe that dying well earns them a seat at some frozen table, so do them the kindness, yes? And do it loudly, the crowd pays for loud.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.BarbarianThrall
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.BarbarianThrall,
			::BDP.Arena.EntityTypes.BarbarianThrall,
			::BDP.Arena.EntityTypes.BarbarianThrall,
			::BDP.Arena.EntityTypes.BarbarianReaver
		];
		this.m.Pay = 225;
		this.m.AllowedEntrants = 3;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Barbarians;
		titles.extend(::BDP.Arena.CompositionTitles.Mountain);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.Barbarians) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.min(_difficulty, 2);
	}
});
