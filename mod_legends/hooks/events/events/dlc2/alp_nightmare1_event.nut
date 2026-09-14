::mods_hookExactClass("events/events/dlc2/alp_nightmare1_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_26.png[/img]{The men are talking around the campfire when %spiderbro% suddenly jumps to %their_victim% feet screaming. %They_victim% bounds backward, and lit by the flames you see a spider the size of a helmet glommed onto %their_victim% boot!}";
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_26.png[/img]{You draw your blade, but %otherbro% has already beaten you to the punch. %They_other% yells at %spiderbro% to stand still which %they_other% reluctantly does. But the armed sellsword swings %their_other% blade far too high and cuts straight through the %person_victim%\'s neck. The headless body buckles and the rest of the company screams in horror and rage.}";
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_39.png[/img]{You run toward %otherbro% looking to choke the very life out of %them_other%, only for your hands to sift through the flesh like fingers into fog and your momentum sails you into the ground.%SPEECH_ON%Uh, you alright captain?%SPEECH_OFF%Looking back, you see a perfectly healthy %spiderbro% sitting beside the fire. Far off in the distance, something pale and sleek steps back from a tree trunk. When you blink, it\'s gone. You tell the men to mind the perimeter and then return to your tent, shaking your head and pinching your eyes.}";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_26.png[/img]{%spiderbro% nods and stiffly walks toward the campfire with the spiderling looking up at %them_victim% with oddly trusting eyes. %They_victim% puts the critter to the pit and it is immediately set ablaze. At first, you think %they're_victim% done it, %they're_victim% in the clear, but the fiery spiderling sprints up the %person_victim%\'s pantleg, setting %their_victim% attire alight, and gloms onto %their_victim% head. Set afire, the %person_victim% throws %their_victim% hands out and begins to run around for help. The beast burrows its fangs into %their_victim% skull and the screaming ceases in sudden paralysis and the sellsword falls into the campfire like a board of wood.}";
		});
		::Legends.Screens.hook(this, "E", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_39.png[/img]{You scream at the mercenaries to do their part, but when you jump toward the campfire and %spiderbro% there\'s a wash of embers and sparks and when they fade you find the sellsword calmly sitting beside the flames.%SPEECH_ON%Ah, captain, did you say something?%SPEECH_OFF%Looking around, you find the rest of the company engaged in idle chat. When you look back at %spiderbro% you thought you saw a white shadow passing behind %them_victim%, but upon second glance it is gone. You tell the men to keep a vigilant eye for intruders and then return to your tent.}";
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf") {
			return;
		}
		onUpdateScore();
	}
})
