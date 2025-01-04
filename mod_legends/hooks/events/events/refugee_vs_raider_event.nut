::mods_hookExactClass("events/events/refugee_vs_raider_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_06.png[/img]%refugee%, a mercenary who once forced onto the roads as a refugee, stares blankly at %raider%. The raider, sensing being stared at, lowers their plate of food.%SPEECH_ON%Whatcha farkin\' looking at, huh?%SPEECH_OFF%The refugee points a dripping spoon.%SPEECH_ON%Yer a raider, right?%SPEECH_OFF%%raider% nods.%SPEECH_ON%Was. Might be again someday. What\'s it to you?%SPEECH_OFF%Standing up, %refugee% points.%SPEECH_ON%It were brutes like you who forced good people out of their homes. Good people to drag their whole lives onto the damned road.%SPEECH_OFF%Laughing, %raider% stands suddenly.%SPEECH_ON%Oh, is that right? And what made them so good? That they couldn\'t swing a sword or protect themselves? Do you believe for one moment that were the boot on the other foot they wouldn\'t do the same to me? Or to you, too? Folk are only as good as their options.%SPEECH_OFF%The spate\'s getting wild and some of the other mercenaries get to their feet. Nobody can stop the initial scuffle, the two sellswords exchanging blows and curses as good as any tavern brawl you\'ve seen. Thankfully, nothing too serious comes of the fight.";
			}
		}
	}
})
