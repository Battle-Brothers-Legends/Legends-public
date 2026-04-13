this.legend_greenskins_situation_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
        this.encounter.create();
        this.m.Type = "encounter.legend_greenskins_situation";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Strolling around the city...",
			Text = "[img]gfx/ui/events/event_77.png[/img]{The market buzzes around you, when a woman\'s voice breaks through the noise. You overhear her speaking to a vendor, her words heavy with grief.%SPEECH_ON%My husband was a guard at the north gate%SPEECH_OFF%she says, her voice trembling.%SPEECH_ON%Orcs ambushed him at dawn. They... they took him down before he could even fight back. He never stood a chance%SPEECH_OFF% she adds quietly, wiping away a tear. You move on, the weight of her sorrow lingering in the air, a grim reminder of how quickly fate can strike.}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "Damn.",
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

        if (!_settlement.hasSituation("situation.greenskins"))
            return false;

        return !this.isOnCooldown();
    }
})
