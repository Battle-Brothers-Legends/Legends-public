this.legend_camp_unlock_scrap_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_scrap";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_scrap.png[/img]While perusing some equipment you could only hope to afford in your dreams, the smith enters the room carrying a large crate. He lugs it to the counter and drops it with a heavy wooden thud and a cacophony of metal clatters. You wonder aloud about what is inside and the smith, seemingly taken aback by your curiosity, explains that the market was trying to pass off a bunch of junk as weapons and armor. He goes on to say that he bought it with intent to salvage so he could use the scraps to repair some equipment brought in by another patron. With your curiosity sated, you leave with new ideas in your head.\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Terrific",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Scrapping unlocked in camp"
				});
				::World.Flags.set("HasLegendCampScraping", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampScraping"))
			return false;

		if (!(_settlement.hasAttachedLocation("attached_location.workshop") || _settlement.hasBuilding("building.armorsmith") || _settlement.hasBuilding("building.armorsmith_oriental")))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Workshop).getDescription()
		]);
	}
});

