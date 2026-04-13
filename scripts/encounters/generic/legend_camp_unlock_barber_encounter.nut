this.legend_camp_unlock_barber_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_barber";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_barber.png[/img]As you stroll around %settlement%, all thoughts turn to the barber. Life on the road makes it hard to keep beard and hair in check and everyone is looking forward to a trim. As you walk by %randombrother% says,%SPEECH_ON%Barbering ain\'t so hard, we chop up more difficult things every day. I was asking the barber about it last time and he showed me some tricks. I bet with a chair and some scissors I could at least keep the hair from matting together.%SPEECH_OFF%\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Sure thing",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Barbering unlocked in camp"
				});
				::World.Flags.set("HasLegendCampBarber", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampBarber"))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Barber).getDescription()
		]);
	}
});

