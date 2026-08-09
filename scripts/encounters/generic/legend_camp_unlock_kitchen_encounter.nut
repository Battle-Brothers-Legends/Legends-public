this.legend_camp_unlock_kitchen_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},

	function create() {
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_kitchen";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]Passing by the local kitchen, you suddenly remember that the alcohol stocks are running low, perhaps it is time to get some ingredients for the camp's kitchen?\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "This is the way",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Cooking unlocked in camp"
				});
				::World.Flags.set(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Kitchen], true);
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp() || ::World.Flags.get(::Legends.Camp.Flag[::Legends.Camp.CampBuildings.Kitchen])) {
			return false;
		}

		if (!(_settlement.hasAttachedLocation("attached_location.brewery") || _settlement.hasAttachedLocation("attached_location.winery"))) {
			return false;
		}

		return !this.isOnCooldown();
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Kitchen).getDescription()
		]);
	}
});
