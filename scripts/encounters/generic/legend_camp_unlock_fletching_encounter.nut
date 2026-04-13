this.legend_camp_unlock_fletching_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_fletching";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_fletcher.png[/img]Lolling around %settlement% in a bored stupor, you find yourself at the fletcher\'s shack. A few of the fletchers are toiling away at some dozen arrows and bolts, their movements almost hypnotic. One of them notices your staring and takes an opportunity to begin a conversation. You nod your head like a trained animal as he prattles on and on, your focus soley on his work. This too, he notices, and the droll chat turns to an impromptu lesson. Before you know it, he\'s finished his work and your head is full to bursting with facts about feathers and shafts.\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Seems easy enough",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Fletching unlocked in camp"
				});
				::World.Flags.set("HasLegendCampFletching", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampFletching"))
			return false;

		if (!(_settlement.hasAttachedLocation("attached_location.fletchers_hut") || _settlement.hasBuilding("building.weaponsmith") || _settlement.hasBuilding("building.weaponsmith_oriental")))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Fletcher).getDescription()
		]);
	}
});

