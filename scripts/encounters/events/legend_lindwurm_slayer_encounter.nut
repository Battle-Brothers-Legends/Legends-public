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
            Text = "[img]gfx/ui/events/event_35.png[/img]{The market is alive with chatter as you wander through the stalls, the clatter of metal tools and the scent of fresh bread filling the air. As you pass a group of townsfolk gathered near a barrel of salted fish, you overhear snippets of their conversation. One woman, clutching a basket of bread, spoke in hushed tones.%SPEECH_ON%They say there\'s dragon slayer around, that killed a dragon—right up in the northern hills, with nothing but his sword.%SPEECH_OFF%Her voice was thick with awe. A man next to her, shaking his head, muttered.%SPEECH_ON%Aye, I heard the same. Said it took three days to bring the beast down.%SPEECH_OFF%Another man scoffed. %SPEECH_ON%A dragon? Ridiculous!%SPEECH_OFF%The words stirred something in you. Dragon slayers weren’t exactly common, and those who claimed such feats were often either liars or dead. You decide to find out for yourself, heading toward the tavern where they said the man was staying.}",
            Image = "",
            List = [],
            Options = [
            {
                Text = "Enjoy your drink",
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
