this.fav_enemy_swordmaster_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.fav_enemy_swordmaster_encounter";
        this.m.Name = "fav_enemy_swordmaster_encounter";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Start",
            Title = "Looking for a fight",
            Text = "[img]gfx/ui/events/event_134.png[/img]{You hear that there's some cocky bastard looking for a fight.}",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Check him out",
                function getResult(_event) {
                    this.World.State.getMenuStack().popAll(true);
                    this.Time.scheduleEvent(this.TimeUnit.Virtual, 1, function ( _tag ) {
                        this.World.Events.fire("event.legend_swordmaster_fav_enemy");
                    }, null);
                    this.Time.scheduleEvent(this.TimeUnit.Real, 500, function ( _tag ) {
                        this.World.State.setPause(false);
                    }, null);
                    return 0;
                }
            },
            {
                Text = "It's not worth it",
                function getResult(_event) {
                    return 0;
                }
            }
            ],
            function start(_event) {

            }
        }]);
    }

    function isValid(_settlement) {
        local event = this.World.Events.getEvent("event.legend_swordmaster_fav_enemy");
        if (event == null) {
            return false;
        }
        event.onUpdateScore();
        return event.m.isValidForEncounter;
    }
})
