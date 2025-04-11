this.legend_collectors_situation_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {},
    function create() {
        this.createScreens();
        this.m.Type = "legend_collectors_situation_encounter";
        this.m.Name = "Collectors in Town";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Strolling around the city...",//might make a roll with a small chance to recruit this guy later
            Text = "[img]gfx/ui/events/event_17.png[/img]{Near the gates of %settlement%, you see a grizzled old soldier dressed in rags sitting on the stoop of a dilapidated house, head in his hands and weeping quite openly. %SPEECH_ON%He took them! The ungrateful bastard took every last one!%SPEECH_OFF% You would normally be content to walk on past him but the man, with swiftness belying his age, quickly grabs your hands %SPEECH_ON% Sellsword! I know one when I see one, please, help me!%SPEECH_OFF% After a brief moment, you shrug, and motion for the man to speak. The oldtimers have the most fantastical tales. %SPEECH_ON%My grandson, a pox on him, has stolen all my possessions, he- he intends to sell it all because of some damned collectors in town! He thinks he\'ll make a fortune bartering my history, my life, away! %SPEECH_OFF%You ask the man what his possessions are and why would any collectors want it. Despite his age, the man seems to straighten and a hint of pride gleams in his eye. %SPEECH_ON% Monster parts, that\'s my possessions! I had an entire Unhold skull, among various other trinkets! I lost my brother and many brothers in arms acquiring those, and I\'ll be damned if I\'m going to lose them all because my good-for-nothing grandson can\'t keep a roof over our heads. I\'ll pay you if you can get them back for me, please!%SPEECH_OFF%You shake your head and back away from the man. Even if he could muster the coin for your services, judging by the house, perhaps the grandson was right. You leave the man, who emits a keening wail and sinks down to the dirt once more.}",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "Perhaps these collectors of his will also buy our own trophies at a premium.",
                    function getResult(_event) {
                        return 0;
                    }
                }
            ],
            function start(_event) {}
        }]);
    }

    function isValid(_settlement) {
        if (!_settlement.hasSituation("situation.collectors"))
            return false;
        return !isOnCooldown();
    }
})
