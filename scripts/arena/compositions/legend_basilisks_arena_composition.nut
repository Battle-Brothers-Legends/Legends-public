this.legend_basilisks_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},

	function create() {
		this.arena_composition.create();
		this.m.Type = "arena_composition.legend_basilisks";
		this.m.DisplayName = "Basilisks";
		this.m.DisplayText = "\"It is a chicken. No, do not laugh. I laughed, and then I watched it take a man\'s arm off at the shoulder. A chicken the size of a horse with the temper of a tax collector! The northerners call it a \'basilisk\', and they come in flocks, so there is more than one. May the Gilder guide your blade and keep your eyes.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendBasiliskDrone
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.LegendBasiliskDrone,
			::BDP.Arena.EntityTypes.LegendBasiliskDroneLow,
			::BDP.Arena.EntityTypes.LegendBasiliskDroneLow
		];
		this.m.Pay = 300;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 45;
		this.m.MinDay = 15;
	}

	function generateDisplayName() {
		local titles = clone ::BDP.Arena.CompositionTitles.Basilisks;
		titles.extend(::BDP.Arena.CompositionTitles.Steppe);
		titles.extend(::BDP.Arena.CompositionTitles.Hill);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.Basilisks) + " of " + ::MSU.Array.rand(titles);
	}
});
