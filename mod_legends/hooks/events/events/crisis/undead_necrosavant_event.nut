::mods_hookExactClass("events/events/crisis/undead_necrosavant_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_76.png[/img]Suddenly, a crossbow aims over your shoulder and fires so closely you can feel the air rushing past the twang of its rope. The bolt pierces the old man\'s skull and he tips forward, head to the mud, arse in the air, hands still beside himself in dispirited supination.\n\nYou turn to see %witchhunter% the witch hunter standing behind you. %They_witchhunter% lowers the crossbow and walks over to the corpse, grabbing it by the nape of the neck and putting a stake through its back. The body wretches with a shriek and the clothing bloats as the body implodes, a swirling dust hurriedly exiting out the cloak as though it had been caught impersonating a man.\n\n The witch hunter turns to you.%SPEECH_ON%Necrosavant. Rare. Extremely dangerous.%SPEECH_OFF%";
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (::World.Assets.getOrigin().getID() != "scenario.legend_risen_legion") {
			return;
		}
		onUpdateScore();
	}
})
