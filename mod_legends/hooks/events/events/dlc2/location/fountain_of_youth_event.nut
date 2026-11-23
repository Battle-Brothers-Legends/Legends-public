::mods_hookExactClass("events/events/dlc2/location/fountain_of_youth_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_114.png[/img]{You throw the waterskin aside and put your mouth into the puddle and drink. The world beneath the puddle\'s surface is empty and silent. Your lips move, your throat gulps, but there is nothing to drink here. You scream. There is nothing. Not even a feeling. Just the notion of fear, a tickle with no means to scratch it. When you put your hands to the earth to try and remove yourself, you find that you cannot leave the puddle.\n\n Faint faces wink in and out of the void. They are like the tree\'s, dramatically inanimate, painfully issued from past to present to future, and here they approach, gathering in number, bubbling and jostling forward, turning this black hell into a frothy white. As they near, you realize you\'ve been not looking right. Individually, they are but faces without presence. Taken as a whole, as the great white sheet on the approach, you realize that they make up one large face: yours. And it is laughing.\n\n Screaming, you finally fall back out of the puddle. %randombrother% has you under %their_randombrother% arm and %they're_randombrother% looking at you with concern.%SPEECH_ON%Sir, are you alright? You was napping then your head slid into the water there.%SPEECH_OFF%You look up, thinking to see the grotesque tree and its awful faces. It is not there and no matter how many times you look or in how many places, it is never there again.}";
		});
	}
});
