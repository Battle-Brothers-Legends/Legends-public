this.legend_white_direwolf_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_white_direwolf";
		this.m.DisplayName = "White Direwolves";
		this.m.DisplayText = "\"The hounds of the north have kings, did you know? White as bone and near as big as a pony. It cost the Vizier a fortune and two dozen hunters to bring a pair of them here, and they have not eaten since they arrived, though not for lack of offering. Their pack came with them. I think they have been saving their appetite for you.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendWhiteDirewolf,
			::BDP.Arena.EntityTypes.LegendWhiteDirewolf
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.FrenziedDirewolf
		];
		this.m.Pay = 600;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 200;
		this.m.MinDay = 40;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Forest;
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.WhiteDirewolf) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = 3;
	}

	function onAfterBuild() {
		if (this.m.Loot.isEmpty()) {
			this.addLoot(::new("scripts/items/misc/legend_white_wolf_pelt_item"));
		}
	}
});
