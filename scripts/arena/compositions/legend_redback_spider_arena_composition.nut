this.legend_redback_spider_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_redback_spider";
		this.m.DisplayName = "Redback Spiders";
		this.m.DisplayText = "\"Those are not fig trees, and they are no ordinary spiders either. See the red on their backs? The alchemists say that is how you tell the mothers of a brood from their children, and that their venom drops an ox before it has finished falling. A few of the children are in there with them. Bring a big boot.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendRedbackSpider,
			::BDP.Arena.EntityTypes.LegendRedbackSpider,
			::BDP.Arena.EntityTypes.LegendRedbackSpider
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.LegendRedbackBrood
		];
		this.m.Pay = 450;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 100;
		this.m.MinDay = 30;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Webknechts;
		titles.extend(::BDP.Arena.CompositionTitles.Forest);
		titles.extend(::BDP.Arena.CompositionTitles.Swamp);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.RedbackSpider) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty(_difficulty) {
		this.m.Difficulty = 3;
	}

	function onAfterBuild() {
		if (this.m.Loot.isEmpty()) {
			this.addLoot(::new("scripts/items/misc/legend_redback_poison_gland_item"));
		}
	}
});
