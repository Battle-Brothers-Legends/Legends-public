::mods_hookExactClass("events/events/dlc2/addict_steals_potion_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{You go to check the inventory only to find %addict% splayed half-assed into a barrel, all four limbs hanging over the lip. There\'s a number of vials collected onto %their_addict% belly. %They_addict% stares at you with dim, reddened eyes, and the sockets holding them are purple as though all the blood had rushed there. You ask what the hell is going on and %addict% only smiles.%SPEECH_ON%Do, uh, do what you must. Er, captain. For I have already won.%SPEECH_OFF%}";
			_screen.Options = [
				{
					Text = "I just hope you\'ll heal in time. (Morals reputation increased)",function getResult(_event) {
						this.World.Assets.addMoralReputation(1);
						return 0;
					}
				},
				{
					Text = "This needs to stop now, %addict%.",function getResult(_event) {
						return this.Math.rand(1, 100) <= 33 ? "C" : "D";
					}
				},
				{
					Text = "Enough. I\'ll have this bloody demon whipped out of you! (Moral reputation decreased)",function getResult(_event) {
						this.World.Assets.addMoralReputation(-1);
						return "B";
					}
				}
			];
		});
		::Legends.Screens.hook(this, "B", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_38.png[/img]{You have %addict% taken to an ad-hoc whipping post. %They_addict% lays limply against the wood, %their_addict% fingers splayed out and pinching and clenching. %They_addict% looks like %they're_addict% chasing butterflies, and %they_addict% carries that absent look when %otherbrother% hides %them_addict% fierce with the whip.\n\n At first, the whipping does nothing, not even as it snaps across the %person_addict%\'s back, leaving crescents of crimson. But after a few strikes, %they_addict% wakes to reality and begins to scream. You come around to face %them_addict% and ask if %they_addict%\'ll swallow %their_addict% addiction. %They_addict% nods hurriedly. You let %them_addict% get whipped again, and ask again, and again %they_addict% nods. Another whipping, another question, another answer. So this goes, until %they_addict% is broken and whatever ailed %them_addict% is gone.}";
			_screen.Options[0].Text = "Get %them_addict% out of my sight."
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{You pull %addict% out of the barrel and throw %them_addict% to the ground. %They_addict% wobbles there as though the earth was a staircase and %they_addict% was looking down the top step\'s precipice.%SPEECH_ON%Oy, sir, careful, it\'s just down and down!%SPEECH_OFF%At first you think to kick %their_addict% arse, but relent. You crouch and set down next to the %person_addict% as %they_addict% rolls over to stare at the clouds. Time passes, and after a while %addict% purses %their_addict% lips and you can see clarity has returned to %their_addict% eyes.%SPEECH_ON%I got a problem, sir.%SPEECH_OFF%You nod and tell %them_addict% to ease up on the potions, that you can\'t trust %them_addict% in this state. If %they're_addict% got a problem with being a sellsword, if that\'s why %they're_addict% like this, then that\'s okay, but it is a problem. %They_addict% purses %their_addict% lips again and nods.%SPEECH_ON%Thank you, sir. I\'ll do my best to unfark myself and set things straight.%SPEECH_OFF%}";
		});
		::Legends.Screens.hook(this, "D", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_05.png[/img]{You pull %addict% out of the barrel and throw %them_addict% to the ground. %They_addict% wobbles there as though the earth was a staircase and %they_addict% was looking down the top step\'s precipice.%SPEECH_ON%Oy, sir, careful, it\'s just down and down!%SPEECH_OFF%At first you think to kick %their_addict% arse, but relent. You crouch and set down next to the %person_addict% as %they_addict% rolls over to stare at the clouds. After a while %they_addict% looks over.%SPEECH_ON%You trying to help me?%SPEECH_OFF%You nod and say you are, but %addict% simply smiles and shakes %their_addict% head.%SPEECH_ON%Ain\'t talking to you, I\'m talking to you!%SPEECH_OFF%%They_addict% points behind you at the barrel, and by the time you look back the %person_addict% is up to %their_addict% feet and charging forward.%SPEECH_ON%Fat sumbitch gon\' be smart with me huh!%SPEECH_OFF%The sellsword tackles the barrel and it splinters from top to bottom and a number of items within spill out and shatter. A few mercenaries rush over and get the %person_addict% and take %them_addict% away while you count what\'s been lost.}";
		});
	}
});