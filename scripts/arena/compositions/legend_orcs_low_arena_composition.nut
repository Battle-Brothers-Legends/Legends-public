this.legend_orcs_low_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_orcs_low";
		this.m.DisplayName = "Orcs";
		this.m.DisplayText = "\"Greenskins! Young ones, mind you, barely bigger than a camel and only twice as ill-tempered. The hunters catch them before they are done growing, which I am told is the only time anyone catches them at all. They have no notion of fear and even less of tactics, so they will simply run at you. Do with that what you will.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.OrcYoung
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.OrcYoung
		];
		this.m.Pay = 225;
		this.m.AllowedEntrants = 3;
		this.m.BaseStrength = 32;
		this.m.MinDay = 5;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Orcs;
		titles.extend(::BDP.Arena.CompositionTitles.Steppe);
		titles.extend(::BDP.Arena.CompositionTitles.Hill);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.Orcs) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.min(_difficulty, 2);
	}
});
