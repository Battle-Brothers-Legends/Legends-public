this.legend_lindwurm_slayer_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.legend_lindwurm_slayer_encounter";
        this.m.Name = "lindwurm_slayer_encounter";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Start",
            Title = "Title",
            Text = "[img]gfx/ui/events/event_35.png[/img]{" + ::Legends.Encounters.getTownIntroduction() + "}",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Check it out",
                function getResult(_event) {
                    this.World.State.getMenuStack().popAll(true);
                    this.Time.scheduleEvent(this.TimeUnit.Virtual, 1, function ( _tag ) {
                        this.World.Events.fire("event.crisis.lindwurm_slayer");
                    }, null);
                    this.Time.scheduleEvent(this.TimeUnit.Real, 500, function ( _tag ) {
                        this.World.State.setPause(false);
                    }, null);
                    return 0;
                }
            }
            ],
            function start(_event) {

            }
        }]);
    }

    function isValid(_settlement) {
        local event = this.World.Events.getEvent("event.crisis.lindwurm_slayer");
        if (event == null) {
            return false;
        }
        event.onUpdateScore();
        return event.m.isValidForEncounter;
    }
})
