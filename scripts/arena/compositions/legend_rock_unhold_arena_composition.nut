this.legend_rock_unhold_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_rock_unhold";
		this.m.DisplayName = "Rock Unholds";
		this.m.DisplayText = "\"You know the giants of the north, the \'unholds\'? These two are to those what those are to you. Their hides are like quarried stone, the handlers broke nine spears on one of them and it did not so much as turn around. I am told they mend their wounds while they fight, so my advice is to hurt them faster than that. Simple, yes?\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendRockUnhold,
			::BDP.Arena.EntityTypes.LegendRockUnhold
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.Unhold
		];
		this.m.Pay = 550;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 115;
		this.m.MinDay = 40;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Unholds;
		titles.extend(::BDP.Arena.CompositionTitles.Mountain);
		titles.extend(::BDP.Arena.CompositionTitles.Hill);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.RockUnhold) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = 3;
	}

	function onAfterBuild() {
		if (this.m.Loot.isEmpty()) {
			this.addLoot(::new("scripts/items/misc/" + ::MSU.Array.rand(["legend_rock_unhold_bones_item", "legend_rock_unhold_hide_item"])));
		}
	}
});
