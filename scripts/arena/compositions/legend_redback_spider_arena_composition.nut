this.legend_redback_spider_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_redback_spider";
		this.m.DisplayName = "Redback Spider";
		this.m.DisplayText = "\"That is not a fig tree, and it is no ordinary spider either. See the red on its back? The alchemists say that is how you tell the mother of a brood from her children, and that her venom drops an ox before it has finished falling. Her children are in there with her. Bring a big boot.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendRedbackSpider
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.Webknecht
		];
		this.m.Pay = 450;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 70;
		this.m.MinDay = 30;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Webknechts;
		titles.extend(::BDP.Arena.CompositionTitles.Forest);
		titles.extend(::BDP.Arena.CompositionTitles.Swamp);
		this.m.DisplayName = "The " + ::MSU.Array.rand(::BDP.Arena.CompositionNames.RedbackSpider) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = ::Math.max(_difficulty, 2);
	}

	function onAfterBuild() {
		if (this.m.Loot.isEmpty()) {
			this.addLoot(::new("scripts/items/misc/legend_redback_poison_gland_item"));
		}
	}
});
