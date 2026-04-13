this.legend_camp_unlock_heal_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_heal";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_heal.png[/img]There you were, minding your own business in the marketplace, shopping for supplies when two shop patrons started throwing fists over the last melon. One of the local monks was in the shop as well and took an unlucky elbow to the face. You picked up the monk and carried him to the local temple. In gratitude for your help, the monks showed you some basic skills for treating wounds that could come in handy!\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Essential survival skill for sure",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Healing unlocked in camp"
				});
				::World.Flags.set("HasLegendCampHealing", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampHealing"))
			return false;

		if (!_settlement.hasBuilding("building.temple"))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Healer).getDescription()
		]);
	}
});

