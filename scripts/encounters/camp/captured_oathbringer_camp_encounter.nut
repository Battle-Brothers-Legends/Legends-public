this.captured_oathbringer_camp_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.captured_oathbringer_camp_encounter";
        this.m.Name = "captured_oathbringer_camp_encounter";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Start",
            Title = "Title",
            Text = "[img]gfx/ui/events/event_05.png[/img]{" + ::Legends.Encounters.getCampIntroduction() + "}",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Check it out",
                function getResult() {
                    this.World.State.getMenuStack().popAll(true);
                    this.Time.scheduleEvent(this.TimeUnit.Virtual, 1, function ( _tag ) {
                        this.World.Events.fire("event.captured_oathbringer");
                    }, null);
                    this.Time.scheduleEvent(this.TimeUnit.Real, 500, function ( _tag ) {
                        this.World.State.setPause(false);
                    }, null);
                    return 0;
                }
            }
            ],
            function start() {

            }
        }]);
    }

    function isValid(_camp) {
        local event = this.World.Events.getEvent("event.captured_oathbringer");
        if (event == null) {
            return false;
        }
        event.onUpdateScore();
        return event.m.isValidForEncounter;
    }
})
