this.legend_camp_unlock_crafting_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_crafting";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_crafting.png[/img]While you explore %settlement%, talk turns to the taxidermist. A mercenary murmurs %SPEECH_ON%Taxidermists are strange ones, talking to them puts me on edge. Do we have to go there?%SPEECH_OFF%The others point out the goods provided make the transactions worthwhile, but the mercenary continues %SPEECH_ON%It\'s just stitching dead things, right? I bet I could do that, my mother showed me how to darn my socks, and stuffing dead things ain\'t so different. %SPEECH_OFF%\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "This will come handy",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Crafting unlocked in camp"
				});
				::World.Flags.set("HasLegendCampCrafting", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampCrafting"))
			return false;

		if (!(_settlement.hasBuilding("building.taxidermist") || _settlement.hasBuilding("building.taxidermist_oriental")))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Crafting).getDescription()
		]);
	}

});

