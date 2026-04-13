this.legend_camp_unlock_gather_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_gather";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_gather.png[/img]On your way around the town premises, you pass by the herbalist\'s grove. An impressive expanse of colorful flowers and herbs lay before you, the surrounding air made almost oppresively antiseptic. You recognize some of the plants, a few of them grow wild on the countryside. You pause to make firm mental notes of the various herbs; the smells, the colors, the sheen of the leaves in the sunlight. Even if you remember a select few, it would be enough to concoct a couple amateur curatives.\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "This might help us in the wild",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Gathering unlocked in camp"
				});
				::World.Flags.set("HasLegendCampGathering", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampGathering"))
			return false;

		if (!(_settlement.hasAttachedLocation("attached_location.gatherers_hut") || _settlement.hasAttachedLocation("attached_location.herbalists_grove") || _settlement.hasAttachedLocation("attached_location.plantation")))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Gatherer).getDescription()
		]);
	}
});

