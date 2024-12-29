this.test_situation_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.test_situation_encounter";
        this.m.Name = "Situation related encounter";
//        this.m.Icon = "ui/encounters/encounter.png"
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Idk what to put here",
            Text = "[img]gfx/ui/events/event_77.png[/img]{Greenskins marauding, people complaining, flavor kind of event.}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "Damn",
                    function getResult(_event) {
                        return 0;
                    }
                }
            ],
            function start() {}
        }]);
    }

    function isValid(_settlement) {
        if (!_settlement.hasSituation("situation.greenskins"))
            return false;
        return !isOnCooldown();
    }
})
