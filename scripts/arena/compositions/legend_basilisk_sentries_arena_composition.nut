this.legend_basilisk_sentries_arena_composition <- this.inherit("scripts/arena/compositions/legend_basilisks_arena_composition", {
	m = {},

	function create() {
		this.legend_basilisks_arena_composition.create();
		this.m.Type = "arena_composition.legend_basilisk_sentries";
		this.m.DisplayName = "Basilisks";
		this.m.DisplayText = "\"More of the great birds, but these are the ones that watch over the nests. The handlers tell me not to look them in the eye. I asked what happens if I do, but the only handler who could have told me no longer works here. So. Do not look them in the eye.\"";
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.LegendBasiliskSentry
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.LegendBasiliskSentry,
			::BDP.Arena.EntityTypes.LegendBasiliskSentry,
			::BDP.Arena.EntityTypes.LegendBasiliskDroneLow
		];
		this.m.Pay = 325;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 40;
		this.m.MinDay = 20;
	}
});
