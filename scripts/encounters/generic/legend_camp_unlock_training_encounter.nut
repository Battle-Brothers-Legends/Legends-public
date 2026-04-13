this.legend_camp_unlock_training_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_training";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_train.png[/img]As you leave %settlement% the talk is of the training hall. Each mercenary claims they are more skilled than the next, and will prove it in the training hall. Some claim they are more skilled than the trainer himself. As you walk %randombrother% says %SPEECH_ON%Each time we come here I talk to the trainer. It don\'t take much to train, the weight of your body and some sticks is enough. I bet we could train ourselves and save some coin.%SPEECH_OFF%\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "This will help in the long run",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Training unlocked in camp"
				});
				::World.Flags.set("HasLegendCampTraining", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampTraining"))
			return false;

		if (!_settlement.hasBuilding("building.training_hall"))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Training).getDescription()
		]);
	}
});

