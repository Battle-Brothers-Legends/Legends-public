this.legend_camp_unlock_scouting_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_scouting";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_scout.png[/img]On the outskirts of %settlement%, you pass a local guard force on patrol. You over hear them talking about a camp they came upon where they found everyone slaughtered... Something about how they were all caught unaware because they had no one on patrol.\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Good to know what\'s going on around",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Patrol unlocked in camp"
				});
				::World.Flags.set("HasLegendCampScouting", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampScouting"))
			return false;

		if (!(_settlement.hasAttachedLocation("attached_location.wooden_watchtower") || _settlement.hasAttachedLocation("attached_location.stone_watchtower") || _settlement.hasAttachedLocation("attached_location.fortified_outpost")))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Scout).getDescription()
		]);
	}
});

