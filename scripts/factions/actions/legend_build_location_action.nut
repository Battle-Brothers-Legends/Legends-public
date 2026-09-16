this.legend_build_location_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlement = null
	},

	function create() {
		this.m.ID = "legend_build_location_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate(_faction) {
		this.m.Settlement = _faction.getSettlements()[::Math.rand(0, _faction.getSettlements().len() - 1)];

		if (this.m.Settlement.getTile().getDistanceTo(::World.State.getPlayer().getTile()) <= 15) { //should use ::Math.max(15, ::Math.ceil(::World.State.getPlayer().getVisionRadius() * DistanceToTilesFactor)) + ~3 tiles to cover the location spawning range from settlement instead of plain 15 to cover edge cases with scouting tent
			return;
		}

		if (!this.m.Settlement.canBuildLocation()) {
			return;
		}

		this.m.Score = 1;
	}

	function onClear() {
		this.m.Settlement = null;
	}

	function onExecute(_faction) {
		this.m.Settlement.addSituation(this.new("scripts/entity/world/settlements/situations/legend_building_effort_situation"));
	}
});
