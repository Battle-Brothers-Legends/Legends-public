this.legend_camp_unlock_painter_encounter <- this.inherit("scripts/encounters/encounter", {
	m = {},
	function create()
	{
		this.encounter.create();
		this.m.Type = "encounter.legend_camp_unlock_painter";
		this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Icon = "ui/encounters/encounter_03.png";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Task",
			Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/legend_camp_barber.png[/img]You\'re conversing with %randombrother% about some logistics when you see a small gaggle of young women pretending not to be looking at you and giggling. %randombrother% — in perhaps the least sexy looking manner you\'ve ever seen — starts to stride over when %they_randombrother% get in ear shot. %SPEECH_ON%Have you seen what they\'re wearing!? Looks like my granny rolled out of bed and grabbed a sword! %SPEECH_OFF%As a miserable looking %randombrother% trudges back to you, you contemplate the local workshop. Maybe it's time to get the %companyname% a makeover?\n\n%description%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "We will roll in style!",
				getResult = @(_event) 0
			}],
			function start (_event) {
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "Armor painting unlocked in camp"
				});
				::World.Flags.set("HasLegendCampPainter", true)
			}
		});
	}

	function isValid(_settlement) {
		if (::Legends.Settings.skipCamp())
			return false;

		if (::World.Flags.get("HasLegendCampPainter"))
			return false;

		if (!(_settlement.hasAttachedLocation("attached_location.workshop") || _settlement.hasBuilding("building.armorsmith") || _settlement.hasBuilding("building.armorsmith_oriental")))
			return false;

		return !this.isOnCooldown();
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"description",
			::World.Camp.getBuildingByID(::Const.World.CampBuildings.Painter).getDescription()
		]);
	}
});

