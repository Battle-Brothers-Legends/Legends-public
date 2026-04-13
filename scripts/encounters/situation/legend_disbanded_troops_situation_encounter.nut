this.legend_disbanded_troops_situation_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
	    this.encounter.create();
        this.m.Type = "encounter.legend_disbanded_troops_situation";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Strolling around the city...",
            Text = "[img]gfx/ui/events/event_80.png[/img]{Walking through %settlement% you see a herald dressed in house colours standing on a crate shouting over a throng of disgruntled soldiers. %SPEECH_ON%By ducal decree, all mustered soldiers are to be disbanded and to return to their respective settlements at once.%SPEECH_OFF% Some of the former soldiers within earshot grumble to themselves, %SPEECH_ON%Take us from our families midway through the harvest season, gives a paltry sum, then return to starve with loved ones. Lovely.%SPEECH_OFF% All you hear however, is that a host of trained murderers are now looking for employment- with a hint of desperation, no less! Lesser minds than yours have recognized the opportunity here.}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "One man\'s refuse is another\'s treasure.",
                    function getResult(_event) {
                        return 0;
                    }
                }
            ],
            function start(_event) {}
        }]);
    }

    function isValid(_settlement) {
	    if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		    return false;

        if (!_settlement.hasSituation("situation.disbanded_troops"))
            return false;

        return !this.isOnCooldown();
    }
})
