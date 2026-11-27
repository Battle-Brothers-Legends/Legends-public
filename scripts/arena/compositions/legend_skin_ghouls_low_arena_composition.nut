this.legend_skin_ghouls_low_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_skin_ghouls_low";
		this.m.DisplayName = "Skin Ghouls";
		this.m.DisplayText = "\"You know the gnashslashers, the ghoulish things that eat the dead? Half of these are just that. The other half, the alchemists say, went hungry for so long that it changed them. Paler. Meaner. And they do not wait for you to be dead first. They all grow as they feed, so I would advise you to keep all of your men in one piece.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendSkinGhoulLow,
			::BDP.Arena.EntityTypes.NachzehrerLow
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.LegendSkinGhoulLow,
			::BDP.Arena.EntityTypes.NachzehrerLow
		];
		this.m.Pay = 250;
		this.m.AllowedEntrants = 3;
		this.m.BaseStrength = 60;
		this.m.MinDay = 10;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Nachzehrers;
		titles.extend(::BDP.Arena.CompositionTitles.Plain);
		titles.extend(::BDP.Arena.CompositionTitles.Hill);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.SkinGhouls) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.min(_difficulty, 2);
	}

	function onAfterBuild() {
		if (this.m.Loot.isEmpty()) {
			this.addLoot(::new("scripts/items/misc/legend_skin_ghoul_skin_item"));
		}
	}
});
