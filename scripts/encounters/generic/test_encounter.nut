this.test_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.test_encounter";
        this.m.Name = "Scout report";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Aye, here we go",
            Text = "Put some jokes here or something, idk.",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Click me for free puppies!",
                function getResult(_event) {
                    return "screen2";
                }
            },
            {
                Text = "Not now",
                function getResult() {
                    return 0;
                }
            }
            ],
            function start() {
                this.List.push({
                    id = 1,
                    icon = "ui/icons/fatigue.png",
                    text = "I'm tired, man..."
                });
            }
        }, {
            ID = "screen2",
            Title = "Aye mate, that's 2nd screen!",
            Text = "No puppies, but 2nd screen! Woohoo, now push that button",
            Image = "",
            List = [{
                id = 1,
                icon = "ui/icons/fatigue.png",
                text = "Max Fatigue"
            }],
            Options = [
            {
                Text = "Bummer, let's go!",
                function getResult(_event) {
                    return 0;
                }
            }
            ],
            function start() {}
        }]);
    }

    function isValid(_settlement) {
        return !isOnCooldown();
    }
})
