this.legend_stollwurm_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_stollwurm";
		this.m.DisplayName = "Stollwurm";
		this.m.DisplayText = "\"I have run these pits for thirty years and I never had to widen the gate before. They dug this thing out of a mountain. It is like the green wurms the northerners fear, only older, and larger, and far angrier about being here. The masons want it dead before it brings the stands down, so the purse is generous. May the Gilder watch over you, for I will be watching from much further away.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendStollwurm
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.Lindwurm
		];
		this.m.Pay = 700;
		this.m.AllowedEntrants = 5;
		this.m.BaseStrength = 105;
		this.m.MinDay = 50;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Mountain;
		titles.extend(::BDP.Arena.CompositionTitles.Hill);
		this.m.DisplayName = "The " + ::MSU.Array.rand(::BDP.Arena.CompositionNames.Stollwurm) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.max(_difficulty, 2);
	}

	function onAfterBuild() {
		if (this.m.Loot.isEmpty()) {
			this.addLoot(::new("scripts/items/misc/" + ::MSU.Array.rand(["legend_stollwurm_scales_item", "legend_stollwurm_blood_item"])));
		}
	}
});
