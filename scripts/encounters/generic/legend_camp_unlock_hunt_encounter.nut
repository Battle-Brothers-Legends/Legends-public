this.legend_camp_unlock_hunt_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_hunt";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]Passing by local hunter's huts, you suddenly remember that the food stocks are running low, perhaps it is time to camp and go hunting?\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "This is the way",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Hunting unlocked in camp"
				});
				::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Hunter], true);
			}
		});
	}

	function isValid(_settlement) {
		/*if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Hunter]))
			return false;

		if (!(_settlement.hasAttachedLocation("attached_location.trapper") || _settlement.hasAttachedLocation("attached_location.hunters_cabin")))
			return false;

		return !this.isOnCooldown();*/
		return false;
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Hunter).getDescription()
		]);
	}
});

