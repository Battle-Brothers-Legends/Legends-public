::mods_hookExactClass("events/events/dlc4/lone_wolf_origin_squire_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();

		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]The pub is full of drunk denizens sloshing about, cheering, singing, carousing with the womenfolk of either wench or wife or whore. A man with a lute dances and plays and another with metal cymbals crashes overhead while a fat man booms with songs of battles or love, and whether a tale of victory or defeat they provoke rounds of ale and more merriment all the same.\n\n You leave the pub and enter the next building over. The wind whistles down a pew filled nave as you stand at the door. A man sweeping the stone floor looks up for a time then continues with his work. Another man cheerfully crosses the room and asks if you\'d like to pray. You decline and he purses his lips and crosses his arms. The crowd next door roars with drunken delight as though to make a mockery of you both and then he moves on. You stay for a moment longer and then leave and go back out to the town center and squat on a series of steps. It seems there used to be a statue at the top of those steps, but vandals and raiders alike have made short work of another\'s artisanry. You fall asleep there at the foot of impermanence. \n\n Waking from a nap, you find a young %person_dude% at the bottom of the steps. %They_dude% says %they_dude% knows you\'re a knight and %they're_dude% come to offer %their_dude% services as a squire.";
			_screen.start <- function (_event) {
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"squire_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "You met %name% in " + _event.m.Town.getName() + " where %they% volunteered to be your squire. %They% probably had no idea what %they% was getting into back then.";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body));

				_event.m.Dude.getItems().equip(this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.linen_tunic],
				]));

				_event.m.Dude.setTitle("the Squire");
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{The %person_dude% shakes %their_dude% head no.%SPEECH_ON%Ain\'t never killed no one, sir.%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{The %person_dude% stands up straight.%SPEECH_ON%I know how to sharpen steel and mend leather. I can disassemble and reassemble heavy and light armors both, no matter how complex or simple, and I can do it fast. If we have a horse.%SPEECH_OFF%You interrupt.%SPEECH_ON%I walk.%SPEECH_OFF%Shifting uneasily on %their_dude% feet, the %person_dude% continues.%SPEECH_ON%Alright. Well I can cook. I can cook a fine meal whether I got the ingredients or not. I make do. And. And. That\'s. That\'s about it. But I\'m willing to learn!%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{You ask the %person_dude% %their_dude% name. %They_dude% swallows nervously.%SPEECH_ON%%squire%, sir.%SPEECH_OFF%You nod.%SPEECH_ON%Well alright then. I\'ll take ya with me.%SPEECH_OFF%%They_dude% smiles.%SPEECH_ON%That\'s. That\'s it?%SPEECH_OFF%You nod.%SPEECH_ON%Yeah. That\'s it.%SPEECH_OFF%%squire% looks around.%SPEECH_ON%Well. Alright. What now?%SPEECH_OFF%You lean back against the stone steps.%SPEECH_ON%You follow me. Right now I\'m gonna take another nap. If yer still around when I wake, well, then you\'ve passed your first test. Defeating boredom.%SPEECH_OFF%The squire is grinning ear to ear. %They're_dude% still there when you wake.}";
		});
		::Legends.Screens.hook(this, "E", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_20.png[/img]{You look at the would-be squire long and hard and then tell %them_dude% no. %They_dude% shrugs.%SPEECH_ON%Just so you know, you ain\'t gotta be alone in this world. Loneliness has no presence. It is not a place. It is not a being. It is action!%SPEECH_OFF%Spitting, you wipe your face and laugh.%SPEECH_ON%Is that what you tell yourself every morning? Get out of here.%SPEECH_OFF%}";
		});
	}
});
