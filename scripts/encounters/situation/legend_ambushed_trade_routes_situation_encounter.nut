this.legend_ambushed_trade_routes_situation_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {},
    function create() {
        this.createScreens();
        this.m.Type = "legend_ambushed_trade_routes_situation_encounter";
        this.m.Name = "Empty Markets in Town";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Walking through the market...",
            Text = "[img]gfx/ui/events/event_92.png[/img]{As you walk through %settlement%\'s market square, you can\'t help but notice how empty it is. Several spaces reserved for traveling caravans lie empty, and stalls for locals to peddle their wares are uninhabited. You approach a particularly fat looking merchant who gives you a sleazy smile %SPEECH_ON%Ah, come to do some trading mercenary? I have the best stock, by no small part due to the oh-so-terrible woes of %settlement%.%SPEECH_OFF% You frown, and ask the man to elaborate. %SPEECH_ON%Well the writing\'s on the wall isn\'t it? For a few days now, few caravans have been able to make it here unplundered. Why, I lost my brother on one of those caravans. Great for business, wouldn\'t you agree? Why are you looking at me like that? Oh, right, my brother. Well you see, sellsword, it\'s elementary economics. Less merchants in one town means we can charge more, isn\'t it splendid?%SPEECH_OFF%}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "And they say mercenaries are cutthroat.",
                    function getResult(_event) {
                        return 0;
                    }
                }
            ],
            function start(_event) {}
        }]);
    }

    function isValid(_settlement) {
        if (!_settlement.hasSituation("situation.ambushed_trade_routes"))
            return false;
        return !isOnCooldown();
    }
})
