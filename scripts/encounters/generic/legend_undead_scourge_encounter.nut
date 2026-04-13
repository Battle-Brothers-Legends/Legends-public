this.legend_undead_scourge_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {},
    function create() {
	    this.encounter.create();
        this.m.Type = "encounter.legend_undead_scourge_encounter";
        this.m.Name = ::Const.Strings.randomCityEncounterName();
	    this.m.Cooldown = 30 * ::World.getTime().SecondsPerDay;
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Strolling around the city...",
            Text = "[img]gfx/ui/events/event_77.png[/img]{While on the prowl for contracts, you hear a local priest- or perhaps resident hysterical old man, who\'s to say- shouting about how the end times have come,%SPEECH_ON%The old gods have forsaken us, have allowed the long dead to slip back into our realm. The high houses have failed you, so now you turn to the gods - and yet you do not plead!? The dead are the whip of the gods, chastisement for our sins!%SPEECH_OFF% You see several in the crowd nodding along to his statements %SPEECH_ON%It\'s true! Please, deliver us from this hell!%SPEECH_OFF% wails one woman. She, almost desperately, flings her purse at the man\'s feet. Others quickly pile offerings at his feet. You even see someone place their child at his boots. All the while you see a satisfied glint in the man\'s eyes.}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "Nigh is the time of madness and disdain. ",
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

        if (!this.World.FactionManager.isUndeadScourge())
            return false;

        if (this.World.Contracts.getActiveContract() == null)
            return false;

        return !this.isOnCooldown();
    }
})


