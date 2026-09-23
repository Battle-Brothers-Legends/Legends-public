::mods_hookExactClass("scenarios/scenario_manager", function (o) {
	o.getScenariosForUI <- function () {
		local ret = [];

		foreach (s in this.m.Scenarios) {
			if (s.isValid()) {
				local scenario = {
					ID = s.getID(),
					Name = s.getName(),
					Description = s.getDescription(),
					Difficulty = s.getDifficultyForUI(),
					Order = s.getOrder(),
					LegendsScenarioOrder = ::Legends.Scenarios.Order
				};
				ret.push(scenario);
			}
		}

		return ret;
	}
});
