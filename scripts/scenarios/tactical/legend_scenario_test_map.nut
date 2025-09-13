this.legend_scenario_test_map <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioTestMap::generate()");
		this.createStash();
		this.initMap();
		this.initEntities();
		this.initStash();
		this.Tactical.Entities.makeEnemiesKnownToAI();
		this.Tactical.CameraDirector.moveToTile(this.Tactical.getTileSquare(5, 5));
	}

	function initMap()
	{
		this.MapGen.get("tactical.test_map").fill({
			X = 0,
			Y = 0,
			W = 30,
			H = 20,
			IsEmpty = false
		}, null);
	}

	function initEntities()
	{
		// Will be implemented by the hook
	}
});
