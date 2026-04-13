this.legend_recruitment_vala_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
		Vala = null
    },
    function create() {
	    this.encounter.create();
        this.m.Type = "encounter.legend_recruitment_vala_encounter";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
		this.m.Cooldown = 60 * ::World.getTime().SecondsPerDay;
	}

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Start",
            Title = "On the outskirts...",
			Text = "[img]gfx/ui/events/legend_vala_recruitment.png[/img]The forests of the north are a primeval place, the span of a life is measured in months and the climate is a perpetual state of autumn or winter where the wildlife is as deadly as the weather. Leaving the town to walk through these forests is humbling — the trees here have outlived but the gods themselves, or so some would say.\nYour thoughts begin to wander further as the bridle path begins to feel endless and the trees curl inwards. The pressure builds in your head as you fall to the ground.\n The brush parts for a woman clad in furs holding a staff, focusing intently on you as you try to regain your balance. The noise stops and your mind clears. The woman speaks.%SPEECH_ON%Why are you here, outsider?%SPEECH_OFF%Her brow furrows and she hums, but her lips part again.%SPEECH_ON%I know what you are, and I know what you have done. Not just in this life — but the ones that have come before.%SPEECH_OFF%Her gaze lifts as she loses focus with you and looks down the path, deep in contemplation. The weight in your mind begins to lift as a tide ebbs before it comes crashing back. However, as she fixes her gaze with yours, the wave doesn\'t come crashing back. It is still there, at the back of your head — restrained like a warhound on a chain.%SPEECH_ON%Something is changing outsider — something is coming that we can\'t stand alone and face. I do not care for your work, your motivations or hardships. I care about stopping the cataclysm of what is to come.%SPEECH_OFF% She purses her lips %SPEECH_ON%Shall we begin?%SPEECH_OFF%The humming stops — the pain lifts as fast as it came. Despite what the people of the south say, the grip of the old gods remains firm here.",
            Image = "",
            List = [],
			Characters = [],
			Options = [
			{
				Text = "Welcome to the %companyname%.",
				function getResult(_event) {
					::World.getPlayerRoster().add(_event.m.Vala);
					::World.getTemporaryRoster().clear();
					_event.m.Vala.onHired();
					_event.m.Vala = null;
					return 0;
				}
			},
			{
				Text = "Keep your distance!",
				function getResult(_event) {
					::World.getTemporaryRoster().clear();
					_event.m.Vala = null;
					return 0;
				}
			}
			]
            function start(_event) {
				local roster = ::World.getTemporaryRoster();
				_event.m.Vala = roster.create("scripts/entity/tactical/player");
				_event.m.Vala.setStartValuesEx(["legend_vala_background"]);
				this.Characters.push(_event.m.Vala.getImagePath());
            }
        }]);
    }

    function isValid(_settlement) {
	    if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		    return false;

		if (_settlement.isIsolatedFromRoads())
			return false;

		if (::World.getPlayerRoster().getSize() >= ::World.Assets.getBrothersMax())
			return false;

		local playerTile = ::World.State.getPlayer().getTile();

		if (playerTile.SquareCoords.Y < ::World.getMapSize().Y * 0.7)
			return false;

		local totalbrothers = 0;
		local brotherlevels = 0;
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getBackground().getID() == "background.legend_vala")
				return false;
			totalbrothers += 1;
			brotherlevels += bro.getLevel();
		}

		if (totalbrothers < 1 || brotherlevels < 30)
			return false;

	    return !this.isOnCooldown();
    }

	function onClear() {
		this.m.Vala = null;
	}
})
